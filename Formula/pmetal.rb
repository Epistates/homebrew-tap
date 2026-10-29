class Pmetal < Formula
  desc "High-performance LLM fine-tuning & inference framework for Apple Silicon"
  homepage "https://github.com/epistates/pmetal"
  url "https://github.com/epistates/pmetal/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "3f5ef45bc37fc17c5c638ac28b805fe7898fd8962a6fb0d66d4de31eb422e2bb"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/epistates/pmetal.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "rust" => :build
  # The Metal compiler builds MLX's kernels.
  depends_on xcode: ["16.0", :build]
  depends_on arch: :arm64
  # MLX's floor, and the deployment target pmetal builds for.
  depends_on macos: :sonoma

  # MLX is built from source during the cargo build (CMake FetchContent, at
  # the upstream commit pmetal pins) and linked into the binary. The CLI
  # embeds its mlx.metallib and extracts it on first run to
  # ~/.cache/pmetal/lib/mlx-<revision>-<sha256>.metallib, one file per MLX build.

  def install
    # Link MLX into the binary. A release build otherwise produces
    # libmlx.dylib and stamps its own absolute build path as the install name;
    # `cargo install` then discards that build directory, leaving an installed
    # binary that cannot resolve its own dependency.
    ENV["PMETAL_MLX_STATIC"] = "1"

    # MACOSX_DEPLOYMENT_TARGET stays unset (superenv clears it): pmetal's
    # build scripts set macOS 14 for MLX and the binary themselves. In the
    # environment it reaches every proc-macro dylib as well, and on macOS 27
    # with the Xcode 27 linker dyld refuses to load those, so the build fails
    # with "can't find crate".

    # serve/mcp are opt-in features so library consumers don't inherit axum and
    # the MCP SDK, but a user-facing install is expected to carry `pmetal serve` and
    # `pmetal mcp`. This matches what the GitHub release binary ships.
    system "cargo", "install", *std_cargo_args(path: "crates/pmetal"), "--features", "serve,mcp"
  end

  def caveats
    <<~EOS
      pmetal requires Apple Silicon (M1 or later).

      Quick start:
        pmetal infer --model Qwen/Qwen3-0.6B --prompt "Hello"
        pmetal train --model Qwen/Qwen3-0.6B --dataset data.jsonl
        pmetal dashboard

      Sampling presets from the model card (Qwen3.5):
        pmetal infer --model Qwen/Qwen3.5-0.8B --mode thinking-general --prompt "..."
        pmetal infer --model Qwen/Qwen3.5-0.8B --mode thinking-coding --prompt "..."

      OpenAI-compatible server and MCP server are both included:
        pmetal serve --model Qwen/Qwen3-0.6B --port 8080
        pmetal mcp

      Full docs: https://github.com/epistates/pmetal
    EOS
  end

  test do
    assert_match "pmetal", shell_output("#{bin}/pmetal --version")

    # MLX is inside the binary, not a dylib in a build tree that is gone.
    refute_match "libmlx", shell_output("otool -L #{bin}/pmetal")

    # The binary starts and loads MLX's kernels from the metallib it embeds.
    info = JSON.parse(shell_output("#{bin}/pmetal info --json"))
    metallib = info.dig("mlx", "metallib")
    assert_path_exists metallib
    assert_equal info.dig("mlx", "metallib_sha256"), Digest::SHA256.file(metallib).hexdigest
  end
end

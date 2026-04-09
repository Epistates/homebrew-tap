class Pmetal < Formula
  desc "High-performance LLM fine-tuning & inference framework for Apple Silicon"
  homepage "https://github.com/epistates/pmetal"
  url "https://github.com/epistates/pmetal/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "PLACEHOLDER"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/epistates/pmetal.git", branch: "main"

  depends_on "rust" => :build
  depends_on "cmake" => :build
  depends_on :macos
  # Xcode CLT with Metal compiler required for building MLX C++ and Metal shaders
  depends_on :xcode => ["16.0", :build]

  # MLX C++ is built from source during cargo build via CMake FetchContent.
  # The resulting mlx.metallib is cached to ~/.cache/pmetal/lib/ for reuse.
  # Future: download prebuilt libmlx.dylib from GitHub releases to skip C++ build.

  def install
    ENV["MACOSX_DEPLOYMENT_TARGET"] = MacOS.version.to_s

    system "cargo", "install", "--path", "crates/pmetal",
           "--root", prefix,
           "--locked"
  end

  def caveats
    <<~EOS
      pmetal requires Apple Silicon (M1 or later).

      Quick start:
        pmetal infer --model Qwen/Qwen3-0.6B --prompt "Hello"
        pmetal train --model Qwen/Qwen3-0.6B --dataset data.jsonl
        pmetal dashboard

      Sampling modes (Qwen3.5):
        pmetal infer --model Qwen/Qwen3.5-0.8B --mode thinking --prompt "..."
        pmetal infer --model Qwen/Qwen3.5-0.8B --mode coding --prompt "..."

      Full docs: https://github.com/epistates/pmetal
    EOS
  end

  test do
    assert_match "pmetal", shell_output("#{bin}/pmetal --version")
  end
end

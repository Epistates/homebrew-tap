class Pmetal < Formula
  desc "High-performance LLM fine-tuning framework for Apple Silicon"
  homepage "https://github.com/epistates/pmetal"
  url "https://github.com/epistates/pmetal/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "build", "--release", "--bin", "pmetal",
           "--manifest-path", "crates/pmetal-cli/Cargo.toml"
    bin.install "target/release/pmetal"
  end

  test do
    assert_match "pmetal", shell_output("#{bin}/pmetal --version")
  end
end

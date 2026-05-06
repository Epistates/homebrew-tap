class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  version "0.2.7"
  license "MIT"

  depends_on macos: :sonoma

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Server-arm64-apple-darwin"
      sha256 "c60d30d396daea83502705b208980d66159929a5f9b592e07344bfd789516fb0"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "f99702b7d30eb14f47dad0e49bcf03429751aa268d4d0c566555d2cfb92d2807"
    end
  end

  def install
    binary = Dir["MCPSafari-*"].first || "mcp-safari"
    bin.install binary => "mcp-safari"
  end

  test do
    assert_predicate bin/"mcp-safari", :executable?
  end
end

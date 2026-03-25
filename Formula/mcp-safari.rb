class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.2/MCPSafari-Server-arm64-apple-darwin"
      sha256 "de0d71c2f388c09df0a3c95718e56b6779c0db8be0c607e425bc65054bac02c4"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.2/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "e952266b11751fb7ddd106f9291ee5df472cb4da4b549f587f35f54c1cd8b8c2"
    end
  end

  depends_on :macos

  def install
    binary = Dir["MCPSafari-*"].first || "mcp-safari"
    bin.install binary => "mcp-safari"
  end

  test do
    assert_predicate bin/"mcp-safari", :executable?
  end
end

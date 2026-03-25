class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.1/MCPSafari-arm64-apple-darwin"
      sha256 "e4f5c32c8c6eba342f47ad7cb4688233a9db2944e198a7589c30d964d3652b54"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.1/MCPSafari-x86_64-apple-darwin"
      sha256 "21d00ed858aac64bb53e17100bb1a524bcaf0320135952b98be0966ea15ed64a"
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

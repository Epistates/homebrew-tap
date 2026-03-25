class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.3/MCPSafari-Server-arm64-apple-darwin"
      sha256 "95d3cc88002cac6e097283e816d12601fe76b717045765cf1cb1cfbde9a465c4"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.3/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "5e18c7b9ab4058b63827caed12a55337fb1393bb89c7747918d7efae0205d99d"
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

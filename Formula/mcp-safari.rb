class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  version "0.2.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.5/MCPSafari-Server-arm64-apple-darwin"
      sha256 "c2cc938068cde12f1ba4e9da5d8005c5ad7fca7c472749120e80f89d24d49152"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.5/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "c9d7d318ef113c120914aff3b4e1426801352ba371047249c0cd78d1863f9a99"
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

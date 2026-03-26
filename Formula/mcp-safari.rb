class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  version "0.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.4/MCPSafari-Server-arm64-apple-darwin"
      sha256 "36d152f16c739ce19466cab414cdbf646ba85e9138b04138561231d5ea5146c9"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.4/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "072565fb86b94fa0f5c4fe981deebc6d5e28b3d1907f443796debc4bc31bbaa5"
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

class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  license "MIT"

  depends_on macos: :sonoma

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.9/MCPSafari-Server-arm64-apple-darwin"
      sha256 "60085a4543c0f2cf31ed88cfff500319dc282b37c26b506a69bb650356fb54c6"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.9/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "c4bd6b5d7432fddc011de3eea14206bfd551e932908a3bf0045918b2333b167f"
    end
  end

  def install
    binary = Dir["MCPSafari-*"].first || "mcp-safari"
    bin.install binary => "mcp-safari"
    (bin/"mcp-safari").chmod 0755
  end

  test do
    assert_predicate bin/"mcp-safari", :executable?
  end
end

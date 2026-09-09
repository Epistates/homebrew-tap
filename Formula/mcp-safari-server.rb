class McpSafariServer < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  license "MIT"

  depends_on macos: :sonoma

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.3.0/MCPSafari-Server-arm64-apple-darwin"
      sha256 "9ce41e475a4f06105bf6e33292af38c484a7f6d3c29ef708619177e21225c29f"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.3.0/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "d70d71f2e92a9536c16471b7890d6bf5bb10e71691e92a160437f971c3826500"
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

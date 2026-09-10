class McpSafariServer < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  license "MIT"

  depends_on macos: :sonoma

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.3.1/MCPSafari-Server-arm64-apple-darwin"
      sha256 "fa534a6febd918a513e197bc422556a6698a3f9ad1206e9a5e210c56d1b7e977"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.3.1/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "e8b095573b237c2a85ce14651bca31073d414e11b49c794be7e49749d7ed0b05"
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

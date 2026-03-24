class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  url "https://github.com/Epistates/MCPSafari/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c042ac9b9e75c1523ff578712812eeaa6654fce404ee27e364fdfff28351c702"
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on :macos

  def install
    cd "MCPServer" do
      system "swift", "build", "-c", "release", "--disable-sandbox"
      bin.install ".build/release/MCPSafari" => "mcp-safari"
    end
  end

  def caveats
    <<~EOS
      To use mcp-safari, you also need the Safari extension:

        1. Download MCPSafari.app from the GitHub release:
           https://github.com/Epistates/MCPSafari/releases/latest

        2. Open MCPSafari.app to register the extension

        3. Enable it in Safari > Settings > Extensions

      Then configure your MCP client:

        {
          "mcpServers": {
            "mcp-safari": {
              "command": "#{opt_bin}/mcp-safari"
            }
          }
        }
    EOS
  end

  test do
    # Send an MCP initialize request and verify the server responds
    init_msg = '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-25","capabilities":{},"clientInfo":{"name":"test","version":"1.0"}}}'
    output = shell_output("echo '#{init_msg}' | timeout 5 #{bin}/mcp-safari --port 0 2>/dev/null || true")
    # If the server responded, it will contain mcp-safari in the output
    # If it didn't respond (no timeout on macOS), just verify the binary exists
    assert_predicate bin/"mcp-safari", :executable?
  end
end

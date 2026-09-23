class McpSafariServer < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  license "MIT"

  depends_on macos: :sonoma

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.3.2/MCPSafari-Server-arm64-apple-darwin"
      sha256 "c999b846f3012666285fe7a02460a4b8d02c00fb88a1fb366f9aaa17749ab4d8"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.3.2/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "11e3fa9e69157f681d088efce7b407afb8cbd28a1195a81c14990342792eefcc"
    end
  end

  def install
    binary = Dir["MCPSafari-*"].first || "mcp-safari"
    bin.install binary => "mcp-safari"
    (bin/"mcp-safari").chmod 0755
  end

  test do
    require "json"
    require "timeout"

    IO.popen([bin/"mcp-safari", "--port", free_port.to_s], "r+") do |server|
      request = {
        jsonrpc: "2.0", id: 1, method: "initialize",
        params: { protocolVersion: "2025-11-25", capabilities: {},
                  clientInfo: { name: "homebrew-test", version: "1.0" } }
      }
      server.puts JSON.generate(request)
      server.flush
      response = Timeout.timeout(15) { JSON.parse(server.readline) }
      assert_equal "mcp-safari", response.dig("result", "serverInfo", "name")
    ensure
      begin
        Process.kill("TERM", server.pid)
      rescue Errno::ESRCH
        nil
      end
    end
  end
end

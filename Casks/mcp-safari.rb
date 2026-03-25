cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.3"
  sha256 arm:   "0cdf8ce1a74380cc46a96578130b797452ac3f7692f9160d9412530e076a3b1f",
         intel: "7739cc322c9f46a8ae6a74a0d073b387a8423b4a576bcb869ef1ddda0449f19f"

  url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Extension-#{arch}.tar.gz"
  name "MCPSafari"
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"

  depends_on macos: ">= :sonoma"
  depends_on formula: "epistates/tap/mcp-safari"

  app "MCPSafari.app"

  postflight do
    system_command "/usr/bin/open", args: ["/Applications/MCPSafari.app"]
  end

  caveats <<~EOS
    Enable the extension in Safari > Settings > Extensions > MCPSafari Extension.

    Configure your MCP client:

      {
        "mcpServers": {
          "mcp-safari": {
            "command": "mcp-safari"
          }
        }
      }
  EOS
end

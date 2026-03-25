cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.0"
  sha256 arm:   "4d1e52ff911829702361c1b17c1b47122f10180dff51f0c7fb6b0000d7bee37b",
         intel: "f5f0f48f7c7ca27c31164b25b2c334cf4c375312103ef79bcf3446876047f2b6"

  url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-#{arch}.tar.gz"
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

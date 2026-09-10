cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.3.1"
  sha256 arm:   "ab6ff5dab6aea02f67df35c966e1a1272941f9b74ae9cab29e97ca08ea38cb2d",
         intel: "ee14b97a7350ee9f15de42a2c50cd5a7252abc97b0f9e2a20cffb2ebda5d4845"

  url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Extension-#{arch}.tar.gz"
  name "MCPSafari"
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"

  depends_on formula: "epistates/tap/mcp-safari-server"
  depends_on macos: :sonoma

  app "MCPSafari.app"

  preflight_steps do
    # Kill running servers so the upgrade can replace the binary cleanly
    terminate_process "mcp-safari", match: :full
  end

  zap trash: [
    "~/.config/mcp-safari",
    "~/Library/Application Support/MCPSafari",
  ]

  caveats <<~EOS
    Open MCPSafari.app once so Safari picks up the extension, then enable it in
    Safari > Settings > Extensions > MCPSafari Extension.

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

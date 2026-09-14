cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.3.2"
  sha256 arm:   "1e096262d921f89ef6a86a70b27cf6c3419a6872618a015eb52e3c769efd54e1",
         intel: "09b49a98e570a9ac5f1bf71e3bb8ad48aa5e4bebff50ffeaccb7e451894287fb"

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

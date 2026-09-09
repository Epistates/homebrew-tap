cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.3.0"
  sha256 arm:   "826e928f11da4c08d91699d64ee8869cec85c55210a60b5391fb4f9766599421",
         intel: "416f7ee0a5b389ea5003c9550581f68263500f846924babc56af25fb96a2bd8a"

  url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Extension-#{arch}.tar.gz"
  name "MCPSafari"
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"

  depends_on macos: :sonoma
  depends_on formula: "epistates/tap/mcp-safari-server"

  app "MCPSafari.app"

  preflight_steps do
    # Kill running servers so the upgrade can replace the binary cleanly
    terminate_process "mcp-safari", match: :full
  end

  postflight_steps do
    # Safari only registers the extension once the container app has run.
    # Resolved through LaunchServices so a custom appdir still works.
    run "/usr/bin/open", args: ["-a", "MCPSafari"]
  end

  zap trash: [
    "~/.config/mcp-safari",
    "~/Library/Application Support/MCPSafari",
  ]

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

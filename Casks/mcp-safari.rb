cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.6"
  sha256 arm:   "e83440c2185761f9d826d782da6ceced6eba7b75040751be04d4396504a2ae08",
         intel: "945bf77dad3370f20b64918bbeea33b297389e7202d19f92592e00423c876e19"

  url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Extension-#{arch}.tar.gz"
  name "MCPSafari"
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"

  depends_on macos: ">= :sonoma"
  depends_on formula: "epistates/tap/mcp-safari"

  app "MCPSafari.app"

  preflight do
    # Kill running servers so the upgrade can replace the binary cleanly
    system_command "/usr/bin/pkill", args: ["-f", "mcp-safari"], must_succeed: false
  end

  postflight do
    system_command "/usr/bin/open", args: ["/Applications/MCPSafari.app"]
  end

  zap trash: "~/.config/mcp-safari"

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

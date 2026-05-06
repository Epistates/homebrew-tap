cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.7"
  sha256 arm:   "f923fc774029daa8e01367980de7c4a99cc6f833f111053fcdfd78bb16611a79",
         intel: "b2216c3b2890ef6a6b25c56a12ce6f2ba5e43bb36400c2d9c23a7a47796ed8f7"

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

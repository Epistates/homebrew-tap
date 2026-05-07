cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.8"
  sha256 arm:   "b0f8b8b3cf3be89f4ce2b7ad468e31192d410625383782695fea958f0424f2ef",
         intel: "f21ee7965cf83d89a86ac02a0a6d205567d55e7e7752635a43dc490a5fb57384"

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
    system_command HOMEBREW_BREW_FILE,
                   args:         ["link", "--overwrite", "epistates/tap/mcp-safari"],
                   must_succeed: false
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

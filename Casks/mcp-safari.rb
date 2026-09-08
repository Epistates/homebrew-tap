cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.9"
  sha256 arm:   "074c9487997d4bf40b4723af44093bcad3a8ac21247b8783d5347c9fc2a8c1ce",
         intel: "9983668edc3faad3a32c1c3725722aeae2892de65113ed3c05a7da2a057845e8"

  url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Extension-#{arch}.tar.gz"
  name "MCPSafari"
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"

  depends_on macos: :sonoma
  depends_on formula: "epistates/tap/mcp-safari"

  app "MCPSafari.app"

  preflight do
    # Kill running servers so the upgrade can replace the binary cleanly
    system_command "/usr/bin/pkill", args: ["-f", "mcp-safari"], must_succeed: false
  end

  postflight do
    system_command HOMEBREW_BREW_FILE.to_s,
                   args:         ["link", "--overwrite", "epistates/tap/mcp-safari"],
                   must_succeed: false
    system_command "/usr/bin/open", args: ["/Applications/MCPSafari.app"]
  end

  zap trash: [
    "~/Library/Application Support/MCPSafari",
    "~/.config/mcp-safari",
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

cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.5"
  sha256 arm:   "ae9e3833b48070d0d1679fe9856a6df8fca606fe2b58341e77c1aac82136bd5d",
         intel: "ebe73d7945a1a9a34127318e27c90041034e63f29346b7ec84872c2b10938ca9"

  url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Extension-#{arch}.tar.gz"
  name "MCPSafari"
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"

  depends_on macos: ">= :sonoma"
  depends_on formula: "epistates/tap/mcp-safari"

  preflight do
    # Kill running servers so the upgrade can replace the binary cleanly
    system_command "/usr/bin/pkill", args: ["-f", "mcp-safari"], must_succeed: false
  end

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

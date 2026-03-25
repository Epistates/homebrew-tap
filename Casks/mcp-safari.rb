cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.2"
  sha256 arm:   "8e0506506c2a302753e41ed13f0a3fde971e0f49e8b6823d1701f1f06f2a4244",
         intel: "9bc7719f0f6b3ef0f3f2ad6daf7ea1af7fc38f4ba536151f7e5c786a4c85e107"

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

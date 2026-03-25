cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.1"
  sha256 arm:   "bc9dfd863519b17f9b9f29bdd4aeb9c58534f2c0bc7a8f8ca52a927613f52cc0",
         intel: "2f4e9778594d58deec9bac70642cbda251b3963630cd49b6a3f386e2e136edd6"

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

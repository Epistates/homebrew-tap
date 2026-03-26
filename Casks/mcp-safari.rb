cask "mcp-safari" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.4"
  sha256 arm:   "672b08fb6e627172a6f2b5e1bbcf4259c3d1ac42441959f0c1e40fe9444a5214",
         intel: "ad261b37d899ab4899eb2408759e1813a52c9b27dc4fd2565c962c409f9d810c"

  url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Extension-#{arch}.tar.gz"
  name "MCPSafari"
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"

  depends_on macos: ">= :sonoma"
  depends_on formula: "epistates/tap/mcp-safari"

  preflight do
    system_command "/usr/bin/pkill", args: ["-f", "mcp-safari"], must_succeed: false
    system_command "/bin/rm", args: ["-rf", "/Applications/MCPSafari.app"], must_succeed: false
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

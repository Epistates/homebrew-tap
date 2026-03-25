class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.0/MCPSafari-arm64-apple-darwin"
      sha256 "14dc8588a9e1edc05af3ffaeb7eb80755977b6afa1338ed372bcfd9507a460b3"

      resource "extension" do
        url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.0/MCPSafari-arm64.tar.gz"
        sha256 "4d1e52ff911829702361c1b17c1b47122f10180dff51f0c7fb6b0000d7bee37b"
      end
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.0/MCPSafari-x86_64-apple-darwin"
      sha256 "f5f9c331e11126340fb91cbeb81557c561d1067d44ea3f73f88492d6f32d8a4a"

      resource "extension" do
        url "https://github.com/Epistates/MCPSafari/releases/download/v0.2.0/MCPSafari-x86_64.tar.gz"
        sha256 "f5f0f48f7c7ca27c31164b25b2c334cf4c375312103ef79bcf3446876047f2b6"
      end
    end
  end

  depends_on :macos

  def install
    binary = Dir["MCPSafari-*"].first || "mcp-safari"
    bin.install binary => "mcp-safari"

    resource("extension").stage do
      staged = Pathname.pwd
      system "cp", "-pR", staged.to_s, "#{prefix}/MCPSafari.app"
    end
  end

  def post_install
    system "open", "#{prefix}/MCPSafari.app"
  end

  def caveats
    <<~EOS
      The MCPSafari extension app has been installed and opened.
      Enable it in Safari > Settings > Extensions > MCPSafari Extension.

      Configure your MCP client:

        {
          "mcpServers": {
            "mcp-safari": {
              "command": "#{opt_bin}/mcp-safari"
            }
          }
        }
    EOS
  end

  test do
    assert_predicate bin/"mcp-safari", :executable?
  end
end

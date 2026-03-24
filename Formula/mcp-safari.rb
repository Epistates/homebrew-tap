class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.1.0/MCPSafari-arm64-apple-darwin"
      sha256 "9d7bbc40afdcf4ab053f8242f1910c8f64367d073ead5198d51e744da8482102"

      resource "extension" do
        url "https://github.com/Epistates/MCPSafari/releases/download/v0.1.0/MCPSafari-arm64.tar.gz"
        sha256 "72fc36cefde6a0eb407fe460a8900cc7b3ffd09874a62d79c5ce1f2e0ecf5d2c"
      end
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v0.1.0/MCPSafari-x86_64-apple-darwin"
      sha256 "9fc97ab7c1c01b2b573e32a2619d34193bc56a9a0902bd7b7f26687342454576"

      resource "extension" do
        url "https://github.com/Epistates/MCPSafari/releases/download/v0.1.0/MCPSafari-x86_64.tar.gz"
        sha256 "1e1f40c6564d0dfab1d56bdf380891c623ebe97e7c3e20f1cf39b0c9abc87e90"
      end
    end
  end

  depends_on :macos

  def install
    # The bare binary download lands in the staging dir with its original filename
    binary = Dir["MCPSafari-*"].first || "mcp-safari"
    bin.install binary => "mcp-safari"

    # Extract the Safari extension app bundle.
    # Homebrew's resource.stage strips the single top-level directory (MCPSafari.app),
    # so inside the block we are already inside the app bundle (Contents/ is here).
    # We need to copy the staged directory itself as MCPSafari.app.
    resource("extension").stage do
      staged = Pathname.pwd
      system "cp", "-pR", staged.to_s, "#{prefix}/MCPSafari.app"
    end
  end

  def post_install
    # Open the app to register the extension with Safari
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

class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  version "0.2.8"
  license "MIT"

  depends_on macos: :sonoma

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Server-arm64-apple-darwin"
      sha256 "78b5126a0c2cd26e892bfa23225124565d8b28a9b61893d9d3e4b887732248df"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "a139cbcad5e9adb890fb1571739ae566153b34fc05cdfc54919a9d0a8335c831"
    end
  end

  def install
    binary = Dir["MCPSafari-*"].first || "mcp-safari"
    bin.install binary => "mcp-safari"
  end

  test do
    assert_predicate bin/"mcp-safari", :executable?
  end
end

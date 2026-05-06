class McpSafari < Formula
  desc "Native Safari browser automation via the Model Context Protocol"
  homepage "https://github.com/Epistates/MCPSafari"
  version "0.2.6"
  license "MIT"

  depends_on macos: :sonoma

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Server-arm64-apple-darwin"
      sha256 "dc40c3da1e841f2472a0e2a32fe075c8d9036c92996c82c5a5ba5773301c6c4a"
    else
      url "https://github.com/Epistates/MCPSafari/releases/download/v#{version}/MCPSafari-Server-x86_64-apple-darwin"
      sha256 "3b6713c638e66f3fd29385ef4d33a23d934f9c048abd84206c78615eda163783"
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

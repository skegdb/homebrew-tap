class SkegTui < Formula
  desc "Terminal UI for skeg (htop-style dashboard)"
  homepage "https://github.com/skegdb/skeg-tui"
  version "0.1.0"
  license "Apache-2.0"

  # aarch64 only. Matches the engine's target list.
  depends_on arch: :arm64

  on_macos do
    url "https://github.com/skegdb/skeg-tui/releases/download/v#{version}/skeg-tui-v#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "PLACEHOLDER_AARCH64_DARWIN"
  end

  on_linux do
    url "https://github.com/skegdb/skeg-tui/releases/download/v#{version}/skeg-tui-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "PLACEHOLDER_AARCH64_LINUX"
  end

  def install
    bin.install "skeg-top"
  end

  test do
    # TUI exits non-zero without a tty; just check the binary runs and
    # supports --version.
    assert_match version.to_s, shell_output("#{bin}/skeg-top --version 2>&1")
  end
end

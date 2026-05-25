class SkegCli < Formula
  desc "Command-line tool for skeg (offline index builder, inspector)"
  homepage "https://github.com/skegdb/skeg-cli"
  version "0.1.0"
  license "Apache-2.0"

  # aarch64 only. Links skeg-vector with NEON SIMD path.
  depends_on arch: :arm64

  on_macos do
    url "https://github.com/skegdb/skeg-cli/releases/download/v#{version}/skeg-cli-v#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "PLACEHOLDER_AARCH64_DARWIN"
  end

  on_linux do
    url "https://github.com/skegdb/skeg-cli/releases/download/v#{version}/skeg-cli-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "PLACEHOLDER_AARCH64_LINUX"
  end

  def install
    bin.install "skeg-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skeg-cli --version")
  end
end

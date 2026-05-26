class SkegCli < Formula
  desc "Operator tools for skeg (build, inspect, stats)"
  homepage "https://github.com/skegdb/skeg-cli"
  version "0.1.1"
  license "Apache-2.0"

  # aarch64 only. skeg-cli links skeg-vector, whose distance kernels are
  # NEON; an x86_64 build would fall back to the scalar path and is not
  # representative of the published benchmark numbers.
  depends_on arch: :arm64

  if OS.mac?
    url "https://github.com/skegdb/skeg-cli/releases/download/v0.1.1/skeg-cli-v0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "ae24fdd06aef424f4d1630b3625f9ac41e93f58b033f039ee2b064e07cab2c46"
  elsif OS.linux?
    url "https://github.com/skegdb/skeg-cli/releases/download/v#{version}/skeg-cli-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "7871380cfc24eedc594df443bdd09a967b0bf67a52574a69e8a8b0f637813081"
  end

  def install
    bin.install "skeg-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skeg-cli --version")
  end
end

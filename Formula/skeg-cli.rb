class SkegCli < Formula
  desc "Operator tools for skeg (build, inspect, stats)"
  homepage "https://github.com/skegdb/skeg-cli"
  version "0.1.0"
  license "Apache-2.0"

  # aarch64 only. skeg-cli links skeg-vector, whose distance kernels are
  # NEON; an x86_64 build would fall back to the scalar path and is not
  # representative of the published benchmark numbers.
  depends_on arch: :arm64

  if OS.mac?
    url "https://github.com/skegdb/skeg-cli/releases/download/v#{version}/skeg-cli-v#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "ed6b4372f28c87885f52448589f47dcd17cbbc8d2fe5745595a625ff5d396ecd"
  elsif OS.linux?
    url "https://github.com/skegdb/skeg-cli/releases/download/v#{version}/skeg-cli-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "5f7a67e0fc37f017c1a5c0ad4a95f8dba999e75518b6d9b2b70d436b314e37bd"
  end

  def install
    bin.install "skeg-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skeg-cli --version")
  end
end

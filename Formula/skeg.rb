class Skeg < Formula
  desc "RAM-frugal KV + vector store for Personal AI inference"
  homepage "https://github.com/skegdb/skeg"
  version "0.6.1"
  license "Apache-2.0"

  # aarch64 only. NEON SIMD path; x86_64 fallback is scalar and not
  # representative of the published bench numbers.
  depends_on arch: :arm64

  if OS.mac?
    url "https://github.com/skegdb/skeg/releases/download/v#{version}/skeg-v#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "21844bf1d7d6c715fd9ad77463781eb0d12ef96a40e3ca20aafeae1196ebd957"
  elsif OS.linux?
    url "https://github.com/skegdb/skeg/releases/download/v#{version}/skeg-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "da70b5fbed36fb2a103c68e3fd0079fd3b6c3962b819d2974000a680a6844217"
  end

  def install
    bin.install "skeg"
    bin.install "skeg-resp3" if File.exist?("skeg-resp3")
  end

  service do
    run [opt_bin/"skeg", "--mode", "serve"]
    keep_alive true
    log_path var/"log/skeg.log"
    error_log_path var/"log/skeg.err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skeg --version")
  end
end

class Skeg < Formula
  desc "RAM-frugal KV + vector store for Personal AI inference"
  homepage "https://github.com/skegdb/skeg"
  version "0.3.4"
  license "Apache-2.0"

  # aarch64 only. NEON SIMD path; x86_64 fallback is scalar and not
  # representative of the published bench numbers.
  depends_on arch: :arm64

  if OS.mac?
    url "https://github.com/skegdb/skeg/releases/download/v#{version}/skeg-v#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "5695165c9ba64bde7f173b4393b0ab4709cf2ed2f1333d2c8e15d3b2894d3971"
  elsif OS.linux?
    url "https://github.com/skegdb/skeg/releases/download/v#{version}/skeg-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "7db7dd6c5e502d6243125c71bc48fa20021c616600ad43002943bdba254a786e"
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

class Skeg < Formula
  desc "RAM-frugal KV + vector store for Personal AI inference"
  homepage "https://github.com/skegdb/skeg"
  version "0.1.0"
  license "Apache-2.0"

  # aarch64 only. NEON SIMD path; x86_64 fallback is scalar and not
  # representative of the published bench numbers.
  depends_on arch: :arm64

  on_macos do
    url "https://github.com/skegdb/skeg/releases/download/v#{version}/skeg-v#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "9237ec451e1bcd882471c1fbbaa9354dff7e6f332542d9f90d059f913cb3b5f4"
  end

  on_linux do
    url "https://github.com/skegdb/skeg/releases/download/v#{version}/skeg-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "2c79f278d4cacf99d441fb266c11afdbaa3f54d23f7bc91690f7bc863d5e8529"
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

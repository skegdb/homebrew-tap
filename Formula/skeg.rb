class Skeg < Formula
  desc "RAM-frugal KV + vector store for Personal AI inference"
  homepage "https://github.com/skegdb/skeg"
  version "0.4.0"
  license "Apache-2.0"

  # aarch64 only. NEON SIMD path; x86_64 fallback is scalar and not
  # representative of the published bench numbers.
  depends_on arch: :arm64

  if OS.mac?
    url "https://github.com/skegdb/skeg/releases/download/v#{version}/skeg-v#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "672b45d63356e612e412a90a9e6eda1368726359c1299bcc9c9be9e800467626"
  elsif OS.linux?
    url "https://github.com/skegdb/skeg/releases/download/v#{version}/skeg-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "20168292a82a9581cac8eeb50d78f4c4fc913827c3088935e0e703377834fd08"
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

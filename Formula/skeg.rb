class Skeg < Formula
  desc "RAM-frugal KV + vector store for Personal AI inference"
  homepage "https://github.com/skegdb/skeg"
  version "0.2.0"
  license "Apache-2.0"

  # aarch64 only. NEON SIMD path; x86_64 fallback is scalar and not
  # representative of the published bench numbers.
  depends_on arch: :arm64

  if OS.mac?
    url "https://github.com/skegdb/skeg/releases/download/v#{version}/skeg-v#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "8ed43dbe1d0e140d0cd2d028d022f534d76b913dbcec78ffed7f894a70090eb0"
  elsif OS.linux?
    url "https://github.com/skegdb/skeg/releases/download/v#{version}/skeg-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "efe92537371d3ae496874a6f94757abf2e1f45c67eb5dc93d38e1c4a31914279"
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

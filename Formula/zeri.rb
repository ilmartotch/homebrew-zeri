class Zeri < Formula
  desc "Modular, language-aware terminal REPL"
  homepage "https://github.com/ilmartotch/ReplZeriEmgine"
  version "0.1.2-test-alpha"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ilmartotch/ReplZeriEmgine/releases/download/v0.1.2-test-alpha/zeri-macos-arm64.tar.gz"
      sha256 "359491fa7ca7c81e59eeec20c56720c153d08f51f003b9f4308b23def5c2b850"
    else
      odie "Zeri supports only macOS arm64 in this formula"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/ilmartotch/ReplZeriEmgine/releases/download/v0.1.2-test-alpha/zeri-linux-amd64.tar.gz"
      sha256 "fb664c8d3b5200ae4983dbdff5cd94a40965d6729ec7a98c7bd0d3dba4df6246"
    else
      odie "Zeri supports only Linux x64 in this formula"
    end
  end

  def install
    bin.install "zeri"
    bin.install "zeri-engine"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zeri --version")
  end
end



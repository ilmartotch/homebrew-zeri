# typed: false
# frozen_string_literal: true

class Zeri < Formula
  desc "TUI multi-language REPL with offline AI context"
  homepage "https://github.com/ilmartotch/ZeriReplEngine"
  version "1.0.1-alpha" # zeri:version
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ilmartotch/ZeriReplEngine/releases/download/v#{version}/zeri-macos-arm64.tar.gz"
      sha256 "c95e634707817505e7dba64743b67b1988300f3971c4c78259c0341fc67a6707" # zeri:sha256:macos
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ilmartotch/ZeriReplEngine/releases/download/v#{version}/zeri-linux-amd64.tar.gz"
      sha256 "776e9f988298f41e5c5af6fd9e08f410da1c768c413e4113f53dddaaf254da3c" # zeri:sha256:linux
    end
  end

  def install
    libexec.install "zeri", "zeri-engine", "runtime", "help", "version.txt"
    chmod 0755, libexec/"zeri"
    chmod 0755, libexec/"zeri-engine"
    (bin/"zeri").write_env_script libexec/"zeri",
      ZERI_ENGINE_PATH: libexec/"zeri-engine"
  end

  def caveats
    <<~EOS
      Language runtimes are optional — install any you want to use:
        Python:  brew install python@3
        Bun:     brew install oven-sh/bun/bun
        LuaJIT:  brew install luajit
        Ruby:    brew install ruby

      Custom paths: ZERI_PYTHON_PATH, ZERI_BUN_PATH, ZERI_LUAJIT_PATH, ZERI_RUBY_PATH
      For AI context ($ai): https://ollama.com

      Zeri stores its first-run state and data under:
        macOS:  ~/Library/Application Support/zeri
        Linux:  ${XDG_CONFIG_HOME:-~/.config}/zeri
      Homebrew does not remove this on uninstall. To replay the first-run setup
      without deleting your scripts and sessions, run:
        zeri --reset-onboarding
      To remove everything, delete the directory above.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zeri --version")
  end
end

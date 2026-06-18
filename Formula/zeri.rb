# typed: false
# frozen_string_literal: true

class Zeri < Formula
  desc "TUI multi-language REPL with offline AI context"
  homepage "https://github.com/ilmartotch/ZeriReplEngine"
  version "1.0.0-alpha" # zeri:version
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ilmartotch/ZeriReplEngine/releases/download/v#{version}/zeri-macos-arm64.tar.gz"
      sha256 "b425d5c87d544b6d9511afbd48b2209a439e6a538d801cb00d437ca6f70cf750" # zeri:sha256:macos
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ilmartotch/ZeriReplEngine/releases/download/v#{version}/zeri-linux-amd64.tar.gz"
      sha256 "8840cb86e14ae2a0ec61af29b24793aaa9fb542909d05e9643044bbff51ae27f" # zeri:sha256:linux
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

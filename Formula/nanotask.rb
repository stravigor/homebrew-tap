class Nanotask < Formula
  desc "Console kanban & sprint board with Tron TUI aesthetic"
  homepage "https://github.com/stravigor/nanotask"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/stravigor/nanotask/releases/download/v#{version}/nanotask-#{version}-darwin-arm64.tar.gz"
      sha256 "26e92354bf619a88d52249274f7a15447550a4a4734bf6031c9745c2db3db1a5"
    else
      url "https://github.com/stravigor/nanotask/releases/download/v#{version}/nanotask-#{version}-darwin-x64.tar.gz"
      sha256 "a5228f1b669c927ee487a5fda6d598b39b66ac9cc74841b7b662e928427cc767"
    end
  end

  on_linux do
    url "https://github.com/stravigor/nanotask/releases/download/v#{version}/nanotask-#{version}-linux-x64.tar.gz"
    sha256 "9c2e80f6963c315ace0c8b7b1b9c2c52171d82959abea4335d31564cba0b4adc"
  end

  def install
    # The tarball contains a single binary named nanotask-{version}-{platform}
    # Find it and install as "nanotask"
    binary = Dir.glob("nanotask-*").first
    bin.install binary => "nanotask"
  end

  test do
    # nanotask requires a git repo; just check it exits with an error message
    output = shell_output("#{bin}/nanotask 2>&1", 1)
    assert_match "git repository", output
  end
end

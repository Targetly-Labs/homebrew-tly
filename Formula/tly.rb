class Tly < Formula
  desc "Targetly CLI - Deploy and manage your containerized applications"
  homepage "https://github.com/Targetly-Labs/homebrew-tly"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Targetly-Labs/homebrew-tly/releases/download/v#{version}/targetly-darwin-arm64-#{version}.tar.gz"
      sha256 "eed39c5fd0936fe72f01b3be7390422eb82a6583ad866d39c8816481027f2d69"
    else
      url "https://github.com/Targetly-Labs/homebrew-tly/releases/download/v#{version}/targetly-darwin-amd64-#{version}.tar.gz"
      sha256 "5427bf7525fffa4ba320514458498a60692f4aee1ac8ea03f83531a1e1f43861"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Targetly-Labs/homebrew-tly/releases/download/v#{version}/targetly-linux-arm64-#{version}.tar.gz"
      sha256 "6e74c925fe8ba3265e58a43a440166cb5b2725b8ad09cf48da6716fb574611bd"
    else
      url "https://github.com/Targetly-Labs/homebrew-tly/releases/download/v#{version}/targetly-linux-amd64-#{version}.tar.gz"
      sha256 "fcdc84146eaa56194441d777c3b246736dbb76abdc91aee4967102e54836b3c4"
    end
  end

  def install
    # Homebrew automatically strips single root directories from archives
    # So we can reference the binary directly
    bin.install "tly"
  end

  test do
    system "#{bin}/tly", "--version"
  end
end

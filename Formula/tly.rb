class Tly < Formula
  desc "Targetly CLI - Deploy and manage your containerized applications"
  homepage "https://github.com/Targetly-Labs/brew-tly"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Targetly-Labs/brew-tly/releases/download/v#{version}/targetly-darwin-arm64-#{version}.tar.gz"
      sha256 "bcdc81c22e7760da7315d586cf80b54d48eb8f4e2b781efbb7d185a63e9c02f8"
    else
      url "https://github.com/Targetly-Labs/brew-tly/releases/download/v#{version}/targetly-darwin-amd64-#{version}.tar.gz"
      sha256 "ea8cd7e68dede6e7b03c65a1d35a7949c9ce7f9f0ea082cff0a5d5b597e98db2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Targetly-Labs/brew-tly/releases/download/v#{version}/targetly-linux-arm64-#{version}.tar.gz"
      sha256 "bda52cc071fc7e4513855bc453ddb0b67105f6318a05eaf7f53c5280f8622ce1"
    else
      url "https://github.com/Targetly-Labs/brew-tly/releases/download/v#{version}/targetly-linux-amd64-#{version}.tar.gz"
      sha256 "bcb04825f4e8c963f98794b7f9ae4cf8fac754acaac7cc45a9ccc1fd27985f94"
    end
  end

  def install
    # The archive contains a directory named targetly-{platform}-{version}/
    # We need to cd into it to access the binaries
    prefix_dir = "targetly-#{OS.mac? ? "darwin" : "linux"}-#{Hardware::CPU.arch}-#{version}"
    bin.install "#{prefix_dir}/tly"
  end

  test do
    system "#{bin}/tly", "--version"
  end
end

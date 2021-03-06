require "language/go"

class DataDonationDownloader < Formula
  desc "Data donation Downloader"
  homepage "https://github.com/bitmark-inc/data-donation-downloader"
  url "https://github.com/bitmark-inc/data-donation-downloader/archive/0.2.tar.gz"
  sha256 "82fb5209207786edb5870f7dc81882f8798de22abb7f2afcd1031fbe9ff3d6aa"
  head "https://github.com/bitmark-inc/data-donation-downloader.git"

  depends_on "go" => :build

  go_resource "github.com/lemonlatte/go-registry" do
    url "https://github.com/lemonlatte/go-registry.git",
        :revision => "514f07b65417994af6ef37b5ac93c3cb6c269ca4"
  end

  go_resource "github.com/bitmark-inc/bitmarkd" do
    url "https://github.com/bitmark-inc/bitmarkd.git",
        :revision => "24d6d6e0c1ed7407f86e7fc577f7327e14918b45"
  end

  go_resource "github.com/bitmark-inc/go-bitmarklib" do
    url "https://github.com/bitmark-inc/go-bitmarklib.git",
        :revision => "5f4e12b9aae8af5a52af6bdd9394fb8616335a76"
  end

  go_resource "github.com/sirupsen/logrus" do
    url "https://github.com/sirupsen/logrus.git",
        :revision => "89742aefa4b206dcf400792f3bd35b542998eb3b"
  end

  go_resource "golang.org/x/crypto" do
    url "https://go.googlesource.com/crypto.git",
        :revision => "81e90905daefcd6fd217b62423c0908922eadb30"
  end

  go_resource "golang.org/x/sys" do
    url "https://go.googlesource.com/sys.git",
        :revision => "9aade4d3a3b7e6d876cd3823ad20ec45fc035402"
  end

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p "src/github.com/bitmark-inc"
    ln_s buildpath, "src/github.com/bitmark-inc/data-donation-downloader"
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "-o", "data-donation-downloader", "-ldflags", "-X main.version=#{version}"
    bin.install "data-donation-downloader"
  end

  test do
    system bin/"data-donation-downloader", "-version"
  end
end

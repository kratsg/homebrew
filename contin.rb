class Contin < Formula
  desc "Some clever description here"
  homepage "http://s-provencher.com/pages/contin-cd.shtml"
  url "http://s-provencher.com/pub/contin-cd/contin-cd.for.gz"
  version "1.0.0"
  sha256 "57bfad6621edc351dfd2fe7627aa78b39d5d8b963ee18d621e8fce314f2dfb53"

  depends_on "gcc"

  def install
    system ENV.fc, "-o", "contin-cd", "contin-cd.for"
    bin.install "contin-cd"
  end

  test do
    system "false"
  end
end

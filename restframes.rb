class Restframes < Formula
  desc "particle physics event analysis library"
  homepage "http://restframes.com/"
  url "https://github.com/crogan/RestFrames/archive/29271bc.tar.gz"
  version "-1.5"
  sha256 "ce2064c3846f68c14ac26533235e0b6c4a5d9d20a16f24bd2c4313a653020720"

  depends_on "root6" => :recommended
  depends_on "root" if build.without? "root6"

  def install
    # inreplace Dir["src/Makefile.am", "src/Makefile.in"] do |s|
    #  s.gsub! "$(libdir)/libRestFrames.rootmap", "sbin/libRestFrames.rootmap"
    #  s.gsub! "$(libdir)/RestFrames_Dict_rdict.pcm", "sbin/RestFrames_Dict_rdict.pcm"
    # end

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    doc.install Dir["doc/*"]
    (share+"examples/#{name}").install Dir["examples/*.C"]
  end

  def caveats; <<-EOS.undent
    Because RestFrames depends on several installation-dependent
    environment variables to function properly, you should
    add the following commands to your shell initialization
    script (.bashrc/.profile/etc.), or call them directly
    before using RestFrames.

    For bash users:
      . $(brew --prefix restframes)/libexec/setup_RestFrames.sh
    For zsh users:
      pushd $(brew --prefix restframes) >/dev/null; . libexec/setup_RestFrames.sh; popd >/dev/null
    For csh/tcsh users:
      source `brew --prefix restframes`/libexec/setup_RestFrames.csh
    EOS
  end

  test do
    #    (testpath/"test.C").write <<-EOS.undent
    #      #include <iostream>
    #      void test() {
    #        std::cout << "Hello, world!" << std::endl;
    #      }
    #    EOS
    #    (testpath/"test.bash").write <<-EOS.undent
    #      . #{libexec}/thisroot.sh
    #      root -l -b -n -q test.C
    #    EOS
    #    assert_equal "\nProcessing test.C...\nHello, world!\n",
    #      `/bin/bash test.bash`
  end
end

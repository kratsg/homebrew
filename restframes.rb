# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Restframes < Formula
  desc ""
  homepage "http://restframes.com/"
  url "https://github.com/crogan/RestFrames/tarball/master"
  sha256 "d3635b335adc518edd1030d64691b9bae1cca9548e6785d6da219ad5bd826bc3"
  version "1"

  # depends_on "cmake" => :build
  depends_on "root" # depends on root5

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test RestFrames`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
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

end

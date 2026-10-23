class Radmind < Formula
  desc "Tools and server for remotely administering Unix file systems"
  homepage "https://github.com/Radmind/radmind"
  url "https://github.com/Radmind/radmind/releases/download/radmind-1.15.0/radmind-1.15.0.tar.gz"
  sha256 "c434825bd25e24adbd3bc208dba6a8d59321581cb32c97163b365e0a0501645a"
  license "BSD-3-Clause"

  depends_on "openssl@3"

  def install
    openssl = formula_opt_prefix("openssl@3")
    ENV.append "CPPFLAGS", "-I#{openssl}/include"
    ENV.append "LDFLAGS", "-L#{openssl}/lib"
    ENV.prepend_path "PKG_CONFIG_PATH", openssl/"lib/pkgconfig"

    system "./configure", "--prefix=#{prefix}", "--with-radminddir=#{var}/radmind"
    system "make", "install"
  end

  test do
    system bin/"fsdiff", "-c", "sha1", "-K", File::NULL, testpath
  end
end

class Radmind < Formula
  desc "Tools and server for remotely administering Unix file systems"
  homepage "https://github.com/Radmind/radmind"
  url "https://github.com/Radmind/radmind/releases/download/radmind-1.15.0/radmind-1.15.0.tar.gz"
  sha256 "a4607ca809bff5203e90509deef76d314d40eef4c16eb4bbae3c353688ee4aa0"
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

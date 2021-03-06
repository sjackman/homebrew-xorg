class Xrdb < Formula
  desc "X.Org Applications: xrdb"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrdb-1.1.1.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/app/xrdb-1.1.1.tar.bz2"
  sha256 "2d23ade7cdbb487996bf77cbb32cbe9bdb34d004748a53de7a4a97660d2217b7"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "b757c0f4e01304477307e288365c4d438b2f6014ad66cdcb0b9e44a7aa5c2338" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/libxmu"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    # --with-cpp=path  # comma-separated list of paths to cpp command for xrdb to use at runtime

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end

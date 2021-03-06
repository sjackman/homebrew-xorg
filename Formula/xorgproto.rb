class Xorgproto < Formula
  desc "X.Org Protocol Headers"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2018.4.tar.bz2"
  sha256 "fee885e0512899ea5280c593fdb2735beb1693ad170c22ebcc844470eec415a0"
  head "git://anongit.freedesktop.org/git/xorg/proto/xorgproto"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "92ad849e710e96bb03cfb276e72ef74aab92291045bf487ec2d1e376d160363c" => :x86_64_linux
  end

  if build.head?
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "pkg-config" => [:build, :test]

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    if build.head?
      ENV["NOCONFIGURE"] = "1"
      system "./autogen.sh"
    end

    system "./configure", *args
    system "make", "install"
  end

  test do
    assert_equal "-I#{include}", shell_output("pkg-config --cflags xproto").chomp
    assert_equal "-I#{include}/X11/dri", shell_output("pkg-config --cflags xf86driproto").chomp
  end
end

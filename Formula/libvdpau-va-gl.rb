class LibvdpauVaGl < Formula
  desc "VDPAU driver for hardware that supports VAAPI"
  homepage "https://www.freedesktop.org/wiki/Software/VDPAU/"
  url "https://github.com/i-rinat/libvdpau-va-gl/releases/download/v0.3.6/libvdpau-va-gl-0.3.6.tar.gz"
  sha256 "35fa95359ca79e15079e3b1ada089db799c7d789a99b5f497e28ca1d85dd91c4"

  # option "without-test", "Skip compile-time tests"

  # Build-time
  depends_on "cmake" => :build
  depends_on "ffmpeg" => :build
  depends_on "glib" => :build
  depends_on "pkg-config" => :build # libswscale

  # Required
  depends_on "linuxbrew/xorg/glu"
  depends_on "linuxbrew/xorg/libva"
  depends_on "linuxbrew/xorg/libvdpau"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << ".."

    (buildpath/"build").mkpath
    cd "build" do
      system "cmake", *args
      system "make"
      # system "make", "check" if build.with?("test") ### currently tests fail with:
      # X11 connection rejected because of wrong authentication
      system "make", "install"
    end
  end
end

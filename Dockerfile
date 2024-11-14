FROM fedora:41

RUN dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-41.noarch.rpm
# Install necessary dependencies
RUN dnf update -y && \
  dnf clean all -y && \
  dnf install -y \
  git \
  gcc \
  make \
  meson \
  pkgconfig \
  libva-devel \
  libdrm-devel \
  libX11-devel \
  libXext-devel \
  libXfixes-devel \
  wayland-devel \
  libgudev1-devel \
  egl-wayland-devel \
  mesa-libEGL-devel \
  mesa-libGL-devel \
  egl-utils \
  libva-devel \
  gstreamer1-plugins-bad-free-libs \
  gstreamer1-plugins-bad-free-devel \
  gstreamer1-plugins-bad-freeworld \
  nv-codec-headers

# Clone the nvidia-vaapi-driver repository
RUN git clone https://github.com/elFarto/nvidia-vaapi-driver.git

WORKDIR /nvidia-vaapi-driver

# Build the project
RUN meson setup build && \
  meson install -C build

RUN mkdir /output
COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]

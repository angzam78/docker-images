#! /bin/sh

URL=https://repo.download.nvidia.com/jetson/t210/pool/main/n/
ARCH=arm64

KERNEL="${URL}/nvidia-l4t-kernel/nvidia-l4t-kernel_4.9.253-tegra-32.7.2-20220420143418_arm64.deb"
FIRMWARE="${URL}/nvidia-l4t-firmware/nvidia-l4t-firmware_32.7.2-20220420143418_arm64.deb"
FIRMWARE_XUSB="${URL}/nvidia-l4t-xusb-firmware/nvidia-l4t-xusb-firmware_32.7.2-20220420143418_arm64.deb"

HEADERS="${URL}"

URLS="${KERNEL} ${FIRMWARE} ${FIRMWARE_XUSB}"

docker build -t "angzam78/linuxkit-kernel:l4t" -f Dockerfile --no-cache --build-arg URLS="${URLS}" .
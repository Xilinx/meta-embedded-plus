DESCRIPTION = "A minimal image for Embedded Plus."

inherit core-image

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302-xrt = "${MACHINE}"
COMPATIBLE_MACHINE:emb-plus-ve2302-amr = "${MACHINE}"

IMAGE_INSTALL = " \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    packagegroup-core-boot \
    kernel-modules \
    linux-xlnx-udev-rules \
    mtd-utils \
    pciutils \
    run-postinsts \
    udev-extraconf \
    lrzsz \
    iperf3 \
    netperf \
    ethtool \
    phytool \
    tcpdump \
    util-linux \
    libgpiod \
    libgpiod-tools \
    i2c-tools \
"


# TODO: Temporarily disable packages that depend on zocl because
# these modules do not build with the 6.18 kernel. Re-enable them once
# zocl is buildable with the 6.18 kernel.
#    zocl,xrt and soft-kernel-daemon

XRT_INSTALL = " \
     apu-boot \
     init-apu \
"
IMAGE_INSTALL:append:emb-plus-ve2302-xrt = " ${XRT_INSTALL}"

IMAGE_FSTYPES:emb-plus-ve2302-amr = "cpio.lzma cpio.lzma.u-boot"
IMAGE_FSTYPES:emb-plus-ve2302-xrt = "cpio.lzma cpio.lzma.u-boot"


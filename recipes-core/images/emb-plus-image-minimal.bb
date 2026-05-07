SUMMARY = "Minimal bring-up image for AMD Embedded+ Versal boards."
DESCRIPTION = "A minimal image for Embedded Plus."

inherit core-image

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302-xrt = "${MACHINE}"
COMPATIBLE_MACHINE:emb-plus-ve2302-amr = "${MACHINE}"
COMPATIBLE_MACHINE:alveo-v80-amr = "${MACHINE}"

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

# Adding fpgautil as a workaround until the AMR stack solution is available 
IMAGE_INSTALL:append:emb-plus-ve2302-amr = " \
    fpga-manager-script \
"

XRT_INSTALL = " \
     xrt \
     zocl \
     apu-boot \
     init-apu \
     soft-kernel-daemon \
"
IMAGE_INSTALL:append:emb-plus-ve2302-xrt = " ${XRT_INSTALL}"

IMAGE_FSTYPES:emb-plus-ve2302-amr = "cpio.lzma cpio.lzma.u-boot"
IMAGE_FSTYPES:emb-plus-ve2302-xrt = "cpio.lzma cpio.lzma.u-boot"


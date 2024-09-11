DESCRIPTION = "A minimal image for Embedded Plus."

inherit core-image

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302 = "${MACHINE}"
COMPATIBLE_MACHINE:emb-plus-ve2302-sdt = "${MACHINE}"

IMAGE_INSTALL = " \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    packagegroup-core-boot \
    kernel-modules \
    xrt \
    zocl \
    linux-xlnx-udev-rules \
    mtd-utils \
    pciutils \
    run-postinsts \
    udev-extraconf \
    apu-boot \
    init-apu \
    soft-kernel-daemon \
    lrzsz \
    libopencv-core \
    libopencv-imgcodecs \
    libopencv-imgproc \
"

DESCRIPTION = "A minimal image for RAVE."

inherit core-image

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:versal-rave = "${MACHINE}"

IMAGE_FEATURES += "ssh-server-openssh hwcodecs package-management"

IMAGE_INSTALL = " \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    packagegroup-core-boot \
    kernel-modules \
    \
    e2fsprogs-mke2fs \
    fpga-manager-script \
    libdfx \
    linux-xlnx-udev-rules \
    mtd-utils \
    nfs-utils \
    nfs-utils-client \
    pciutils \
    run-postinsts \
    u-boot-tools \
    udev-extraconf \
    apu-boot \
    init-apu \
    skd \
"

DESCRIPTION = "A minimal image for RAVE."

inherit core-image

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:versal-rave = "${MACHINE}"

IMAGE_FEATURES += "ssh-server-openssh hwcodecs package-management"

IMAGE_INSTALL = " \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    packagegroup-core-boot \
    kernel-modules \
    xrt \
    zocl \
    dfx-mgr \
    libdfx \
    linux-xlnx-udev-rules \
    mtd-utils \
    pciutils \
    run-postinsts \
    udev-extraconf \
    apu-boot \
    init-apu \
    soft-kernel-daemon \
"

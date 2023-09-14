DESCRIPTION = "Boot image for RAVE containing ATF, u-boot, boot.scr, Linux and rootfs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS += "\
    bootgen-native \
    rave-image-minimal \
    u-boot-xlnx-scr \
    virtual/arm-trusted-firmware \
    virtual/bootloader \
    virtual/dtb \
    virtual/kernel \
    "

inherit deploy image-artifact-names

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:versal-rave = "versal-rave"

do_configure:append () {
cat > ${WORKDIR}/${PN}.bif << EOF
    all:
    {
        id_code = 0x14ca8093
        extended_id_code = 0x01
        image { 
            id = 0x1c000000, name=apu_subsystem
            { core=a72-0, exception_level=el-3, trustzone, file=${DEPLOY_DIR_IMAGE}/arm-trusted-firmware.elf }
            { core=a72-0, exception_level=el-2, file=${DEPLOY_DIR_IMAGE}/u-boot.elf }
            { load=0x4000000, file=${DEPLOY_DIR_IMAGE}/rave-image-minimal-versal-rave.cpio.gz.u-boot }
            { load=0x2000000, file=${DEPLOY_DIR_IMAGE}/boot.scr }
            { load=0x200000, file=${DEPLOY_DIR_IMAGE}/Image }
            { load=0x1000, file=${DEPLOY_DIR_IMAGE}/system.dtb }
        }
    }
EOF
}

do_compile[depends] += " \
    virtual/bootloader:do_deploy \
    virtual/arm-trusted-firmware:do_deploy \
    rave-image-minimal:do_image_complete \
    u-boot-xlnx-scr:do_deploy \
    virtual/kernel:do_deploy \
    virtual/dtb:do_deploy \
    "

do_compile () {
    bootgen -image ${WORKDIR}/${PN}.bif -arch ${SOC_FAMILY} -w -o ${B}/${IMAGE_NAME}.bin
}

do_deploy () {
    install -Dm 0644 ${B}/${IMAGE_NAME}.bin ${DEPLOYDIR}/${IMAGE_NAME}.bin
    ln -sf ${IMAGE_NAME}.bin ${DEPLOYDIR}/${PN}-${MACHINE}.bin
}

addtask deploy after do_compile

SUMMARY = "Combined APU boot image (TF-A + U-Boot + boot.scr + Linux + \
rootfs) for AMD Embedded+ boards."
DESCRIPTION = "Boot image for RAVE containing ATF, u-boot, boot.scr, \
Linux and rootfs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

BIF_ROOTFS = "emb-plus-image-minimal"

BIF_ROOTFS_TYPE = "cpio.gz.u-boot"

BIF_ROOTFS_TYPE:emb-plus-ve2302-amr = "cpio.lzma.u-boot"

BIF_ROOTFS_TYPE:emb-plus-ve2302-xrt = "cpio.lzma.u-boot"

BIF_ROOTFS_NAME = "${BIF_ROOTFS}-${MACHINE}.rootfs.${BIF_ROOTFS_TYPE}"

DEPENDS += "\
    bootgen-native \
    ${BIF_ROOTFS} \
    ${UBOOT_BOOT_SCRIPT} \
    virtual/arm-trusted-firmware \
    virtual/bootloader \
    virtual/dtb \
    virtual/kernel \
    xclbinutil-native \
    "

inherit deploy image-artifact-names bootgen-bif

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302-xrt = "emb-plus-ve2302-xrt"
COMPATIBLE_MACHINE:emb-plus-ve2302-amr = "emb-plus-ve2302-amr"
COMPATIBLE_MACHINE:alveo-v80-amr = "alveo-v80-amr"

BIF_FILE_PATH = "${B}/${PN}.bif"

BIF_TOPLEVEL_ATTR = "id_code extended_id_code"
BIF_TOPLEVEL_ATTR[id_code] = "${EMB_PLUS_ID_CODE}"
BIF_TOPLEVEL_ATTR[extended_id_code] = "0x01"

EMB_PLUS_ID_CODE ?= ""
EMB_PLUS_ID_CODE:emb-plus-ve2302-xrt = "0x14cc8093"
EMB_PLUS_ID_CODE:emb-plus-ve2302-amr = "0x14cc8093"
EMB_PLUS_ID_CODE:alveo-v80-amr = "0x14d2f093"

# Subsystem ID for APU partitions (overlay CDO redefines for AMR)
EMB_PLUS_APU_SUBSYSTEM_ID ?= ""
EMB_PLUS_APU_SUBSYSTEM_ID:emb-plus-ve2302-xrt = "0x1c000000"
EMB_PLUS_APU_SUBSYSTEM_ID:emb-plus-ve2302-amr = "0x1c000008"
EMB_PLUS_APU_SUBSYSTEM_ID:alveo-v80-amr = "0x1c000008"

BIF_PARTITION_ATTR = "atf uboot rootfs bootscr kernel dtb"
BIF_PARTITION_NAME[0x1c000000] = "apu_subsystem"
BIF_PARTITION_NAME[0x1c000008] = "apu_subsystem"

BIF_PARTITION_ATTR[atf] = "core=a72-0, exception_level=el-3, trustzone"
BIF_PARTITION_IMAGE[atf] = "${DEPLOY_DIR_IMAGE}/arm-trusted-firmware.elf"
BIF_PARTITION_ID[atf] = "${EMB_PLUS_APU_SUBSYSTEM_ID}"

BIF_PARTITION_ATTR[uboot] = "core=a72-0, exception_level=el-2"
BIF_PARTITION_IMAGE[uboot] = "${DEPLOY_DIR_IMAGE}/u-boot.elf"
BIF_PARTITION_ID[uboot] = "${EMB_PLUS_APU_SUBSYSTEM_ID}"

BIF_PARTITION_ATTR[rootfs] = "load=${EMB_PLUS_ROOTFS_ADDR}"
BIF_PARTITION_IMAGE[rootfs] = "${DEPLOY_DIR_IMAGE}/${BIF_ROOTFS_NAME}"
BIF_PARTITION_ID[rootfs] = "${EMB_PLUS_APU_SUBSYSTEM_ID}"

BIF_PARTITION_ATTR[bootscr] = "load=${EMB_PLUS_BOOTSCR_ADDR}"
BIF_PARTITION_IMAGE[bootscr] = "${DEPLOY_DIR_IMAGE}/boot.scr"
BIF_PARTITION_ID[bootscr] = "${EMB_PLUS_APU_SUBSYSTEM_ID}"

BIF_PARTITION_ATTR[kernel] = "load=${EMB_PLUS_KERNEL_ADDR}"
BIF_PARTITION_IMAGE[kernel] = "${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}"
BIF_PARTITION_ID[kernel] = "${EMB_PLUS_APU_SUBSYSTEM_ID}"

BIF_PARTITION_ATTR[dtb] = "load=${EMB_PLUS_DTB_ADDR}"
BIF_PARTITION_IMAGE[dtb] = "${DEPLOY_DIR_IMAGE}/system.dtb"
BIF_PARTITION_ID[dtb] = "${EMB_PLUS_APU_SUBSYSTEM_ID}"

EMB_PLUS_ROOTFS_ADDR ?= ""
EMB_PLUS_ROOTFS_ADDR:emb-plus-ve2302-xrt = "0x4000000"
EMB_PLUS_ROOTFS_ADDR:emb-plus-ve2302-amr = "0x20800000"
EMB_PLUS_ROOTFS_ADDR:alveo-v80-amr = "0x20800000"

EMB_PLUS_BOOTSCR_ADDR ?= "0x20000000"

EMB_PLUS_KERNEL_ADDR ?= ""
EMB_PLUS_KERNEL_ADDR:emb-plus-ve2302-xrt = "0x200000"
EMB_PLUS_KERNEL_ADDR:emb-plus-ve2302-amr = "0x19000000"
EMB_PLUS_KERNEL_ADDR:alveo-v80-amr = "0x19000000"

EMB_PLUS_DTB_ADDR ?= ""
EMB_PLUS_DTB_ADDR:emb-plus-ve2302-xrt = "0x1000"
EMB_PLUS_DTB_ADDR:emb-plus-ve2302-amr = "0x1F400000"
EMB_PLUS_DTB_ADDR:alveo-v80-amr = "0x1F400000"

python do_generate_bif() {
    # Skip file copy for all partitions to preserve full paths in the BIF.
    # Using basenames causes bootgen to choke on "Image" (reserved keyword).
    partitions = (d.getVar("BIF_PARTITION_ATTR") or "").split()
    bootgen_bif_generate(d, skip_check=partitions)
}

do_generate_bif[vardeps] += "\
    BIF_FILE_PATH \
    BIF_PARTITION_ATTR \
    BIF_PARTITION_ID \
    BIF_PARTITION_IMAGE \
    BIF_PARTITION_NAME \
    BIF_TOPLEVEL_ATTR \
    EMB_PLUS_APU_SUBSYSTEM_ID \
    EMB_PLUS_BOOTSCR_ADDR \
    EMB_PLUS_DTB_ADDR \
    EMB_PLUS_ID_CODE \
    EMB_PLUS_KERNEL_ADDR \
    EMB_PLUS_ROOTFS_ADDR \
"

do_generate_bif[depends] += " \
    virtual/bootloader:do_deploy \
    virtual/arm-trusted-firmware:do_deploy \
    ${BIF_ROOTFS}:do_image_complete \
    ${UBOOT_BOOT_SCRIPT}:do_deploy \
    virtual/kernel:do_deploy \
    virtual/dtb:do_deploy \
    "

addtask do_generate_bif after do_configure before do_compile

do_compile () {
    bootgen -image ${BIF_FILE_PATH} -arch ${BOOTGEN_ARCH} -w -o ${B}/${IMAGE_NAME}.bin
    xclbinutil --add-section PDI:RAW:${B}/${IMAGE_NAME}.bin -o ${B}/${IMAGE_NAME}.xsabin
}

do_deploy () {
    install -Dm 0644 ${B}/${IMAGE_NAME}.bin ${DEPLOYDIR}/${IMAGE_NAME}.bin
    ln -sf ${IMAGE_NAME}.bin ${DEPLOYDIR}/${PN}-${MACHINE}.bin
    install -Dm 0644 ${B}/${IMAGE_NAME}.xsabin ${DEPLOYDIR}/${IMAGE_NAME}.xsabin
    ln -sf ${IMAGE_NAME}.xsabin ${DEPLOYDIR}/${PN}-${MACHINE}.xsabin
}

addtask deploy after do_compile

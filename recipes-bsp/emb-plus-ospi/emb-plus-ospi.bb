DESCRIPTION = "Generate an OSPI image for the Embedded Plus platform"
SUMMARY = "OSPI image includes FPT and A/B images"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "virtual/boot-bin main-fpt xclbinutil-native partition-metadata"

inherit deploy image-artifact-names amd_versal_image

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302 = "${MACHINE}"

OSPI_IMAGE_NAME = "XilinxRave_OspiImage"

OSPI_IMAGE_VERSION ?= ""
OSPI_IMAGE_VERSION:emb-plus-ve2302 = "1.0"

do_compile[depends] += "main-fpt:do_deploy"

do_xsabin[depends] += "partition-metadata:do_deploy"

do_xsabin () {
    xclbinutil --force --input ${DEPLOY_DIR_IMAGE}/partition-metadata-${MACHINE}.xsabin \
        --add-section PDI:RAW:${B}/${PN}.bin --output ${B}/${PN}.xsabin
}

do_deploy () {
    install -Dm 644 ${B}/${PN}.bin ${DEPLOYDIR}/${IMAGE_NAME}.bin
    ln -s ${IMAGE_NAME}.bin ${DEPLOYDIR}/${IMAGE_LINK_NAME}.bin
    install -Dm 644 ${B}/${PN}.xsabin ${DEPLOYDIR}/${IMAGE_NAME}.xsabin
    ln -s ${IMAGE_NAME}.xsabin ${DEPLOYDIR}/${IMAGE_LINK_NAME}.xsabin
}

addtask xsabin after do_compile
addtask deploy after do_xsabin

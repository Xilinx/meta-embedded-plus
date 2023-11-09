DESCRIPTION = "Generate an OSPI image for the RAVE platform"
SUMMARY = "OSPI image includes FPT and A/B images"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "virtual/boot-bin main-fpt"

inherit deploy image-artifact-names amd_versal_image

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:versal-rave = "${MACHINE}"

OSPI_IMAGE_NAME = "XilinxRave_OspiImage"

OSPI_IMAGE_VERSION ?= ""
OSPI_IMAGE_VERSION:versal-rave = "1.0"

do_compile[depends] += "main-fpt:do_deploy"

do_deploy () {
    install -Dm 644 ${B}/${IMAGE_NAME}.bin ${DEPLOYDIR}/${IMAGE_NAME}.bin
    ln -s ${IMAGE_NAME}.bin ${DEPLOYDIR}/${IMAGE_LINK_NAME}.bin
}

#addtask manifest after do_compile
addtask deploy after do_compile

DESCRIPTION = "Generate the partition metadata binary for Embedded Plus"
SUMMARY = "Generate the partition metadata using xclbinutil for Embedded Plus"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

COMPATIBLE_MACHINE = ""
COMPATIBLE_MACHINE:embedded-plus-ve2302 = "${MACHINE}"

DEPENDS += "virtual/hdf unzip-native xclbinutil-native"

XSA_FILE ?= "${DEPLOY_DIR_IMAGE}/Xilinx-${MACHINE}.xsa"
PARTMETA_FILE ?= "partition_metadata.json"

do_compile[depends] += "virtual/hdf:do_deploy"

inherit deploy image-artifact-names

do_compile() {
    [ ! -e ${XSA_FILE} ] && bbfatal "Unable to find XSA file: ${XSA_FILE}"

    unzip -j "${XSA_FILE}" "project/${PARTMETA_FILE}"

    xclbinutil --add-section PARTITION_METADATA:JSON:${PARTMETA_FILE} \
        -o ${WORKDIR}/${PN}.xsabin --force
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -Dm 0644 ${PARTMETA_FILE} ${DEPLOYDIR}/${PARTMETA_FILE}
    install -Dm 0644 ${WORKDIR}/${PN}.xsabin ${DEPLOYDIR}/${IMAGE_NAME}.xsabin
    ln -sf ${IMAGE_NAME}.xsabin ${DEPLOYDIR}/${IMAGE_LINK_NAME}.xsabin
}

addtask do_deploy after do_compile

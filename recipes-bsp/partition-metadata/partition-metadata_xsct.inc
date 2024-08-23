# For XSCT builds

DEPENDS += "virtual/hdf unzip-native"
COMPATIBLE_MACHINE:emb-plus-ve2302 = "${MACHINE}"

XSA_FILE ?= "${DEPLOY_DIR_IMAGE}/Xilinx-${MACHINE}.xsa"

do_compile[depends] += "virtual/hdf:do_deploy"

do_compile:prepend() {
    [ ! -e ${XSA_FILE} ] && bbfatal "Unable to find XSA file: ${XSA_FILE}"
    unzip -p "${XSA_FILE}" "project/${PARTMETA_FILE}" > ${MACHINE}_${PARTMETA_FILE}

    xclbinutil --add-section PARTITION_METADATA:JSON:${MACHINE}_${PARTMETA_FILE} \
        -o ${WORKDIR}/${PN}.xsabin --force
}
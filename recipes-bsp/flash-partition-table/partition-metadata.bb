DESCRIPTION = "Generate the partition metadata binary for RAVE"
SUMMARY = "Generate the partition metadata using xclbinutil for RAVE"

require rave-boot-fw-gen.inc

COMPATIBLE_MACHINE:versal-rave = "${MACHINE}"

DEPENDS = "xclbinutil-native"

S = "${WORKDIR}/git"

inherit deploy image-artifact-names

do_compile () {
    xclbinutil --add-section PARTITION_METADATA:JSON:${S}/metadata/rave_ivh/partition_metadata.json \
        -o ${WORKDIR}/${PN}.xsabin --force
}

do_deploy () {
    install -Dm 0644 ${WORKDIR}/${PN}.xsabin ${DEPLOYDIR}/${IMAGE_NAME}.xsabin
    ln -sf ${IMAGE_NAME}.xsabin ${DEPLOYDIR}/${IMAGE_LINK_NAME}.xsabin
}

addtask deploy after do_compile
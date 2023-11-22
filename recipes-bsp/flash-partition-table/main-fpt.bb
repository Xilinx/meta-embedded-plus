DESCRIPTION = "Generate the main FPT for RAVE"
SUMMARY = "Generate the main flash partition table for RAVE"

require rave-boot-fw-gen.inc

COMPATIBLE_MACHINE:versal-rave = "${MACHINE}"

DEPENDS = "python3"

S = "${WORKDIR}/git"

inherit deploy image-artifact-names

do_compile () {
    ${S}/gen_fpt_bin.py --fpt ${S}/metadata/rave_ivh/main_fpt.json --output ${WORKDIR}/${PN}.bin
}

do_deploy () {
    install -Dm 0644 ${WORKDIR}/${PN}.bin ${DEPLOYDIR}/${IMAGE_NAME}.bin
    ln -sf ${IMAGE_NAME}.bin ${DEPLOYDIR}/${IMAGE_LINK_NAME}.bin
}

addtask deploy after do_compile

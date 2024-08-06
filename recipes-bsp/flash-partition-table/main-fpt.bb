DESCRIPTION = "Generate the main FPT for Embedded Plus"
SUMMARY = "Generate the main flash partition table for Embedded Plus"

require emb-plus-boot-fw-gen.inc

IMAGE_NAME_SUFFIX = ""

COMPATIBLE_MACHINE:emb-plus-ve2302 = "${MACHINE}"

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

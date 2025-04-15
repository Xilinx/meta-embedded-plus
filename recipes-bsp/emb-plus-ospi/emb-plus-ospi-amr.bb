DESCRIPTION = "Embedded-Plus AMR OSPI images"
SUMMARY = "Adaptive Management Runtime(AMR) compoment"

inherit python3native deploy

require recipes-bsp/amr/amr.inc

INHIBIT_DEFAULT_DEPS = "1"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302-amr = "${MACHINE}"

S = "${WORKDIR}/git/fw/AMC"

DEPENDS += "amcfw amr-fpt xilinx-bootbin"

do_configure[noexec] = "1"
do_install[noexec] = "1"

do_compile[depends] += "amcfw:do_deploy amr-fpt:do_deploy xilinx-bootbin:do_deploy"

do_compile() {
    ${PYTHON} ${S}/scripts/fpt_pdi_gen.py \
        --fpt ${DEPLOY_DIR_IMAGE}/amr-fpt-${MACHINE}.bin \
        --pdi ${DEPLOY_DIR_IMAGE}/BOOT-${MACHINE}.bin \
        --output ${WORKDIR}/${PN}.bin
}

do_deploy() {
    install -Dm 644 ${WORKDIR}/${PN}.bin ${DEPLOYDIR}/${PN}.bin
}

addtask do_deploy after do_compile

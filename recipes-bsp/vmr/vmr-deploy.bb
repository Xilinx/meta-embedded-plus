SUMMARY = "Versal Management Runtime (VMR) firmware"
DESCRIPTION = "Management software for Versal based hardware"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302 = "emb-plus-ve2302"

VMR_FILE ?= "vmr.elf"
SRC_URI ?= "http://url/for/${VMR_FILE}"
SRC_URI[sha256sum] = "0000"

inherit deploy

do_patch[noexec] = "1"
do_configure[noexec] = "1"
do_compile[noexec] = "1"
do_install[noexec] = "1"

do_deploy() {
    install -m 0644 ${WORKDIR}/vmr.elf ${DEPLOYDIR}/vmr.elf
}

addtask do_deploy after do_unpack

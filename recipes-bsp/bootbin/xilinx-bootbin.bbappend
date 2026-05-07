BIF_FSBL_ATTR:emb-plus-ve2302-xrt = "base-pdi plmfw"
BIF_VMR_ATTR:emb-plus-ve2302-xrt = "vmr-deploy"

BIF_FPT_ATTR:emb-plus-ve2302-xrt = "extension-fpt"
BIF_META_ATTR:emb-plus-ve2302-xrt = "partition-metadata"

# specify BIF partition attributes for VMR
BIF_PARTITION_ATTR[vmr-deploy] = "core=r5-0"
BIF_PARTITION_IMAGE[vmr-deploy] = "${DEPLOY_DIR_IMAGE}/vmr.elf"
BIF_PARTITION_ID[vmr-deploy] = "0x1c000000, name=rpu_subsystem, delay_handoff"

# specify BIF partition attributes for ext_fpt
BIF_PARTITION_ATTR[extension-fpt] = "type=raw, load=0x5FBF0000"
BIF_PARTITION_IMAGE[extension-fpt] = "${DEPLOY_DIR_IMAGE}/extension-fpt-${MACHINE}.bin"
BIF_PARTITION_ID[extension-fpt] = "0x1c000000, name=rpu_subsystem, delay_handoff"

# specify BIF partition attributes for ext_fpt
BIF_PARTITION_ATTR[partition-metadata] = "type=raw, load=0x5FBF2000"
BIF_PARTITION_IMAGE[partition-metadata] = "${DEPLOY_DIR_IMAGE}/partition-metadata-${MACHINE}.xsabin"
BIF_PARTITION_ID[partition-metadata] = "0x1c000000, name=rpu_subsystem, delay_handoff"

BIF_PARTITION_ATTR:emb-plus-ve2302-xrt = "${BIF_FSBL_ATTR} ${BIF_VMR_ATTR} ${BIF_FPT_ATTR} ${BIF_META_ATTR}"

BIF_FSBL_ATTR:emb-plus-ve2302-amr = "base-pdi"
BIF_AMC_ATTR:emb-plus-ve2302-amr = "amcfw"
BIF_FSBL_ATTR:alveo-v80-amr = "base-pdi"
BIF_AMC_ATTR:alveo-v80-amr = "amcfw"

# specify BIF partition attributes for VMR
BIF_PARTITION_ATTR[amcfw] = "core=r5-0"
BIF_PARTITION_IMAGE[amcfw] = "${DEPLOY_DIR_IMAGE}/amc-firmware-${MACHINE}.elf"
BIF_PARTITION_ID[amcfw] = "0x1c000006"
BIF_PARTITION_NAME[0x1c000006] = "amr_subsystem, delay_handoff"
BIF_PARTITION_ATTR:alveo-v80-amr = "${BIF_FSBL_ATTR} ${BIF_AMC_ATTR}"

BIF_PARTITION_ATTR:emb-plus-ve2302-amr = "${BIF_FSBL_ATTR} ${BIF_AMC_ATTR}"

DEPENDS:append:emb-plus-ve2302-xrt = " xclbinutil-native"

ADDN_COMPILE_DEPENDS = ""
ADDN_COMPILE_DEPENDS:emb-plus-ve2302-xrt = "vmr-deploy:do_deploy extension-fpt:do_deploy partition-metadata:do_deploy"
ADDN_COMPILE_DEPENDS:emb-plus-ve2302-amr = "amcfw:do_deploy"
ADDN_COMPILE_DEPENDS:alveo-v80-amr = "amcfw:do_deploy"

# Build hello-world for R5-1
HELLOWORLD_MCDEPENDS = ""
HELLOWORLD_MCDEPENDS:emb-plus-ve2302-amr = "mc::emb-plus-ve2302-amr-cortexr5-1-baremetal:hello-world:do_deploy"

require xilinx-bootbin-version.inc

do_compile[depends] += "${ADDN_COMPILE_DEPENDS}"
do_compile[mcdepends] += "${HELLOWORLD_MCDEPENDS}"

# Overlay CDO: merge AMR subsystem definitions into the base PDI
# before the main bootgen assembles BOOT.bin. The design BIF from
# SDT artifacts references CDO files via relative paths; bootgen
# resolves them from the BIF's directory.
AMC_CDO = "${DEPLOY_DIR_IMAGE}/amc-firmware-${MACHINE}.cdo"

AMR_OVERLAY_PDI = "${B}/base-design-overlay.pdi"

# Design BIF path within SDT sysroot (extracted from base PDI)
AMR_DESIGN_BIF = ""
AMR_DESIGN_BIF:emb-plus-ve2302-amr = "${SYSTEM_DTFILE_DIR}/extracted/ve2302_xdma_base_wrapper_1/pdi_files/ve2302_xdma_base.bif"
AMR_DESIGN_BIF:alveo-v80-amr = "${SYSTEM_DTFILE_DIR}/extracted/v80_base_wrapper_1/pdi_files/v80_base_boot.bif"

# Use overlay PDI instead of original base-pdi for AMR machines.
# Varflags can't have overrides, so use variable indirection.
EMB_PLUS_BASE_PDI_IMAGE ?= "${RECIPE_SYSROOT}/boot/base-design.pdi"
EMB_PLUS_BASE_PDI_IMAGE:emb-plus-ve2302-amr = "${AMR_OVERLAY_PDI}"
EMB_PLUS_BASE_PDI_IMAGE:alveo-v80-amr = "${AMR_OVERLAY_PDI}"
BIF_PARTITION_IMAGE[base-pdi] = "${EMB_PLUS_BASE_PDI_IMAGE}"

# Generate overlay PDI for AMR machines (skipped when AMR_DESIGN_BIF is empty)
amr_overlay_cdo() {
    [ -z "${AMR_DESIGN_BIF}" ] && return 0
    if [ ! -f "${AMC_CDO}" ]; then
        bbfatal "AMR overlay CDO not found: ${AMC_CDO}"
    fi
    if [ ! -f "${AMR_DESIGN_BIF}" ]; then
        bbfatal "Design BIF not found: ${AMR_DESIGN_BIF}"
    fi
    cd $(dirname ${AMR_DESIGN_BIF})
    bootgen -arch ${BOOTGEN_ARCH} -image $(basename ${AMR_DESIGN_BIF}) \
        -overlay_cdo ${AMC_CDO} -w -o ${AMR_OVERLAY_PDI}
}

do_amr_overlay_cdo() {
    amr_overlay_cdo
}
do_amr_overlay_cdo[depends] += "${ADDN_COMPILE_DEPENDS}"
addtask amr_overlay_cdo after do_prepare_recipe_sysroot before do_configure

do_compile:append:emb-plus-ve2302-xrt() {
    xclbinutil --force --input ${DEPLOY_DIR_IMAGE}/partition-metadata-${MACHINE}.xsabin \
        --add-section PDI:RAW:${B}/BOOT.bin --output ${B}/BOOT.xsabin
}

do_deploy:append:emb-plus-ve2302-xrt() {
    install -m 0644 ${B}/BOOT.xsabin ${DEPLOYDIR}/${BOOTBIN_BASE_NAME}.xsabin
    ln -sf ${BOOTBIN_BASE_NAME}.xsabin ${DEPLOYDIR}/BOOT-${MACHINE}.xsabin
    ln -sf ${BOOTBIN_BASE_NAME}.xsabin ${DEPLOYDIR}/boot.xsabin

    ln -sf ${BOOTBIN_BASE_NAME}.xsabin ${DEPLOYDIR}/${@d.getVar("MACHINE")}-${BOOTBIN_VER_MAIN}${IMAGE_VERSION_SUFFIX}.xsabin
}

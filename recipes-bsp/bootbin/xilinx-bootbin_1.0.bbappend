BIF_OPTIONAL_DATA:emb-plus-ve2302 = "${DEPLOY_DIR_IMAGE}/bootbin-version-string-${MACHINE}.txt, id=0x21"

BIF_FSBL_ATTR:emb-plus-ve2302 = "base-pdi plmfw"
BIF_VMR_ATTR:emb-plus-ve2302 = "vmr-deploy"

BIF_FPT_ATTR:emb-plus-ve2302 = "extension-fpt"
BIF_META_ATTR:emb-plus-ve2302 = "partition-metadata"

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

BIF_PARTITION_ATTR:emb-plus-ve2302 = "${BIF_FSBL_ATTR} ${BIF_VMR_ATTR} ${BIF_FPT_ATTR} ${BIF_META_ATTR}"

DEPENDS:append:emb-plus-ve2302 = " xclbinutil-native"

ADDN_COMPILE_DEPENDS = ""
ADDN_COMPILE_DEPENDS:emb-plus-ve2302 = "vmr-deploy:do_deploy extension-fpt:do_deploy partition-metadata:do_deploy bootbin-version-string:do_deploy"

require xilinx-bootbin-version.inc

do_compile[depends] += "${ADDN_COMPILE_DEPENDS}"

do_compile:append:emb-plus-ve2302() {
    xclbinutil --force --input ${DEPLOY_DIR_IMAGE}/partition-metadata-${MACHINE}.xsabin \
        --add-section PDI:RAW:${B}/BOOT.bin --output ${B}/BOOT.xsabin
}

do_deploy:append:emb-plus-ve2302() {
    install -m 0644 ${B}/BOOT.xsabin ${DEPLOYDIR}/${BOOTBIN_BASE_NAME}.xsabin
    ln -sf ${BOOTBIN_BASE_NAME}.xsabin ${DEPLOYDIR}/BOOT-${MACHINE}.xsabin
    ln -sf ${BOOTBIN_BASE_NAME}.xsabin ${DEPLOYDIR}/boot.xsabin

    ln -sf ${BOOTBIN_BASE_NAME}.xsabin ${DEPLOYDIR}/${@d.getVar("MACHINE")}-${BOOTBIN_VER_MAIN}${IMAGE_VERSION_SUFFIX}.xsabin
}

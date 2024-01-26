#BIF_FSBL_ATTR:embedded-plus-ve2302 = "base-pdi plmfw"
BIF_FSBL_ATTR:embedded-plus-ve2302 = "base-pdi"
BIF_VMR_ATTR:embedded-plus-ve2302 = "vmr-deploy"

BIF_FPT_ATTR:embedded-plus-ve2302 = "extension-fpt"
BIF_META_ATTR:embedded-plus-ve2302 = "partition-metadata"

# specify BIF partition attributes for VMR
BIF_PARTITION_ATTR[vmr-deploy] = "core=r5-0"
BIF_PARTITION_IMAGE[vmr-deploy] = "${DEPLOY_DIR_IMAGE}/vmr.elf"
BIF_PARTITION_ID[vmr-deploy] = "0x1c000000, name=rpu_subsystem, delay_handoff"

# specify BIF partition attributes for ext_fpt
BIF_PARTITION_ATTR[extension-fpt] = "type=raw, load=0x7FBF0000"
BIF_PARTITION_IMAGE[extension-fpt] = "${DEPLOY_DIR_IMAGE}/extension-fpt-embedded-plus-ve2302.bin"
BIF_PARTITION_ID[extension-fpt] = "0x1c000000, name=rpu_subsystem, delay_handoff"

# specify BIF partition attributes for ext_fpt
BIF_PARTITION_ATTR[partition-metadata] = "type=raw, load=0x7FBF2000"
BIF_PARTITION_IMAGE[partition-metadata] = "${DEPLOY_DIR_IMAGE}/partition-metadata-embedded-plus-ve2302.xsabin"
BIF_PARTITION_ID[partition-metadata] = "0x1c000000, name=rpu_subsystem, delay_handoff"

BIF_PARTITION_ATTR:embedded-plus-ve2302 = "${BIF_FSBL_ATTR} ${BIF_VMR_ATTR} ${BIF_FPT_ATTR} ${BIF_META_ATTR}"

ADDN_COMPILE_DEPENDS = ""
ADDN_COMPILE_DEPENDS:embedded-plus-ve2302 = "vmr-deploy:do_deploy extension-fpt:do_deploy partition-metadata:do_deploy"

do_compile[depends] += "${ADDN_COMPILE_DEPENDS}"

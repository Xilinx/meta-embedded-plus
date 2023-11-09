BIF_FSBL_ATTR:versal-rave = "base-pdi plmfw"
BIF_VMR_ATTR:versal-rave = "vmr-deploy"

BIF_FPT_ATTR:versal-rave = "extension-fpt"
BIF_META_ATTR:versal-rave = "partition-metadata"

# specify BIF partition attributes for VMR
BIF_PARTITION_ATTR[vmr-deploy] = "core=r5-0"
BIF_PARTITION_IMAGE[vmr-deploy] = "${DEPLOY_DIR_IMAGE}/vmr.elf"
BIF_PARTITION_ID[vmr-deploy] = "0x1c000000, name=rpu_subsystem, delay_handoff"

# specify BIF partition attributes for ext_fpt
BIF_PARTITION_ATTR[extension-fpt] = "type=raw, load=0x7FBF0000"
BIF_PARTITION_IMAGE[extension-fpt] = "${DEPLOY_DIR_IMAGE}/extension-fpt-versal-rave.bin"
BIF_PARTITION_ID[extension-fpt] = "0x1c000000, name=rpu_subsystem, delay_handoff"

# specify BIF partition attributes for ext_fpt
BIF_PARTITION_ATTR[partition-metadata] = "type=raw, load=0x7FBF2000"
BIF_PARTITION_IMAGE[partition-metadata] = "${DEPLOY_DIR_IMAGE}/partition-metadata-versal-rave.xsabin"
BIF_PARTITION_ID[partition-metadata] = "0x1c000000, name=rpu_subsystem, delay_handoff"

BIF_PARTITION_ATTR:versal-rave  = "${BIF_FSBL_ATTR} ${BIF_VMR_ATTR} ${BIF_FPT_ATTR} ${BIF_META_ATTR}"

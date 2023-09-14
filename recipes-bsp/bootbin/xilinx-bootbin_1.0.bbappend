BIF_FSBL_ATTR:versal-rave = "base-pdi plmfw"
#BIF_VMR_ATTR:versal-rave = "vmr"
#BIF_FPT_ATTR:versal-rave = "ext-fpt"

# specify BIF partition attributes for VMR
BIF_PARTITION_ATTR[vmr] = "core=r5-0"
BIF_PARTITION_IMAGE[vmr] = "${DEPLOY_DIR_IMAGE}/vmr.elf"
BIF_PARTITION_ID[vmr] = "0x1c000000, name=rpy_subsystem, delay_handoff"

# specify BIF partition attributes for ext_fpt
BIF_PARTITION_IMAGE[ext-fpt] = "${DEPLOY_DIR_IMAGE}/ext_fpt.bin"
BIF_PARTITION_ID[ext-fpt] = "0x1c000000, name = ext_fpt"

#BIF_PARTITION_ATTR:versal-rave  = "${BIF_FSBL_ATTR} ${BIF_VMR_ATTR} ${BIF_FPT_ATTR}"
BIF_PARTITION_ATTR:versal-rave  = "${BIF_FSBL_ATTR}"

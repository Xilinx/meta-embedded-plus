# specify BIF partition attributes for VMR app
#BIF_PARTITION_ATTR[vmr-app] ?= "core=a72-0, exception_level = el-2"
#BIF_PARTITION_IMAGE[vmr-app] ?= "${RECIPE_SYSROOT}/boot/u-boot.elf"
#BIF_PARTITION_ID[vmr-app] ?= "0x1c000000"

BIF_PARTITION_ATTR:versal-rave  = "${BIF_FSBL_ATTR}"

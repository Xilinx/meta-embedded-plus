FILESEXTRAPATHS:append := ":${THISDIR}/u-boot-xlnx-scr"

BOOTMODE:emb-plus-ve2302-xrt = ""
BOOTFILE_EXT:emb-plus-ve2302-xrt = "emb-plus"
SRC_URI:append:emb-plus-ve2302-xrt = " file://boot.cmd.emb-plus"

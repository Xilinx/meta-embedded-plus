FILESEXTRAPATHS:append := ":${THISDIR}/u-boot-xlnx-scr"

BOOTMODE:emb-plus-ve2302 = ""
BOOTFILE_EXT:emb-plus-ve2302 = "emb-plus"
SRC_URI:append:emb-plus-ve2302 = " file://boot.cmd.emb-plus"

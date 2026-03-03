FILESEXTRAPATHS:append := ":${THISDIR}/u-boot-xlnx-scr"

BOOTMODE:emb-plus-ve2302-xrt = ""
BOOTFILE_EXT:emb-plus-ve2302-xrt = "emb-plus-xrt"
SRC_URI:append:emb-plus-ve2302-xrt = " file://boot.cmd.emb-plus-xrt"

BOOTMODE:emb-plus-ve2302-amr = ""
BOOTFILE_EXT:emb-plus-ve2302-amr = "emb-plus"
SRC_URI:append:emb-plus-ve2302-amr = " file://boot.cmd.emb-plus"

BOOTMODE:alveo-v80-amr = ""
BOOTFILE_EXT:alveo-v80-amr = "emb-plus"
SRC_URI:append:alveo-v80-amr = " file://boot.cmd.emb-plus"


FILESEXTRAPATHS:append := ":${THISDIR}/u-boot-xlnx-scr"

BOOTMODE:embedded-plus-ve2302 = ""
BOOTFILE_EXT:embedded-plus-ve2302 = "embedded-plus"
SRC_URI:append:embedded-plus-ve2302 = " file://boot.cmd.embedded-plus"

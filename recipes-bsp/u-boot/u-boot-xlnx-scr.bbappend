FILESEXTRAPATHS:append := ":${THISDIR}/u-boot-xlnx-scr"

BOOTMODE:versal-rave = ""
BOOTFILE_EXT:versal-rave = "rave"
SRC_URI:append:versal-rave = " file://boot.cmd.rave"

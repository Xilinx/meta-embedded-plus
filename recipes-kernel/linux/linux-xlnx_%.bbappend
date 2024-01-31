FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:embedded-plus-ve2302 = " file://embedded-plus-platform.cfg"
KERNEL_FEATURES:append:embedded-plus-ve2302 = " embedded-plus-platform.cfg"

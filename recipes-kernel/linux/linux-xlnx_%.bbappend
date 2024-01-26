FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://embedded-plus-platform.cfg"
KERNEL_FEATURES:append = " embedded-plus-platform.cfg"

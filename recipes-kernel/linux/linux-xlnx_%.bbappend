FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://rave-platform.cfg"
KERNEL_FEATURES:append = " rave-platform.cfg"


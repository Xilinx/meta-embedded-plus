FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:embedded-plus-ve2302 = " file://emb-plus-platform.cfg"
KERNEL_FEATURES:append:embedded-plus-ve2302 = " emb-plus-platform.cfg"

FILESEXTRAPATHS:prepend:emb-plus-ve2302 := "${THISDIR}/${PN}:"

SRC_URI:append:emb-plus-ve2302 = " file://emb-plus-platform.cfg"
KERNEL_FEATURES:append:emb-plus-ve2302 = " emb-plus-platform.cfg"

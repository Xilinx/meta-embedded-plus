FILESEXTRAPATHS:prepend:emb-plus-ve2302-amr := "${THISDIR}/${PN}:"

SRC_URI:append:emb-plus-ve2302-amr = " file://emb-plus-platform-amr.cfg"
KERNEL_FEATURES:append:emb-plus-ve2302-amr = " emb-plus-platform-amr.cfg"


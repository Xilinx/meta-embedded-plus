FILESEXTRAPATHS:prepend:emb-plus-ve2302-xrt := "${THISDIR}/files:"

#This should be removed after xmpu and xppu settings enabled in design.
EXTRA_DT_INCLUDE_FILES:append:emb-plus-ve2302-xrt:linux = " emb-plus-platform.dtsi"

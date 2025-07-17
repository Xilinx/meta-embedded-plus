FILESEXTRAPATHS:prepend:emb-plus-ve2302-sdt := "${THISDIR}/files:"

#This should be removed after xmpu and xppu settings enabled in design.
EXTRA_DT_INCLUDE_FILES:append:emb-plus-ve2302-sdt:linux = " emb-plus-platform.dtsi"


FILESEXTRAPATHS:prepend:emb-plus-ve2302-amr := "${THISDIR}/files:"
EXTRA_DT_INCLUDE_FILES:append:emb-plus-ve2302-amr:linux = " emb-plus-platform-amr.dtsi"

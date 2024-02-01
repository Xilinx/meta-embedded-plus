FILESEXTRAPATHS:prepend:emb-plus-ve2302 := "${THISDIR}/files:"

SRC_URI:emb-plus-ve2302 += " file://0001-versal-emb-plus-ve2302-reva.dtsi-Add-versal-emb-plus.patch"

EXTRA_OVERLAYS:append:emb-plus-ve2302 = " emb-plus-platform.dtsi"

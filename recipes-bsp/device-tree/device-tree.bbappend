FILESEXTRAPATHS:prepend:embedded-plus-ve2302 := "${THISDIR}/files:"

SRC_URI:embedded-plus-ve2302 += " file://0001-versal-rave-add-initial-version-rave-reva-dts.patch"

EXTRA_OVERLAYS:append:embedded-plus-ve2302 = " embedded-plus-platform.dtsi"

FILESEXTRAPATHS:prepend:versal-rave := "${THISDIR}/files:"

SRC_URI:versal-rave += " file://0001-versal-rave-add-initial-version-rave-reva-dts.patch"

EXTRA_OVERLAYS:append:versal-rave = " rave-platform.dtsi"

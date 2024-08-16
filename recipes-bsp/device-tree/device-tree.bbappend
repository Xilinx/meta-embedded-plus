FILESEXTRAPATHS:prepend:emb-plus-ve2302 := "${THISDIR}/files:"

EMB_PLUS_OVERLAY = "${@'emp-plus-platform.dtsi' if d.getVar('XILINX_WITH_ESW') == 'xsct' else ''}"
EXTRA_OVERLAYS:append:emb-plus-ve2302 = "${EMB_PLUS_OVERLAY}"

FILESEXTRAPATHS:prepend:emb-plus-ve2302 := "${THISDIR}/files:"

EMB_PLUS_OVERLAY = "${@'emb-plus-platform.dtsi' if d.getVar('XILINX_WITH_ESW') == 'xsct' else ''}"
EXTRA_DT_INCLUDE_FILES:append:emb-plus-ve2302 = "${EMB_PLUS_OVERLAY}"

VMR_PATH ??= "${@d.getVarFlag('VMR_PATH', d.getVar('MACHINE')) or ''}"

# emb-plus-ve2302-es1
VMR_PATH[emb-plus-ve2302-es1] = 'https://petalinux.xilinx.com/sswreleases/rel-v2024.2/vmr_images/2024.2/2024.2_1104_1_11050118/emb-plus-ve2302-es1/vmr.elf'
SRC_URI[emb-plus-ve2302-es1.sha256sum] = 'feafd3e31e35f9040fd9ef180995726692e44b8857ef802f3950a8dfccf62b22'

# emb-plus-ve2302-sdt
VMR_PATH[emb-plus-ve2302-sdt] = 'https://petalinux.xilinx.com/sswreleases/rel-v2024.2/vmr_images/2024.2/2024.2_1104_1_11050118/emb-plus-ve2302-sdt/vmr.elf'
SRC_URI[emb-plus-ve2302-sdt.sha256sum] = '51a43a621f5c3145cac0fca51d102b6e0af7d2f0f9fbabc50cb7fab6826279c0'

# emb-plus-ve2302
VMR_PATH[emb-plus-ve2302] = 'https://petalinux.xilinx.com/sswreleases/rel-v2024.2/vmr_images/2024.2/2024.2_1104_1_11050118/emb-plus-ve2302/vmr.elf'
SRC_URI[emb-plus-ve2302.sha256sum] = '51a43a621f5c3145cac0fca51d102b6e0af7d2f0f9fbabc50cb7fab6826279c0'

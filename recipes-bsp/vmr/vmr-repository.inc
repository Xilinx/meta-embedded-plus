VMR_PATH ??= "${@d.getVarFlag('VMR_PATH', d.getVar('MACHINE')) or ''}"

# emb-plus-ve2302
VMR_PATH[emb-plus-ve2302] = 'https://petalinux.xilinx.com/sswreleases/rel-v2023/vmr_images/2023.2/2023.2_000_0_000000/embedded-plus-ve2302-2023.2_0000_0/vmr.elf'
SRC_URI[emb-plus-ve2302.sha256sum] = '0000'

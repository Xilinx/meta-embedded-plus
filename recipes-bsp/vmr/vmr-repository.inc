# Automatically generated.  Manual changes will be lost.

VMR_PATH ??= "${@d.getVarFlag('VMR_PATH', d.getVar('MACHINE')) or ''}"

# emb-plus-ve2302-xrt
VMR_PATH[emb-plus-ve2302-xrt] = 'https://edf.amd.com/sswreleases/rel-v2026.1/vmr_images/2026.1/2026.1_0507_1_05070618/emb-plus-ve2302-xrt/vmr.elf'
SRC_URI[emb-plus-ve2302-xrt.sha256sum] = 'a6567ff5a99e4536049fef12a17c9d7fe32cc41b2af671e78bfe1d42d616580c'

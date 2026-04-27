# Automatically generated.  Manual changes will be lost.

VMR_PATH ??= "${@d.getVarFlag('VMR_PATH', d.getVar('MACHINE')) or ''}"

# emb-plus-ve2302-xrt
VMR_PATH[emb-plus-ve2302-xrt] = 'https://edf.amd.com/sswreleases/rel-v2026.1/vmr_images/2026.1/2026.1_0427_1_04270913/emb-plus-ve2302-xrt/vmr.elf'
SRC_URI[emb-plus-ve2302-xrt.sha256sum] = 'ec14cbf66c713f723a494cbdc88eebfa73a38b94695e1cdf74ad9def864a7bae'

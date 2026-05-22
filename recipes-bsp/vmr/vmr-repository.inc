# Automatically generated.  Manual changes will be lost.

VMR_PATH ??= "${@d.getVarFlag('VMR_PATH', d.getVar('MACHINE')) or ''}"

# emb-plus-ve2302-xrt
VMR_PATH[emb-plus-ve2302-xrt] = 'https://edf.amd.com/sswreleases/rel-v2026.1/vmr_images/2026.1/2026.1_0522_1_05220436/external/emb-plus-ve2302-xrt/vmr.elf'
SRC_URI[emb-plus-ve2302-xrt.sha256sum] = 'c6a3b2c224ec92e62388d9042acff2cc001e84d09721299a5259a7a4a1c081f0'

# Automatically generated.  Manual changes will be lost.

VMR_PATH ??= "${@d.getVarFlag('VMR_PATH', d.getVar('MACHINE')) or ''}"

# emb-plus-ve2302-xrt
VMR_PATH[emb-plus-ve2302-xrt] = 'https://edf.amd.com/sswreleases/rel-v2026.1/vmr_images/2026.1/2026.1_0426_1_04260607/emb-plus-ve2302-xrt/vmr.elf'
SRC_URI[emb-plus-ve2302-xrt.sha256sum] = 'db05609200c699839d86cea5dd493ff28307782c5da02261feaa66ac91139bd5'

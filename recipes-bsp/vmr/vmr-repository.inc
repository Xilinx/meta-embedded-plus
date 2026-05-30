# Automatically generated.  Manual changes will be lost.

VMR_PATH ??= "${@d.getVarFlag('VMR_PATH', d.getVar('MACHINE')) or ''}"

# emb-plus-ve2302-xrt
VMR_PATH[emb-plus-ve2302-xrt] = 'https://edf.amd.com/sswreleases/rel-v2026.1/vmr_images/2026.1/2026.1_0530_1_05300528/external/emb-plus-ve2302-xrt/vmr.elf'
SRC_URI[emb-plus-ve2302-xrt.sha256sum] = 'c842e0eb0a4902625d70474f6ce54a49cb8777b65b9f97bf35d916d988c52bc9'

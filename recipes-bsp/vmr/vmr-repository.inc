VMR_PATH ??= "${@d.getVarFlag('VMR_PATH', d.getVar('MACHINE')) or ''}"

# emb-plus-ve2302-es1
VMR_PATH[emb-plus-ve2302-es1] = 'https://petalinux.xilinx.com/sswreleases/rel-v2023/vmr_images/2023.2/2023.2_1014_1_06190336/emb-plus-ve2302-es1/vmr.elf'
SRC_URI[emb-plus-ve2302-es1.sha256sum] = '1751a3fc3f66191cc441822ff72a5c197151ff32691f7807c06a57beac8d2a82'

# emb-plus-ve2302
VMR_PATH[emb-plus-ve2302] = 'https://petalinux.xilinx.com/sswreleases/rel-v2023/vmr_images/2023.2/2023.2_1014_1_06190336/emb-plus-ve2302/vmr.elf'
SRC_URI[emb-plus-ve2302.sha256sum] = '1639a79538d8357e21e6d7a919bac207ee646d79c5a81e06209a160938ea9be8'

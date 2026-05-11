DESCRIPTION = "Generate the Embedded-Plus Flash Partition Table(FPT) - AMR"
SUMMARY = "FPT v2 with boot.bin MD5/size provenance for AMR"

inherit deploy image-artifact-names

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
INHIBIT_DEFAULT_DEPS = "1"
IMAGE_NAME_SUFFIX = ""

PROVIDES = "virtual/fpt"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302-amr = "${MACHINE}"
COMPATIBLE_MACHINE:alveo-v80-amr = "${MACHINE}"

do_compile[depends] += "virtual/boot-bin:do_deploy"

FPT_MAGIC ?= "0x92F7A516"
FPT_VERSION ?= "2"
FPT_ENTRY_OFFSET ?= "0x20000"
FPT_ENTRIES ?= "pdi_a pdi_b user"

# Per-partition addresses and sizes (varflag indirection for overrides)
FPT_PDI_A_ADDR ?= ""
FPT_PDI_A_SIZE ?= ""
FPT_PDI_B_ADDR ?= ""
FPT_PDI_B_SIZE ?= ""
FPT_USER_ADDR  ?= ""
FPT_USER_SIZE  ?= ""

# RAVE profile (emb-plus-ve2302-amr) - 128MB flash
FPT_PDI_A_ADDR:emb-plus-ve2302-amr = "0x00080000"
FPT_PDI_A_SIZE:emb-plus-ve2302-amr = "0x03A00000"
FPT_PDI_B_ADDR:emb-plus-ve2302-amr = "0x03B80000"
FPT_PDI_B_SIZE:emb-plus-ve2302-amr = "0x03A00000"
FPT_USER_ADDR:emb-plus-ve2302-amr  = "0x07680000"
FPT_USER_SIZE:emb-plus-ve2302-amr  = "0x00800000"

# V80 profile (alveo-v80-amr) - 256MB flash
FPT_PDI_A_ADDR:alveo-v80-amr = "0x00080000"
FPT_PDI_A_SIZE:alveo-v80-amr = "0x07400000"
FPT_PDI_B_ADDR:alveo-v80-amr = "0x07480000"
FPT_PDI_B_SIZE:alveo-v80-amr = "0x07400000"
FPT_USER_ADDR:alveo-v80-amr  = "0x0E880000"
FPT_USER_SIZE:alveo-v80-amr  = "0x01700000"

FPT_ENTRY_TYPE[pdi_a]  = "PDI"
FPT_ENTRY_ADDR[pdi_a]  = "${FPT_PDI_A_ADDR}"
FPT_ENTRY_SIZE[pdi_a]  = "${FPT_PDI_A_SIZE}"

FPT_ENTRY_TYPE[pdi_b]  = "PDI"
FPT_ENTRY_ADDR[pdi_b]  = "${FPT_PDI_B_ADDR}"
FPT_ENTRY_SIZE[pdi_b]  = "${FPT_PDI_B_SIZE}"

FPT_ENTRY_TYPE[user]   = "USER"
FPT_ENTRY_ADDR[user]   = "${FPT_USER_ADDR}"
FPT_ENTRY_SIZE[user]   = "${FPT_USER_SIZE}"

python do_compile() {
    import hashlib
    import os

    MAGIC        = int(d.getVar("FPT_MAGIC"), 0)
    VERSION      = int(d.getVar("FPT_VERSION"))
    ENTRY_OFFSET = int(d.getVar("FPT_ENTRY_OFFSET"), 0)
    TYPE_PDI     = 0x00000E00
    TYPE_USER    = 0x00000F00
    MD5_LEN      = 16

    entry_names = (d.getVar("FPT_ENTRIES") or "").split()
    if not entry_names:
        bb.fatal("FPT_ENTRIES is empty")
    num_entries = len(entry_names)

    type_flags = d.getVarFlags("FPT_ENTRY_TYPE") or {}
    addr_flags = d.getVarFlags("FPT_ENTRY_ADDR") or {}
    size_flags = d.getVarFlags("FPT_ENTRY_SIZE") or {}
    flag_flags = d.getVarFlags("FPT_ENTRY_FLAGS") or {}

    bootbin_path = d.getVar("DEPLOY_DIR_IMAGE") + "/boot.bin"
    if not os.path.exists(bootbin_path):
        bb.fatal("boot.bin not found: %s (check virtual/boot-bin dependency)" % bootbin_path)
    with open(bootbin_path, "rb") as f:
        bootbin_data = f.read()
    pdi_md5 = hashlib.md5(bootbin_data).digest()
    pdi_size = len(bootbin_data)

    fpt = bytearray(ENTRY_OFFSET * (num_entries + 1))

    fpt[0:4] = MAGIC.to_bytes(4, 'little')
    fpt[4] = VERSION
    fpt[5] = 128
    fpt[6] = 128
    fpt[7] = num_entries

    first_pdi = True
    for idx, name in enumerate(entry_names):
        t = d.expand(type_flags.get(name, "")).strip().upper()
        etype = TYPE_PDI if t == "PDI" else TYPE_USER if t == "USER" else None
        if etype is None:
            bb.fatal("FPT_ENTRY_TYPE[%s] invalid: '%s'" % (name, t))

        addr = int(d.expand(addr_flags.get(name, "0")), 0)
        size = int(d.expand(size_flags.get(name, "0")), 0)
        flags = int(d.expand(flag_flags.get(name, "0x0")), 0)

        p = ENTRY_OFFSET * (idx + 1)
        fpt[p:p+4]     = etype.to_bytes(4, 'little')
        fpt[p+4:p+8]   = addr.to_bytes(4, 'little')
        fpt[p+8:p+12]  = size.to_bytes(4, 'little')

        if etype == TYPE_PDI and first_pdi:
            fpt[p+12:p+28] = pdi_md5
            fpt[p+28:p+32] = pdi_size.to_bytes(4, 'little')
            first_pdi = False

        fpt[p+32:p+36] = flags.to_bytes(4, 'little')

    fpt_path = d.getVar("B") + "/fpt.bin"
    with open(fpt_path, "wb") as f:
        f.write(fpt)
}

do_compile[vardeps] += "FPT_MAGIC FPT_VERSION FPT_ENTRY_OFFSET FPT_ENTRIES \
    FPT_PDI_A_ADDR FPT_PDI_A_SIZE FPT_PDI_B_ADDR FPT_PDI_B_SIZE \
    FPT_USER_ADDR FPT_USER_SIZE"

do_deploy() {
    install -Dm 0644 ${B}/fpt.bin ${DEPLOYDIR}/${IMAGE_NAME}.bin
    ln -sf ${IMAGE_NAME}.bin ${DEPLOYDIR}/${IMAGE_LINK_NAME}.bin
    ln -sf ${IMAGE_NAME}.bin ${DEPLOYDIR}/fpt-${MACHINE}.bin
}

addtask deploy after do_compile

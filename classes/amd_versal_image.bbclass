#
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#

IMAGE_SIZE ?= "0x2280000"

# OSPI Offsets
IMAGE_FPT_OFFSET ?= "0x0"
IMAGE_FPT_RECOVERY_OFFSET ?= "0x20000"
IMAGE_ACTIVE_OFFSET ?= "0x40000"

def generate_image(d):

    import io

    # OSPI Offsets
    image_fpt_offset = int(d.getVar("IMAGE_FPT_OFFSET") or '0', 0)
    image_fpt_recovery_offset = int(d.getVar("IMAGE_RECOVERY_FPT_OFFSET") or '0', 0)
    image_active_offset = int(d.getVar("IMAGE_A_OFFSET") or '0', 0)

    # OSPI data
    image_size = int(d.getVar("IMAGE_SIZE") or '0', 0)
    image_data = io.BytesIO()
    image_data.write(b'\xFF' * image_size)

    # Flash Partition Table (FPT)
    fpt_file = d.getVar("DEPLOY_DIR_IMAGE")+"/main-fpt-"+d.getVar("MACHINE")+".bin"
    try:
        with open(fpt_file, "rb") as f:
            fpt_data = f.read(-1)
    except OSError as err:
        bb.fatal("Unable to open FPT file: " + str(err))

    image_data.seek(image_fpt_offset)
    image_data.write(fpt_data)
    image_data.seek(image_fpt_recovery_offset)
    image_data.write(fpt_data)

    # Image Active and Backup - boot.bin
    try:
        with open(d.getVar("DEPLOY_DIR_IMAGE")+"/boot.bin", "rb") as f:
            bootbin = f.read(-1)
    except OSError as err:
        bb.fatal("Unable to open boot.bin file: " + str(err))

    image_data.seek(image_active_offset)
    image_data.write(bootbin)

    # Write the QSPI data to file
    with open(d.getVar("B") + "/" + d.getVar("IMAGE_NAME") + ".bin", "wb") as f:
        f.write(image_data.getbuffer())

do_compile[depends] += "virtual/boot-bin:do_deploy main-fpt:do_deploy"

python amd_versal_image_do_compile() {
    generate_image(d)
}

EXPORT_FUNCTIONS do_compile

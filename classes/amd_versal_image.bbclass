#
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#

IMAGE_SIZE ?= "0x3280000"
OSPI_VERSION ?= ""
OSPI_IMAGE_VERSION ?= ""

# OSPI Offsets
IMAGE_FPT_OFFSET ?= "0x0"
IMAGE_FPT_BACKUP_OFFSET ?= "0x20000"
IMAGE_ACTIVE_OFFSET ?= "0x40000"
IMAGE_ACTIVE_METADATA_OFFSET ?= "0x3260000"
IMAGE_BACKUP_OFFSET ?= "0x32A0000"
IMAGE_BACKUP_METADATA_OFFSET ?= "0x64C0000"
IMAGE_VERSION_OFFSET ?= "0x7FE0000"

def generate_image(d):

    import io

    # OSPI Offsets
    image_fpt_offset = int(d.getVar("IMAGE_FPT_OFFSET") or '0', 0)
    image_fpt_backup_offset = int(d.getVar("IMAGE_FPT_BACKUP_OFFSET") or '0', 0)
    image_active_offset = int(d.getVar("IMAGE_ACTIVE_OFFSET") or '0', 0)
    image_active_metadata_offset = int(d.getVar("IMAGE_ACTIVE_METADATA_OFFSET") or '0', 0)
    image_backup_offset = int(d.getVar("IMAGE_BACKUP_OFFSET") or '0', 0)
    image_backup_metadata_offset = int(d.getVar("IMAGE_BACKUP_METADATA_OFFSET") or '0', 0)
    image_version_offset = int(d.getVar("IMAGE_VERSION_OFFSET") or '0', 0)

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
    image_data.seek(image_fpt_backup_offset)
    image_data.write(fpt_data)

    # Image Active and Backup - boot.bin
    try:
        with open(d.getVar("DEPLOY_DIR_IMAGE")+"/boot.bin", "rb") as f:
            bootbin = f.read(-1)
    except OSError as err:
        bb.fatal("Unable to open boot.bin file: " + str(err))

    image_data.seek(image_active_offset)
    image_data.write(bootbin)
    image_data.seek(image_backup_offset)
    image_data.write(bootbin)

    # Image metadata
    image_data.seek(image_active_metadata_offset)
    image_data.write(bytearray("PDIM", 'utf8')) # Magic string "PDIM"
    image_data.write(b'\x00\x00\x00\x00') #TODO Version
    image_data.write(len(bootbin).to_bytes(4,'little'))
    image_data.write(b'\x00\x00\x00\x00') #TODO Checksum

    image_data.seek(image_backup_metadata_offset)
    image_data.write(bytearray("PDIM", 'utf8')) # Magic string "PDIM"
    image_data.write(b'\x00\x00\x00\x00') #TODO Version
    image_data.write(len(bootbin).to_bytes(4,'little'))
    image_data.write(b'\x00\x00\x00\x00') #TODO Checksum

    # OSPI Version
    version = d.getVar('OSPI_IMAGE_VERSION')
    version = f"{version}\x00"

    image_data.seek(image_version_offset)
    image_data.write(version.encode())

    # Write the OSPI data to file
    with open(d.getVar("B") + "/" + d.getVar("PN") + ".bin", "wb") as f:
        f.write(image_data.getbuffer())

do_compile[depends] += "virtual/boot-bin:do_deploy main-fpt:do_deploy"

python amd_versal_image_do_compile() {
    generate_image(d)
}

EXPORT_FUNCTIONS do_compile

#
# Copyright (C) 2023-2026, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#

DESCRIPTION = "Generate an OSPI image for the Embedded Plus platform"
SUMMARY = "OSPI image includes FPT and A/B images"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit amd-spi-image deploy image-artifact-names

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302-xrt = "${MACHINE}"

SPI_OUTPUT_SIZE:emb-plus-ve2302-xrt = "0x800_0000"

SPI_COMPONENTS = "fpt fpt_backup bootbin_a pdi_meta bootbin_b pdi_meta_backup version"

# Flash Partition Table (primary + backup)
SPI_OFFSET[fpt] = "0x0"
SPI_SOURCE[fpt] = "fpt-${MACHINE}.bin"

SPI_OFFSET[fpt_backup] = "0x2_0000"
SPI_SOURCE[fpt_backup] = "fpt-${MACHINE}.bin"

# Boot.bin A/B
SPI_OFFSET[bootbin_a] = "0x4_0000"
SPI_SOURCE[bootbin_a] = "boot.bin"

SPI_OFFSET[bootbin_b] = "0x32A_0000"
SPI_SOURCE[bootbin_b] = "boot.bin"

# PDI metadata (inline generator)
SPI_OFFSET[pdi_meta] = "0x326_0000"
SPI_SOURCE[pdi_meta] = "@inline:pdi_meta"

SPI_OFFSET[pdi_meta_backup] = "0x64C_0000"
SPI_SOURCE[pdi_meta_backup] = "@inline:pdi_meta"

# Version string
SPI_OFFSET[version] = "0x7FE_0000"
SPI_SOURCE[version] = "@inline:version"

# Version configuration
OSPI_VERSION ?= ""
OSPI_VERSION:emb-plus-ve2302-xrt = "1.0"
SPI_VERSION = "${PN}-${MACHINE}-v${OSPI_VERSION}${IMAGE_VERSION_SUFFIX}"

DEPENDS = "xclbinutil-native partition-metadata"
SPI_DEPLOY_DEPENDS = "virtual/fpt virtual/boot-bin"
do_compile[vardeps] += "OSPI_VERSION"

do_configure[noexec] = "1"
do_install[noexec] = "1"

def spi_inline_pdi_meta(d, comp, buf):
    """Generate PDIM metadata: magic + version + boot.bin size + checksum."""
    import os
    import struct

    bootbin_path = d.getVar("DEPLOY_DIR_IMAGE") + "/boot.bin"
    bootbin_size = os.path.getsize(bootbin_path)

    # "PDIM" magic + version(0) + size + checksum(0)
    return struct.pack('<4sIII', b'PDIM', 0, bootbin_size, 0)

do_xsabin[depends] += "partition-metadata:do_deploy"

do_xsabin() {
    xclbinutil --force --input ${DEPLOY_DIR_IMAGE}/partition-metadata-${MACHINE}.xsabin \
        --add-section PDI:RAW:${B}/${IMAGE_NAME}.bin --output ${B}/${IMAGE_NAME}.xsabin
}

do_deploy:append() {
    ln -sf ${IMAGE_NAME}.bin ${DEPLOYDIR}/${SPI_VERSION}.bin

    install -Dm 644 ${B}/${IMAGE_NAME}.xsabin ${DEPLOYDIR}/${IMAGE_NAME}.xsabin
    ln -sf ${IMAGE_NAME}.xsabin ${DEPLOYDIR}/${IMAGE_LINK_NAME}.xsabin
    ln -sf ${IMAGE_NAME}.xsabin ${DEPLOYDIR}/${SPI_VERSION}.xsabin
}

addtask xsabin after do_compile before do_deploy

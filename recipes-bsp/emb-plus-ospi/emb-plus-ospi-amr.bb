#
# Copyright (C) 2023-2026, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#

DESCRIPTION = "Embedded-Plus AMR OSPI images"
SUMMARY = "Adaptive Management Runtime(AMR) component"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit amd-spi-image deploy image-artifact-names

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302-amr = "${MACHINE}"
COMPATIBLE_MACHINE:alveo-v80-amr = "${MACHINE}"

# Output size covers FPT + boot.bin (pdi_a region only)
SPI_OUTPUT_SIZE:emb-plus-ve2302-amr = "0x3A0_0000"
SPI_OUTPUT_SIZE:alveo-v80-amr = "0x748_0000"

SPI_COMPONENTS = "fpt bootbin"

# Flash Partition Table
SPI_OFFSET[fpt] = "0x0"
SPI_SOURCE[fpt] = "fpt-${MACHINE}.bin"

# Boot.bin (active only, no backup for AMR)
SPI_OFFSET[bootbin] = "0x8_0000"
SPI_SOURCE[bootbin] = "boot.bin"

# Version configuration
OSPI_VERSION ?= ""
OSPI_VERSION:emb-plus-ve2302-amr = "3.0.0"
OSPI_VERSION:alveo-v80-amr = "3.0.0"
SPI_VERSION = "${PN}-${MACHINE}-v${OSPI_VERSION}${IMAGE_VERSION_SUFFIX}"

DEPENDS:append:emb-plus-ve2302-amr = " amcfw"
DEPENDS:append:alveo-v80-amr = " amcfw"

SPI_DEPLOY_DEPENDS = "virtual/fpt virtual/boot-bin"
do_compile[vardeps] += "OSPI_VERSION"

do_configure[noexec] = "1"
do_install[noexec] = "1"

do_deploy:append() {
    ln -sf ${IMAGE_NAME}.bin ${DEPLOYDIR}/${SPI_VERSION}.bin
}

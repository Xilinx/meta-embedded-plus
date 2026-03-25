DESCRIPTION = "Generate Alveo and Embedded-Plus Adaptive Management Controller (AMC) application image"
SUMMARY = "Adaptive Management Runtime(AMR) component"

inherit python3native ccmake cmake deploy

require amr.inc

PACKAGE_ARCH = "${MACHINE_ARCH}"

COMPATIBLE_HOST:arm = "[^-]*-[^-]*-eabi"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:emb-plus-ve2302-amr = "${MACHINE}"
COMPATIBLE_MACHINE:alveo-v80-amr = "${MACHINE}"

DEPENDS += "libxil xilstandalone xiltimer freertos10-xilinx xilmailbox xilloader xilplmi xilpm"

S = "${WORKDIR}/git/fw/AMC"
B = "${WORKDIR}/build"
OECMAKE_SOURCEPATH = "${S}"

CFLAGS:append = " -specs=${PKG_CONFIG_SYSROOT_DIR}/usr/include/Xilinx.spec -DSDT "

EXTRA_OECMAKE += " \
    -DCMAKE_LIBRARY_PATH=${PKG_CONFIG_SYSROOT_DIR}/usr/lib/ \
    -DYOCTO=ON \
    "

# Profile selects the CDO and build config per machine
AMC_PROFILE:emb-plus-ve2302-amr = "rave"
AMC_PROFILE:alveo-v80-amr = "v80"
EXTRA_OECMAKE:append:emb-plus-ve2302-amr = " -DPROFILE=${AMC_PROFILE}"
EXTRA_OECMAKE:append:alveo-v80-amr = " -DPROFILE=${AMC_PROFILE}"

# Append cross-compilation settings to the generated toolchain file
cmake_do_generate_toolchain_file:append:arm() {
    cat >> ${WORKDIR}/toolchain.cmake <<EOF
    include (CMakeForceCompiler)
    CMAKE_FORCE_C_COMPILER("${OECMAKE_C_COMPILER}" GNU)
    CMAKE_FORCE_CXX_COMPILER("${OECMAKE_CXX_COMPILER}" GNU)
    set (CMAKE_SYSTEM_PROCESSOR "${TRANSLATED_TARGET_ARCH}" )

    set (CMAKE_FIND_ROOT_PATH "${CMAKE_FIND_ROOT_PATH} ${STAGING_LIBDIR} ${CMAKE_INCLUDE_PATH}" CACHE STRING "")
    set (CMAKE_INCLUDE_PATH "${CMAKE_INCLUDE_PATH} ${PKG_CONFIG_SYSROOT_DIR}/usr/include/" CACHE STRING "")
    set (XIL_INCLUDE_DIR "${PKG_CONFIG_SYSROOT_DIR}/usr/include/" CACHE STRING "")
EOF
}

do_deploy() {
    install -Dm 644 ${B}/amc.elf ${DEPLOYDIR}/${PN}-${MACHINE}.elf
    ln -sf ${PN}-${MACHINE}.elf ${DEPLOYDIR}/${PN}.elf

    # Deploy overlay CDO for subsystem isolation
    if [ ! -f "${S}/scripts/${AMC_PROFILE}/isospec.cdo" ]; then
        bbfatal "Overlay CDO not found: ${S}/scripts/${AMC_PROFILE}/isospec.cdo"
    fi
    install -Dm 644 ${S}/scripts/${AMC_PROFILE}/isospec.cdo \
        ${DEPLOYDIR}/${PN}-${MACHINE}.cdo
    ln -sf ${PN}-${MACHINE}.cdo ${DEPLOYDIR}/${PN}.cdo
}

addtask deploy before do_build after do_compile

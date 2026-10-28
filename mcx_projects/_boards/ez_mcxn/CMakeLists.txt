# Copyright 2026 NXP
#
# SPDX-License-Identifier: BSD-3-Clause

# board support

mcux_add_source(
    BASE_PATH ${CUSTOM_BOARD_ROOT}/${board}
    SOURCES
        board.c
        board.h
)

mcux_add_source(
    BASE_PATH ${CUSTOM_BOARD_ROOT}/${board}/board
    SOURCES
        clock_config.c
        clock_config.h
        pin_mux.c
        pin_mux.h
        peripherals.c
        peripherals.h
)

mcux_add_include(
    BASE_PATH ${CUSTOM_BOARD_ROOT}/${board}
    INCLUDES .
)

mcux_add_include(
    BASE_PATH ${CUSTOM_BOARD_ROOT}/${board}/board
    INCLUDES .
)

# MCU flash/linker configuration
include(${SdkRootDirPath}/arch/arm/target/flash.cmake)

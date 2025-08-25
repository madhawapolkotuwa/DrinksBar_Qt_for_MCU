cmake_minimum_required (VERSION 3.21.1)

project(DrinksBar VERSION 0.0.1 LANGUAGES C CXX ASM)

if (NOT TARGET Qul::Core)
    find_package(Qul)
endif()

qul_add_target(DrinksBar QML_PROJECT DrinksBar.qmlproject os/${QUL_OS_LOWERCASE}/main.cpp)

target_sources(DrinksBar PRIVATE
    3rdParty/FatFs/src/diskio.c
    3rdParty/FatFs/src/ff.c
    3rdParty/FatFs/src/ff_gen_drv.c
    3rdParty/FatFs/src/sd_diskio.c
    3rdParty/FatFs/src/option/unicode.c
    stm/board_config.cpp
    fatfs/fatfsfilesystem.h
    jsmn/jsmn.h

    interface/SystemInterface.cpp

)

target_sources(DrinksBar PRIVATE
    ${QUL_BOARD_SDK_DIR}/Drivers/BSP/STM32F769I-Discovery/stm32f769i_discovery_sd.c
    ${QUL_BOARD_SDK_DIR}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_ll_sdmmc.c
    ${QUL_BOARD_SDK_DIR}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_sd.c

    ${QUL_BOARD_SDK_DIR}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rtc.c
    ${QUL_BOARD_SDK_DIR}/Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_ll_rtc.c

)

target_include_directories(DrinksBar PRIVATE
    3rdParty/FatFs/src)

target_compile_definitions(DrinksBar PRIVATE FF_FS_READONLY)

target_link_libraries(DrinksBar PRIVATE Qul::PlatformBSPConfig)

app_target_setup_os(DrinksBar)

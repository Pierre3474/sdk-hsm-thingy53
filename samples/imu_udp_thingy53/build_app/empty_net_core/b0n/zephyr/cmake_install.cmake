# Install script for directory: /Users/pierre.urtado/thingy53-ws/zephyr

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/Users/pierre.urtado/.local/opt/zephyr-sdk-0.17.1/arm-zephyr-eabi/bin/arm-zephyr-eabi-objdump")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/arch/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/lib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/soc/arm/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/boards/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/subsys/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/drivers/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/hsm/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/nrf/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/openthread/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/mcuboot/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/mbedtls/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/cmsis/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/fatfs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/hal_nordic/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/libmetal/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/littlefs/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/lvgl/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/mipi-sys-t/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/nrf_hw_models/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/open-amp/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/segger/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/tinycrypt/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/modules/nrfxlib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/kernel/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/cmake/flash/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/cmake/usage/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/cmake/reports/cmake_install.cmake")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n/zephyr/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()

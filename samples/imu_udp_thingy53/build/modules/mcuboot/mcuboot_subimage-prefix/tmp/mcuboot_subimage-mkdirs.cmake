# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/Users/pierre.urtado/thingy53-ws/bootloader/mcuboot/boot/zephyr")
  file(MAKE_DIRECTORY "/Users/pierre.urtado/thingy53-ws/bootloader/mcuboot/boot/zephyr")
endif()
file(MAKE_DIRECTORY
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build/mcuboot"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build/modules/mcuboot/mcuboot_subimage-prefix"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build/modules/mcuboot/mcuboot_subimage-prefix/tmp"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build/modules/mcuboot/mcuboot_subimage-prefix/src/mcuboot_subimage-stamp"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build/modules/mcuboot/mcuboot_subimage-prefix/src"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build/modules/mcuboot/mcuboot_subimage-prefix/src/mcuboot_subimage-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build/modules/mcuboot/mcuboot_subimage-prefix/src/mcuboot_subimage-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build/modules/mcuboot/mcuboot_subimage-prefix/src/mcuboot_subimage-stamp${cfgdir}") # cfgdir has leading slash
endif()

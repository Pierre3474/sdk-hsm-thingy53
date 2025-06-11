# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/Users/pierre.urtado/thingy53-ws/nrf/samples/nrf5340/netboot")
  file(MAKE_DIRECTORY "/Users/pierre.urtado/thingy53-ws/nrf/samples/nrf5340/netboot")
endif()
file(MAKE_DIRECTORY
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/b0n"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/modules/nrf/samples/b0n_subimage-prefix"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/modules/nrf/samples/b0n_subimage-prefix/tmp"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/modules/nrf/samples/b0n_subimage-prefix/src/b0n_subimage-stamp"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/modules/nrf/samples/b0n_subimage-prefix/src"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/modules/nrf/samples/b0n_subimage-prefix/src/b0n_subimage-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/modules/nrf/samples/b0n_subimage-prefix/src/b0n_subimage-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/Users/pierre.urtado/thingy53-ws/hsm/samples/imu_udp_thingy53/build_app/empty_net_core/modules/nrf/samples/b0n_subimage-prefix/src/b0n_subimage-stamp${cfgdir}") # cfgdir has leading slash
endif()

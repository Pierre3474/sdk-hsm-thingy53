# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/Users/pierre.urtado/thingy53-ws/zephyr/samples/boards/nrf/ieee802154/802154_rpmsg")
  file(MAKE_DIRECTORY "/Users/pierre.urtado/thingy53-ws/zephyr/samples/boards/nrf/ieee802154/802154_rpmsg")
endif()
file(MAKE_DIRECTORY
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/61/build/802154_rpmsg"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/61/build/modules/nrf/samples/802154_rpmsg_subimage-prefix"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/61/build/modules/nrf/samples/802154_rpmsg_subimage-prefix/tmp"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/61/build/modules/nrf/samples/802154_rpmsg_subimage-prefix/src/802154_rpmsg_subimage-stamp"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/61/build/modules/nrf/samples/802154_rpmsg_subimage-prefix/src"
  "/Users/pierre.urtado/thingy53-ws/hsm/samples/61/build/modules/nrf/samples/802154_rpmsg_subimage-prefix/src/802154_rpmsg_subimage-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/pierre.urtado/thingy53-ws/hsm/samples/61/build/modules/nrf/samples/802154_rpmsg_subimage-prefix/src/802154_rpmsg_subimage-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/Users/pierre.urtado/thingy53-ws/hsm/samples/61/build/modules/nrf/samples/802154_rpmsg_subimage-prefix/src/802154_rpmsg_subimage-stamp${cfgdir}") # cfgdir has leading slash
endif()

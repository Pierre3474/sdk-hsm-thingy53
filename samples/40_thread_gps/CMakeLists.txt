# SPDX-License-Identifier: LicenseRef-Nordic-5-Clause
cmake_minimum_required(VERSION 3.20.0)

# Définition de la carte (override possible via -b BOARD=...)
set(BOARD thingy53_nrf5340_cpuapp)

# Overlay DTS à appliquer
set(DTC_OVERLAY_FILE ${CMAKE_CURRENT_SOURCE_DIR}/app.overlay)

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(40_thread_gps LANGUAGES C CXX)

# Intégration de nlohmann/json
include(FetchContent)
FetchContent_Declare(
  nlohmann_json
  GIT_REPOSITORY https://github.com/nlohmann/json.git
  GIT_TAG v3.11.2
)
FetchContent_MakeAvailable(nlohmann_json)

# Rassemblement des sources
file(GLOB_RECURSE app_sources
  ${CMAKE_CURRENT_SOURCE_DIR}/src/*.c
  ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp
)

if(NOT app_sources)
  message(FATAL_ERROR "Aucune source trouvée dans src/")
endif()

target_sources(app PRIVATE ${app_sources})

# Inclure les headers
target_include_directories(app PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_CURRENT_SOURCE_DIR}/../../subsys/udp_broadcast
  ${CMAKE_CURRENT_SOURCE_DIR}/../../subsys/app_led
  ${CMAKE_CURRENT_SOURCE_DIR}/../../subsys/bme688_server
)

# Lier la bibliothèque JSON
target_link_libraries(app PRIVATE nlohmann_json::nlohmann_json)

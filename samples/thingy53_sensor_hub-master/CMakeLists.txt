cmake_minimum_required(VERSION 3.20.0)

set(PM_STATIC_YML_FILE
  ${CMAKE_CURRENT_SOURCE_DIR}/boards/pm_static_${BOARD}.yml
)

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(thingy53_thread_udp_imu)

target_sources(app PRIVATE
  src/main.c
  network/thread_udp_sender.c
)

zephyr_library_include_directories(
  .
  ./network
)
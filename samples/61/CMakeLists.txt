cmake_minimum_required(VERSION 3.20.0)

# Force la cible CPU application
set(BOARD thingy53_nrf5340_cpuapp CACHE STRING "Target board")

# Fichier DeviceTree overlay
set(DTC_OVERLAY_FILE app.overlay CACHE STRING "DeviceTree overlay")

# Charge Zephyr (récupère ZephyrBase via $ENV{ZEPHYR_BASE})
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(thingy53_bmi270_app)

# Récupère tous tes .c/.cpp dans src/
file(GLOB APP_SOURCES "src/*.c" "src/*.cpp")

# Lie ces sources au target 'app' (pas de add_child_image, pas de multi-image)
target_sources(app PRIVATE ${APP_SOURCES})

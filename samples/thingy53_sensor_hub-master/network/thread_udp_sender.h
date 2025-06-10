#pragma once

#include <zephyr/kernel.h>
#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

int udp_send_sensor_json(const char *json, size_t len);

#ifdef __cplusplus
}
#endif
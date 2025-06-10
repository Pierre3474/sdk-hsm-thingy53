#pragma once

#include <stdint.h>
#include <stddef.h>
#include <stdio.h>

// Arrondi à 2 décimales (0,01 près)
static inline float round2(float x) {
    return ((int)(x * 100.0f + (x > 0 ? 0.5f : -0.5f))) / 100.0f;
}

// Remplit buffer avec le JSON (doit faire < 100 octets). Renvoie la taille écrite.
static inline size_t make_sensor_json(char *buf, size_t buflen,
    const char *id, uint32_t ts,
    float ax, float ay, float az,
    float gx, float gy, float gz,
    float roll, float pitch, float yaw)
{
    // Format compact, sans espaces
    return snprintf(buf, buflen,
        "{\"id\":\"%s\",\"ts\":%u,\"ax\":%.2f,\"ay\":%.2f,\"az\":%.2f,"
        "\"gx\":%.2f,\"gy\":%.2f,\"gz\":%.2f,"
        "\"roll\":%.2f,\"pitch\":%.2f,\"yaw\":%.2f}",
        id, ts,
        round2(ax), round2(ay), round2(az),
        round2(gx), round2(gy), round2(gz),
        round2(roll), round2(pitch), round2(yaw)
    );
}
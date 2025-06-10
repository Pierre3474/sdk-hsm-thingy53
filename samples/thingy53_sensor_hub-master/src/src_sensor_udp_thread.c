#include <zephyr/kernel.h>
#include <zephyr/sys/printk.h>
#include <zephyr/device.h>
#include <zephyr/drivers/sensor.h>
#include <string.h>
#include "network/thread_udp_sender.h"
#include "network/sensor_json_fmt.h"

#define ROBOT_ID "thingy53A" // Change cet identifiant pour chaque robot

#define IMU_LABEL DT_LABEL(DT_NODELABEL(lsm6dsl)) // Capteur IMU sur Thingy:53
#define JSON_BUF_SIZE 100

void sensor_udp_thread(void)
{
    const struct device *imu = device_get_binding(IMU_LABEL);
    char json[JSON_BUF_SIZE];
    struct sensor_value accel[3], gyro[3];
    float ax, ay, az, gx, gy, gz;
    float roll = 0, pitch = 0, yaw = 0; // À remplacer par ta fusion capteur si dispo

    if (!imu) {
        printk("IMU device not ready\n");
        return;
    }

    while (1) {
        if (sensor_sample_fetch(imu) == 0 &&
            sensor_channel_get(imu, SENSOR_CHAN_ACCEL_XYZ, accel) == 0 &&
            sensor_channel_get(imu, SENSOR_CHAN_GYRO_XYZ, gyro) == 0) {
            ax = sensor_value_to_double(&accel[0]);
            ay = sensor_value_to_double(&accel[1]);
            az = sensor_value_to_double(&accel[2]);
            gx = sensor_value_to_double(&gyro[0]);
            gy = sensor_value_to_double(&gyro[1]);
            gz = sensor_value_to_double(&gyro[2]);

            // Si tu as une fusion d'orientation (roll/pitch/yaw), mets à jour ici
            // ex: get_orientation(&roll, &pitch, &yaw);

            uint32_t ts = k_uptime_get() / 1000;
            size_t json_len = make_sensor_json(json, sizeof(json), ROBOT_ID, ts,
                                               ax, ay, az, gx, gy, gz, roll, pitch, yaw);

            if (json_len < sizeof(json)) {
                udp_send_sensor_json(json, json_len);
                printk("Sent: %s\n", json);
            } else {
                printk("JSON trop long (%d octets)\n", (int)json_len);
            }
        } else {
            printk("Erreur lecture IMU\n");
        }
        k_sleep(K_SECONDS(4));
    }
}
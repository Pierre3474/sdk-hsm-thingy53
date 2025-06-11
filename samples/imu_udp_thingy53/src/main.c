#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/devicetree.h>
#include <zephyr/drivers/sensor.h>
#include <zephyr/logging/log.h>
#include <zephyr/net/socket.h>
#include <zephyr/net/net_ip.h>
#include <zephyr/net/openthread.h>
#include <openthread/thread.h>
#include <openthread/instance.h>
#include <zephyr/net/net_if.h>

LOG_MODULE_REGISTER(main);

#define BMI270 DT_LABEL(DT_NODELABEL(bmi270))
#define SEND_INTERVAL_MS 1000
#define UDP_PORT 4242
#define PEER_IPV6 "fdde:ad00:beef:0:0:ff:fe00:fc01" // Adresse Thread cible (à modifier si besoin)

static const struct device *bmi270_dev;

static int sock = -1;
static struct sockaddr_in6 peer_addr;

void send_imu_udp(const struct sensor_value *accel, const struct sensor_value *gyro, char *out_payload, size_t out_size)
{
    int len = snprintk(out_payload, out_size,
        "{\"accel\":[%.3f,%.3f,%.3f],\"gyro\":[%.3f,%.3f,%.3f]}",
        sensor_value_to_double(&accel[0]), sensor_value_to_double(&accel[1]), sensor_value_to_double(&accel[2]),
        sensor_value_to_double(&gyro[0]), sensor_value_to_double(&gyro[1]), sensor_value_to_double(&gyro[2]));

    int ret = sendto(sock, out_payload, len, 0, (struct sockaddr *)&peer_addr, sizeof(peer_addr));
    if (ret < 0) {
        LOG_ERR("UDP send failed: %d", errno);
    }
}

void main(void)
{
    int ret;
    struct sensor_value accel[3], gyro[3];
    int send_count = 0;
    char payload[64];

    LOG_INF("Starting Thingy:53 IMU UDP project");

    bmi270_dev = DEVICE_DT_GET_ONE(bosch_bmi270);
    if (!device_is_ready(bmi270_dev)) {
        LOG_ERR("BMI270 not ready");
        return;
    }

    // Attendre que Thread soit up
    struct net_if *iface = net_if_get_default();
    while (!net_if_is_up(iface)) {
        k_msleep(100);
    }
    LOG_INF("Network interface is up");

    // UDP socket setup
    sock = socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
    if (sock < 0) {
        LOG_ERR("Socket error %d", errno);
        return;
    }

    memset(&peer_addr, 0, sizeof(peer_addr));
    peer_addr.sin6_family = AF_INET6;
    peer_addr.sin6_port = htons(UDP_PORT);
    inet_pton(AF_INET6, PEER_IPV6, &peer_addr.sin6_addr);

    while (1) {
        ret = sensor_sample_fetch(bmi270_dev);
        if (ret < 0) {
            LOG_ERR("Sensor fetch error: %d", ret);
            k_msleep(SEND_INTERVAL_MS);
            continue;
        }
        ret = sensor_channel_get(bmi270_dev, SENSOR_CHAN_ACCEL_XYZ, accel);
        if (ret < 0) {
            LOG_ERR("Accel read error: %d", ret);
            k_msleep(SEND_INTERVAL_MS);
            continue;
        }
        ret = sensor_channel_get(bmi270_dev, SENSOR_CHAN_GYRO_XYZ, gyro);
        if (ret < 0) {
            LOG_ERR("Gyro read error: %d", ret);
            k_msleep(SEND_INTERVAL_MS);
            continue;
        }

        send_imu_udp(accel, gyro, payload, sizeof(payload));

        send_count++;
        if (send_count % 4 == 0) {
            // Affiche toutes les 4 secondes ce qui est envoyé
            printk("Sent (every 4s): %s\n", payload);
        }

        k_msleep(SEND_INTERVAL_MS);
    }
}
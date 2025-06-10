#include <zephyr/kernel.h>
#include <zephyr/logging/log.h>
#include <zephyr/shell/shell.h>
#include <zephyr/device.h>
#include <zephyr/drivers/sensor.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/net/socket.h>
#include <zephyr/net/net_ip.h>
#include <zephyr/net/openthread.h>               // <-- for openthread_get_default_instance()

#include "udp_broadcast.h"
#include "app_led.h"
#include "app_battery.h"
#include "bme688_server.h"
#include <json.hpp>

using json = nlohmann::json;

LOG_MODULE_REGISTER(sensor_server, LOG_LEVEL_INF);

#define INTERVAL_S   5
#define UDP_PORT     61631

/* LED0 alias */
#define LED0_NODE   DT_ALIAS(led0)
static const struct gpio_dt_spec led0 = GPIO_DT_SPEC_GET(LED0_NODE, gpios);

/* Sensor + Thread socket */
static const struct device *dev_bh1749, *dev_bmi270;
static int sock_fd;
static struct sockaddr_in6 dest;
static char uid[20];

static void init_uid(void) {
    uint32_t id0 = NRF_FICR->INFO.DEVICEID[0];
    uint32_t id1 = NRF_FICR->INFO.DEVICEID[1];
    snprintf(uid, sizeof(uid), "%08X%08X", id0, id1);
    LOG_INF("UID: %s", uid);
}

static void init_led(void) {
    if (device_is_ready(led0.port)) {
        gpio_pin_configure_dt(&led0, GPIO_OUTPUT_INACTIVE);
    } else {
        LOG_ERR("LED0 not ready");
    }
}

static void init_sensors(void) {
    dev_bh1749 = DEVICE_DT_GET(DT_ALIAS(bh1749));
    dev_bmi270 = DEVICE_DT_GET(DT_NODELABEL(bmi270));
    if (!device_is_ready(dev_bh1749)) {
        LOG_ERR("BH1749 not ready");
    }
    if (!device_is_ready(dev_bmi270)) {
        LOG_ERR("BMI270 not ready");
    }
}

static void init_network(void) {
    sock_fd = socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
    dest.sin6_family = AF_INET6;
    dest.sin6_port   = htons(UDP_PORT);
    inet_pton(AF_INET6, "ff03::1", &dest.sin6_addr);
    int rc = connect(sock_fd, (struct sockaddr *)&dest, sizeof(dest));
    if (rc < 0) {
        LOG_ERR("connect() failed: %d", rc);
    }
}

static void gather_send(void) {
    json j;
    j["uptime_s"] = k_uptime_get() / 1000;
    char vbuf[16];
    app_battery_voltage_text(vbuf);
    j["voltage"]  = vbuf;
    j["charging"] = app_battery_charging();

    /* Light */
    sensor_sample_fetch_chan(dev_bh1749, SENSOR_CHAN_ALL);
    struct sensor_value sv;
    int r,g,b,ir;
    sensor_channel_get(dev_bh1749, SENSOR_CHAN_RED,   &sv); r  = sv.val1;
    sensor_channel_get(dev_bh1749, SENSOR_CHAN_GREEN, &sv); g  = sv.val1;
    sensor_channel_get(dev_bh1749, SENSOR_CHAN_BLUE,  &sv); b  = sv.val1;
    sensor_channel_get(dev_bh1749, SENSOR_CHAN_IR,    &sv); ir = sv.val1;
    j["light"] = {r,g,b,ir};

    /* IMU */
    sensor_sample_fetch(dev_bmi270);
    struct sensor_value acc[3], gyr[3];
    sensor_channel_get(dev_bmi270, SENSOR_CHAN_ACCEL_XYZ, acc);
    sensor_channel_get(dev_bmi270, SENSOR_CHAN_GYRO_XYZ,  gyr);
    j["accel"] = {acc[0].val1, acc[1].val1, acc[2].val1};
    j["gyro"]  = {gyr[0].val1, gyr[1].val1, gyr[2].val1};

    /* Build & send */
    std::string topic = "thread_tags/" + std::string(uid) + "/all";
    std::string msg   = topic + j.dump();

    app_led_on();
    send_udp(msg);
    app_led_off();

    LOG_INF("Sent: %s", msg.c_str());

    /* Print Thread info on serial */
    struct openthread_context *ctx = openthread_get_default_context();
    otInstance *inst = openthread_get_default_instance();
    uint8_t   role = otThreadGetDeviceRole(inst);
    uint8_t   chan = otThreadGetChannel(inst);
    uint16_t  pan  = otThreadGetPanId(inst);
    const otExtPanId *ext = otThreadGetExtendedPanId(inst);

    LOG_INF("Role=%u Ch=%u PAN=0x%04x EXT=%02x…%02x",
        role, chan, pan, ext->m8[0], ext->m8[7]
    );
}

/* CLI “send” command */
static int cmd_send(const struct shell *sh, size_t argc, char **argv) {
    ARG_UNUSED(argc); ARG_UNUSED(argv);
    gather_send();
    shell_print(sh, "Manual send");
    return 0;
}
SHELL_CMD_REGISTER(send, NULL, "Force sensor send", cmd_send);

extern "C" void main(void) {
    LOG_INF("Starting sensors+CLI (5 s interval)");
    app_ot_init();
    app_battery_init();
    bme688_server_init();

    init_led();
    init_uid();
    init_sensors();
    init_network();

    /* Blink green once at start */
    app_led_blink_green(0.5,200,200);

    while (1) {
        gather_send();
        k_sleep(K_SECONDS(INTERVAL_S));
    }
}

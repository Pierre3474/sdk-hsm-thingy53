/*
 * Copyright (c) 2018 Nordic Semiconductor ASA
 *
 * SPDX-License-Identifier: LicenseRef-Nordic-5-Clause
 */

#include <zephyr/types.h>
#include <stddef.h>
#include <string.h>
#include <errno.h>
#include <zephyr/sys/printk.h>
#include <zephyr/kernel.h>
#include <zephyr/drivers/gpio.h>
#include <soc.h>
#include <zephyr/drivers/sensor.h>
#include <zephyr/drivers/adc.h>
#include <hal/nrf_saadc.h>
#include <dk_buttons_and_leds.h>
#include <zephyr/net/openthread.h>
#include <zephyr/net/net_if.h>
#include "../network/thread_udp_sender.h"
#include "../network/sensor_json_fmt.h"

// ---- Voltage divider config ---- //
struct voltage_divider_config {
	struct gpio_dt_spec enable_pin;
	uint32_t output_ohm;
	uint32_t full_ohm;
};

static const struct voltage_divider_config volt_div_conf = {
	.enable_pin = GPIO_DT_SPEC_GET(DT_PATH(vbatt), power_gpios),
	.output_ohm = DT_PROP(DT_PATH(vbatt), output_ohms),
	.full_ohm = DT_PROP(DT_PATH(vbatt), full_ohms),
};

// ---- ADC settings ---- //
#define ADC_RESOLUTION 14
static const struct adc_channel_cfg adc_channel_cfg = {
	.gain = ADC_GAIN_1_6,
	.reference = ADC_REF_INTERNAL,
	.acquisition_time = ADC_ACQ_TIME(ADC_ACQ_TIME_MICROSECONDS, 40),
	.input_positive = NRF_SAADC_INPUT_AIN2,
};
static struct adc_sequence adc_seq = {
	.channels = BIT(0),	
	.oversampling = 4,
	.calibrate = true,
	.resolution = ADC_RESOLUTION,
};

// ---- IMU Thread config ---- //
#define ROBOT_ID "thingy53A"
#define IMU_LABEL DT_LABEL(DT_NODELABEL(lsm6dsl))
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

	// Démarrage Thread (OpenThread)
	struct net_if *iface = net_if_get_default();
	printk("Starting OpenThread...\n");
	openthread_start(iface);
	printk("OpenThread started.\n");

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

			uint32_t ts = k_uptime_get() / 1000;
			size_t json_len = make_sensor_json(json, sizeof(json), ROBOT_ID, ts,
											   ax, ay, az, gx, gy, gz, roll, pitch, yaw);

			if (json_len < sizeof(json)) {
				udp_send_sensor_json(json, json_len);
				printk("Sent UDP: %s\n", json);
			} else {
				printk("JSON trop long (%d octets)\n", (int)json_len);
			}
		} else {
			printk("Erreur lecture IMU\n");
		}
		k_sleep(K_SECONDS(4));
	}
}

K_THREAD_DEFINE(sensor_udp_thd_id, 1024, sensor_udp_thread, NULL, NULL, NULL, 7, 0, 0);

// ---- Main loop (juste pour clignoter la LED) ---- //
#define RUN_STATUS_LED DK_LED2
#define BLINK_INTERVAL 500

void main(void)
{
	printk("Starting Thread Sensor Hub application (Thingy:53, Thread only)\n");

	// Setup voltage divider
	if (!device_is_ready(volt_div_conf.enable_pin.port)) {
		printk("VBATT voltage divider GPIO not ready\n");
		return;
	}
	gpio_pin_configure_dt(&volt_div_conf.enable_pin, GPIO_OUTPUT);
	gpio_pin_set_dt(&volt_div_conf.enable_pin, 1);

	// LEDs
	int err = dk_leds_init();
	if (err) {
		printk("LEDs init failed (err %d)\n", err);
		return;
	}

	// Setup ADC
	const struct device *adc_dev = DEVICE_DT_GET_ONE(nordic_nrf_saadc);
	if (!device_is_ready(adc_dev)) {
		printk("ADC is not ready\n");
		return;
	}
	err = adc_channel_setup(adc_dev, &adc_channel_cfg);
	if (err) {
		printk("Error in ADC setup: %d\n", err);
		return;
	}

	// Boucle principale : clignote la LED pour indiquer que l'appli tourne
	uint8_t blink_status = 0;
	while (1) {
		dk_set_led(RUN_STATUS_LED, (++blink_status) % 2);
		k_sleep(K_MSEC(BLINK_INTERVAL));
	}
}
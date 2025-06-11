#include <zephyr/kernel.h>
#include <zephyr/sys/printk.h>
#include <zephyr/device.h>
#include <zephyr/drivers/pwm.h>

// PWM LED device tree aliases (vert et bleu uniquement)
// Adapte les alias à ta devicetree : pwmled1 (vert), pwmled2 (bleu)
static const struct pwm_dt_spec green_pwm_led = PWM_DT_SPEC_GET(DT_ALIAS(pwmled1));
static const struct pwm_dt_spec blue_pwm_led  = PWM_DT_SPEC_GET(DT_ALIAS(pwmled2));

// Not calibrated, fixed for specific board
#define PWM_PERIOD PWM_MSEC(20)

// Helper for initialization of a single LED
static int init_led(const struct pwm_dt_spec *pwm_led)
{
	if (!device_is_ready(pwm_led->dev)) {
		printk("PWM LED Init error: '%s' device not ready\n", pwm_led->dev->name);
		return -ENODEV;
	}
	int ret = pwm_set_dt(pwm_led, PWM_PERIOD, 0);
	if (ret) {
		printk("Error %d: failed to set pulse width for %s\n", ret, pwm_led->dev->name);
	}
	return ret;
}

// Set a single LED's brightness (float 0.0 .. 1.0)
static int set_led(const struct pwm_dt_spec *pwm_led, float brightness)
{
	if (brightness < 0.0f) brightness = 0.0f;
	if (brightness > 1.0f) brightness = 1.0f;
	uint32_t pulse = (uint32_t)(brightness * PWM_PERIOD);
	int ret = pwm_set_pulse_dt(pwm_led, pulse);
	if (ret) {
		printk("LED error pwm_set_pulse_dt(%s): %d\n", pwm_led->dev->name, ret);
	}
	return ret;
}

// Public API

int app_led_init(void)
{
	int ret = 0;
	ret |= init_led(&green_pwm_led);
	ret |= init_led(&blue_pwm_led);
	return ret;
}

int app_led_set_green(float brightness)
{
	set_led(&blue_pwm_led, 0);
	return set_led(&green_pwm_led, brightness);
}

int app_led_set_blue(float brightness)
{
	set_led(&green_pwm_led, 0);
	return set_led(&blue_pwm_led, brightness);
}

int app_led_set_color(float g, float b)
{
	set_led(&green_pwm_led, g);
	set_led(&blue_pwm_led,  b);
	return 0;
}

int app_led_on(void)
{
	set_led(&green_pwm_led, 1.0f);
	set_led(&blue_pwm_led,  1.0f);
	return 0;
}

int app_led_off(void)
{
	set_led(&green_pwm_led, 0.0f);
	set_led(&blue_pwm_led,  0.0f);
	return 0;
}

int app_led_blink_green(float brightness, int32_t up_ms, int32_t down_ms)
{
	app_led_set_green(brightness);
	k_msleep(up_ms);
	app_led_off();
	k_msleep(down_ms);
	return 0;
}

int app_led_blink_blue(float brightness, int32_t up_ms, int32_t down_ms)
{
	app_led_set_blue(brightness);
	k_msleep(up_ms);
	app_led_off();
	k_msleep(down_ms);
	return 0;
}

int app_led_blink_color(float g, float b, int32_t up_ms, int32_t down_ms)
{
	app_led_set_color(g, b);
	k_msleep(up_ms);
	app_led_off();
	k_msleep(down_ms);
	return 0;
}
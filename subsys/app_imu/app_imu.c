#include <zephyr/device.h>
#include <zephyr/drivers/sensor.h>
#include <zephyr/logging/log.h>

LOG_MODULE_REGISTER(app_imu, LOG_LEVEL_INF);

// Utilise le label défini dans l'overlay
#define IMU_LABEL DT_LABEL(DT_NODELABEL(bmi270))

static const struct device *imu_dev = NULL;

int app_imu_init(void)
{
    imu_dev = device_get_binding(IMU_LABEL);
    if (!imu_dev) {
        LOG_ERR("IMU (BMI270) device not found");
        return -ENODEV;
    }
    LOG_INF("IMU (BMI270) initialized: %s", IMU_LABEL);
    return 0;
}
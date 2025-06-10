#include "thread_udp_sender.h"
#include <zephyr/net/socket.h>
#include <zephyr/net/net_ip.h>
#include <zephyr/sys/printk.h>
#include <string.h>
#include <errno.h>

#define THREAD_MCAST_ADDR "ff03::1"
#define THREAD_PORT 4141

int udp_send_sensor_json(const char *json, size_t len)
{
    struct sockaddr_in6 dest;
    int sock, ret;

    memset(&dest, 0, sizeof(dest));
    dest.sin6_family = AF_INET6;
    dest.sin6_port = htons(THREAD_PORT);
    inet_pton(AF_INET6, THREAD_MCAST_ADDR, &dest.sin6_addr);

    sock = socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
    if (sock < 0) {
        printk("UDP socket error: %d\n", errno);
        return -1;
    }

    ret = sendto(sock, json, len, 0, (struct sockaddr *)&dest, sizeof(dest));
    if (ret < 0) {
        printk("UDP sendto error: %d\n", errno);
        close(sock);
        return -1;
    }

    close(sock);
    return 0;
}
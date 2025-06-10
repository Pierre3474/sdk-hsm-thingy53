import socket
import json

MCAST_GRP = 'ff03::1'
PORT = 4141

s = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
s.bind(('::', PORT))
group_bin = socket.inet_pton(socket.AF_INET6, MCAST_GRP)
s.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_JOIN_GROUP, group_bin + (b'\x00'*12))

print(f"Listening for sensor data on [{MCAST_GRP}]:{PORT}")
while True:
    data, addr = s.recvfrom(200)
    try:
        msg = json.loads(data.decode())
        print(f"From {addr[0]}: {msg}")
    except Exception as e:
        print(f"Invalid JSON or error: {e} -- raw: {data}")
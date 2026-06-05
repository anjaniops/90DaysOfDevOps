# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

## Task 1: DNS – How Names Become IPs

### What happens when you type google.com in a browser?

When a user enters google.com in a browser, the system first queries a DNS server to resolve the domain name into an IP address. Once the IP address is obtained, the browser establishes a connection to the server and requests the webpage content.

### DNS Record Types

* A → Maps a domain name to an IPv4 address.
* AAAA → Maps a domain name to an IPv6 address.
* CNAME → Creates an alias for another domain name.
* MX → Specifies mail servers for a domain.
* NS → Identifies the authoritative DNS servers.

### dig Output

```bash
dig google.com
```

Example:

```text
google.com.    300    IN    A    142.250.x.x
```

TTL: 300 seconds

---

## Task 2: IP Addressing

### What is IPv4?

IPv4 is a 32-bit address represented in four octets separated by dots.

Example:

```text
192.168.1.10
```

### Public vs Private IP

Public IP:

* Reachable over the internet
* Example: 8.8.8.8

Private IP:

* Used within internal networks
* Example: 192.168.1.10

### Private IP Ranges

```text
10.0.0.0 – 10.255.255.255
172.16.0.0 – 172.31.255.255
192.168.0.0 – 192.168.255.255
```

### Local IP Check

```bash
ip addr show
```

Identified local private IP address from system output.

---

## Task 3: CIDR & Subnetting

### What does /24 mean?

A /24 indicates that the first 24 bits represent the network portion and the remaining 8 bits are available for hosts.

### Why Subnet?

Subnetting helps organize networks efficiently, improves security, reduces broadcast traffic, and enables better IP address management.

### CIDR Table

| CIDR | Subnet Mask     | Total IPs | Usable Hosts |
| ---- | --------------- | --------- | ------------ |
| /24  | 255.255.255.0   | 256       | 254          |
| /16  | 255.255.0.0     | 65,536    | 65,534       |
| /28  | 255.255.255.240 | 16        | 14           |

---

## Task 4: Ports – The Doors to Services

### What is a Port?

A port is a logical communication endpoint used by applications and services to send and receive network traffic.

### Common Ports

| Port  | Service |
| ----- | ------- |
| 22    | SSH     |
| 80    | HTTP    |
| 443   | HTTPS   |
| 53    | DNS     |
| 3306  | MySQL   |
| 6379  | Redis   |
| 27017 | MongoDB |

### Listening Services

```bash
ss -tulpn
```

Example:

* Port 22 → SSH
* Port 53 → DNS

---

## Task 5: Putting It Together

### curl http://myapp.com:8080

DNS resolves the domain name to an IP address. The client then connects to port 8080 using TCP and sends an HTTP request to the application.

### App cannot reach 10.0.1.50:3306

First checks:

* Network connectivity (ping)
* Port accessibility
* Service status
* Firewall rules
* Database logs

---

## What I Learned

1. DNS translates domain names into IP addresses.
2. CIDR and subnetting help organize networks efficiently.
3. Ports allow multiple services to communicate on the same host.

## Key Takeaway

Understanding DNS, IP addressing, subnetting, and ports is essential for troubleshooting modern infrastructure and DevOps environments.


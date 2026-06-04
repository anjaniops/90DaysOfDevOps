# Day 14 – Networking Fundamentals & Hands-on Checks

## OSI vs TCP/IP Models

### OSI Model

* Layer 1: Physical
* Layer 2: Data Link
* Layer 3: Network
* Layer 4: Transport
* Layer 5: Session
* Layer 6: Presentation
* Layer 7: Application

### TCP/IP Model

* Link Layer
* Internet Layer
* Transport Layer
* Application Layer

### Protocol Mapping

* IP → Internet Layer
* TCP/UDP → Transport Layer
* DNS → Application Layer
* HTTP/HTTPS → Application Layer

### Example

```text id="j0cikn"
curl https://example.com
```

Application Layer (HTTP/HTTPS) → TCP → IP

---

## Hands-on Checks

### Identity Check

```bash id="j66g7y"
hostname -I
```

Observation:

* Verified system IP address.

### Reachability Check

```bash id="vq3mf3"
ping google.com
```

Observation:

* Host reachable.
* No packet loss observed.
* Stable latency.

### Route Analysis

```bash id="sqh1sv"
traceroute google.com
```

Observation:

* Multiple network hops identified.
* Route successfully reached destination.

### Listening Services

```bash id="69qv56"
ss -tulpn
```

Observation:

* SSH service listening on port 22.

### DNS Resolution

```bash id="3e53kr"
dig google.com
```

Observation:

* Domain resolved successfully to public IP addresses.

### HTTP Check

```bash id="v77vho"
curl -I https://google.com
```

Observation:

* Received HTTP response successfully.

Example:

```text id="zrz1s0"
HTTP/2 200
```

### Connection Snapshot

```bash id="0dm9lk"
netstat -an | head
```

Observation:

* Identified LISTEN and ESTABLISHED connections.

---

## Port Probe

### Service

SSH (Port 22)

### Test

```bash id="k4mgtg"
nc -zv localhost 22
```

Output:

```text id="xh4t8t"
Connection to localhost 22 port [tcp/ssh] succeeded!
```

Observation:

* Port reachable.
* If unreachable, next checks would be:

  * systemctl status ssh
  * firewall rules
  * journalctl logs

---

## Reflection

### Which command gives the fastest signal when something is broken?

* ping
* systemctl status
* curl -I

### If DNS fails?

Check:

* DNS configuration
* Resolver settings
* Network Layer connectivity

### If HTTP 500 occurs?

Check:

* Application logs
* Web server logs
* Backend service status

### Two Follow-up Checks During an Incident

1. Review service logs using journalctl.
2. Verify listening ports and active connections using ss.

---

## What I Learned

1. Networking troubleshooting follows a layered approach.
2. DNS, connectivity, routing, and application checks help isolate issues quickly.
3. Tools like ping, traceroute, ss, dig, and curl are essential for day-to-day operations.

## Key Takeaway

Understanding networking fundamentals makes troubleshooting faster and helps identify whether an issue is related to DNS, connectivity, routing, or the application itself.


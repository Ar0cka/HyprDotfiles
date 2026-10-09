setDns() {
  echo "nameserver 192.168.50.1
nameserver 1.1.1.1
nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
}
# 🚀 Day 08 – Cloud Server Setup (Docker, Nginx & Web Deployment)

## 🔧 Commands Used

# Connect to server
ssh -i my-key.pem ubuntu@<your-instance-ip>

# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Install Nginx
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Check nginx status
sudo systemctl status nginx

# Check logs
sudo tail -f /var/log/nginx/access.log

# Save logs to file
cat /var/log/nginx/access.log > nginx-logs.txt

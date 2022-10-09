# install the containerd on ubuntu server
  # 1. Download the Containerd runtime with the command:
       wget https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz
  # 2. Unpack that file into /usr/local/ with the command: 
       sudo tar Cxzvf /usr/local containerd-1.6.8-linux-amd64.tar.gz    
# Configure containerd and start the service
sudo mkdir -p /etc/containerd
sudo su -
containerd config default  /etc/containerd/config.toml

# install the containerd on ubuntu server
  # 1. Download the Containerd runtime with the command:
       wget https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz
  # 2. Unpack that file into /usr/local/ with the command: 
       sudo tar Cxzvf /usr/local containerd-1.6.8-linux-amd64.tar.gz    
  # 3. we need the runc command line tool which is used to deploy containers with Containerd. Download this package with:
       wget https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64
  # 4. Install runc with:
       sudo install -m 755 runc.amd64 /usr/local/sbin/runc
  # 5. Create a new directory to house the Containerd configurations with:
       sudo mkdir /etc/containerd
  # 6. Create the configurations with:
       containerd config default | sudo tee /etc/containerd/config.toml
  # 7. Enable SystemdCgroup with the command:
       sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
  # 8. Download the required systemd file with:
       sudo curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service
  # 9. Reload the systemd daemon with:
       sudo systemctl daemon-reload
  # 10. Finally, start and enable the Containerd service with:
        sudo systemctl enable --now containerd
  # 11. You can verify everything is running with the command:
        sudo systemctl status containerd
        

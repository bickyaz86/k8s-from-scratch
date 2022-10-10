# Install kubeadm,kubelet & Kubectl
   # 1. Update the apt package index and install packages needed to use the Kubernetes apt repository:
	          sudo apt-get update
            sudo apt-get install -y apt-transport-https ca-certificates curl
	 # 2. Download the Google Cloud public signing key:
	          sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
	 # 3. Add the Kubernetes apt repository:
	          echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
   # 4.Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
            sudo apt-get update
            sudo apt-get install -y kubelet kubeadm kubectl
            sudo apt-mark hold kubelet kubeadm kubectl

# enable bridge networking
sudo vi /etc/sysctl.conf

# add the following at the bottom
net.bridge.bridge-nf-call-iptables = 1

# enable ip forwarding
sudo -s
sudo echo '1' > /proc/sys/net/ipv4/ip_forward

# Reload the configurations
sudo sysctl --system

# load modules for storage overlay and packet filter
sudo modprobe overlay
sudo modprobe br_netfilter

# disable swap
sudo swapoff -a

# pull containers for kubeadm
sudo kubeadm config images pull

# initialize the cluster
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# set config and permissions
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# install calico
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.24.1/manifests/calicoctl.yaml

# view the taints
kubectl get nodes -o=custom-columns=NODE:.metadata.name,KEY:.spec.taints[*].key,VALUE:.spec.taints[*].value,EFFECT:.spec.taints[*].effect

# untaint the node
kubectl taint no containerdvm node-role.kubernetes.io/master:NoSchedule-

# create a deployment
kubectl create deploy connector --image gcr.io/google-samples/kubernetes-bootcamp:v1

# poke a hole into the cluster and open a new tab
kubectl proxy

# curl localhost
curl http://localhost:8001/version

# get the pod name
kubectl get po

# access the pod from outside the cluster
curl http://localhost:8001/api/v1/namespaces/default/pods/connector-5b6c6d8d55-p6rjf

##**DSS Installation**

###Connection Information
- Private IP: 10.128.0.2
- Public IP: (see email)
- Port: 10000

Removed Kubernetes Nodes to reduce project costs. Please run GKE action in Dataiku to provision the cluster. 
### *Machine Requirements*
- Distribution: Ubuntu Server 20.04 LTS
- RAM: 16GB

### *System Requirements*

#### Limits
- min 65536 open files (ulimit -Hn)
- min 65536 user processes (ulimit -Hu)

#### Check if en_US.utf8 locale is installed
```shell
locale -a | grep "en_US.utf8"
if [ $? -eq 1 ]; then 
  echo 'updating locale' &&  sudo locale-gen en_US.utf8 && sudo update-locale
else 
  echo 'already installed'
fi);
```

#### Filesystem 
XFS or ext4 
- ext4 is default for Ubuntu 20.04

#### Additional Steps
- Add dataiku user 
- Open port on iptables
- Added port 10000 to http and https firewall rule
- current IPs are dynamic. Static IPs would be used for persistent environment or if deployed behind a HTTPS/HTTP load balancer 
### References 

The DSS reference documentation: https://doc.dataiku.com/dss/latest/installation/index.html

Reference deployment of DSS in GCP: https://doc.dataiku.com/dss/latest/cloud/gcp/reference-architectures/gke-gcs.html

Connecting DSS to a GKE cluster: https://doc.dataiku.com/dss/latest/containers/gke/managed.html

Configuring Managed Spark on Kubernetes within DSS: https://doc.dataiku.com/dss/latest/spark/kubernetes/managed.html

Reference setup for DSS with user isolation on Kubernetes: https://doc.dataiku.com/dss/latest/user-isolation/reference-architectures/kubernetes.html

Federated AD in GCP: https://cloud.google.com/architecture/identity/federating-gcp-with-active-directory-introduction

Join Ubuntu to AD: https://www.unixmen.com/how-to-join-an-ubuntu-desktop-into-an-active-directory-domaingcp 

#### Challenges
- Unable to connect to existing Europe West1 network (assumption)
    - Converted Default network to manual for deployment
    
- Unable to use GKE Regional Cluster for deployment 

### ERROR
```shell
Failed to start cluster : <class 'googleapiclient.errors.HttpError'> : <HttpError 400 when requesting https://container.googleapis.com/v1/projects/fe-assessment-03292021/zones/us-central1/clusters/autopilot-cluster-1?alt=json returned "'zone' field cannot be used to access GKE regional clusters. Use 'name' or 'parent' fields instead.". Details: "'zone' field cannot be used to access GKE regional clusters. Use 'name' or 'parent' fields instead.">

[2021-04-27 01:09:37,326] [17021/MainThread] [INFO] [dataiku.base.socket_block_link] Connecting to localhost (127.0.0.1) at port 34933[2021-04-27 01:09:37,326] [17021/MainThread] [INFO] [dataiku.base.socket_block_link] Connected to localhost (127.0.0.1) at port 34933[2021-04-27 01:09:37,455] [17021/MainThread] [INFO] [root] Connect using project_id= zone=us-central1 credentials=None[2021-04-27 01:09:37,464] [17021/MainThread] [INFO] [root] No project specified, using fe-assessment-03292021 as defaultTraceback (most recent call last):  File "/home/dataiku/dataiku-dss-9.0.0/python/dataiku/cluster/server.py", line 50, in serve
```

#### Add Documentation
Enable Kubernetes API from DSS VM

### ERRORS GKE Regional Clusters 
External code failed


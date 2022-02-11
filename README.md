# CUDA Code Server
Code Server Docker image for PyTorch with python development on the browser. Contains:
- CUDA 11.6.0
- OpenMP Library
- MPICH Library
- Code Server 4.0.2

## Requirements
- CUDA device with compute capability 3.5 or higher
- [NVIDIA Docker Toolkit](https://github.com/ghokun/nvidia-docker-host) following the [installation guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installing-on-ubuntu-and-debian)


## Quickstart
Create ```code-server/config.yaml``` as the configuration as the code-server config file

Optionally create ```env.list``` to specify environment variables for the code-server

Then run the script below to build the image locally
```
$ ./run.sh
```
After running above command open `localhost:8080` in your browser. 

## Why build the docker image locally?
This is the simplest way I found to install cuda development tools on Windows, specifically WSL. Please regard this as a software installation with docker as the package manager.
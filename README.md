# CUDA Code Server
Code Server Docker image for PyTorch with python development on the browser. Contains:
- CUDA 12.2.0
- OpenMP Library
- MPICH Library
- Code Server 4.16.1

## Requirements
- Docker on Linux or WSL
- CUDA device with compute capability 3.5 or higher
- [NVIDIA Docker Toolkit](https://github.com/ghokun/nvidia-docker-host) following the [installation guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installing-on-ubuntu-and-debian)


## Quickstart
Create ```code-server/config.yaml``` as the configuration as the code-server config file

Optionally modify ```EXTENSIONS_GALLERY``` to environment variables in ```docker-compose.yml```. Example usage on [VScodium documentation](https://github.com/VSCodium/vscodium/blob/master/DOCS.md#how-to-use-a-different-extension-gallery)

Your work will be saved in mounted directory `./projects`

Then run the script below to build the image locally
```
$ UID=${UID} GID=${GID} docker compose up --build -d
```
After running above command open `localhost:8080` in your browser. 

## Why build the docker image locally?
This is the simplest way I found to install cuda development tools on Windows, specifically WSL. I use docker as a distro agnostic package manager anyways.
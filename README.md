# CUDA Code Server
Code Server Docker image for PyTorch with python development on the browser. Contains:
- CUDA 12.6.1
- OpenMP Library
- MPICH Library
- Code Server 4.92.2

## Requirements
- Docker on Linux or WSL
- CUDA device with compute capability 5.0 or higher
- [NVIDIA Docker Toolkit](https://github.com/ghokun/nvidia-docker-host) following the [installation guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installing-on-ubuntu-and-debian)


## Quickstart
Create ```code-server/config.yaml``` as the configuration as the code-server config file

Optionally modify ```EXTENSIONS_GALLERY``` to environment variables in ```docker-compose.yml```. Example usage on [VScodium documentation](https://github.com/VSCodium/vscodium/blob/master/DOCS.md#how-to-use-a-different-extension-gallery)

Then run the script below to build the image locally
```
$ ./run.sh
```
After running above command open `localhost:8080` in your browser. 

## Why build the docker image locally?
This is the simplest way I found to install cuda development tools on Windows, specifically WSL. Please regard this as a software installation with docker as the package manager.

## docker compose / portainer stack example

``` yml
services:
  pytorch:
    image: pytorch-code-server:2.4.1 # your image name and tag
    volumes:
      - projects:/projects
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              capabilities: [gpu]
    restart: unless-stopped
    ports:
      - "8080:8080"
volumes:
  projects:
    external: false
```
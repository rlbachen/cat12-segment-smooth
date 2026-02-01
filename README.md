# cat12-segment-smooth

[![Docker Pulls](https://img.shields.io/docker/pulls/rlbachen/cat12-segment-smooth)](https://hub.docker.com/r/rlbachen/cat12-segment-smooth)
![Docker Image Size](https://img.shields.io/docker/image-size/rlbachen/cat12-segment-smooth/latest)
![Docker Tag](https://img.shields.io/docker/v/rlbachen/cat12-segment-smooth)

The image is published on Docker Hub:  
https://hub.docker.com/r/rlbachen/cat12-segment-smooth

This repository provides a Docker image based on  
https://hub.docker.com/r/jhuguetn/cat12 with an additional smoothing step using a kernel of `[6 6 6]`.

---

## Pull the image

```bash
docker pull rlbachen/cat12-segment-smooth
```

## Use with Apptainer (Singularity)

This image can be used on HPC systems via Apptainer by pulling directly from Docker Hub.

Build an Apptainer image from Docker Hub:

```bash
apptainer build cat12-segment-smooth.sif docker://rlbachen/cat12-segment-smooth
```

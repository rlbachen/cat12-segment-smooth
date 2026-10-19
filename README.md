# cat12-segment-smooth

[![Docker Pulls](https://badgen.net/docker/pulls/rlbachen/cat12-segment-smooth?icon=docker&label=pulls)](https://hub.docker.com/r/rlbachen/cat12-segment-smooth)
[![Docker Image Size](https://badgen.net/docker/size/rlbachen/cat12-segment-smooth/latest/amd64?icon=docker&label=image%20size)](https://hub.docker.com/r/rlbachen/cat12-segment-smooth/tags)
[![Docker Tag](https://badgen.net/badge/docker%20tag/latest/blue?icon=docker)](https://hub.docker.com/r/rlbachen/cat12-segment-smooth/tags)

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

## Run

The entrypoint takes a single uncompressed `.nii` path. CAT12 writes its outputs next to the input, so mount the directory that holds it.

Docker:

```bash
docker run --rm -v /path/to/data:/data rlbachen/cat12-segment-smooth /data/sub-01_T1w.nii
```

Apptainer:

```bash
apptainer run --bind /path/to/data:/data cat12-segment-smooth.sif /data/sub-01_T1w.nii
```

The smoothed grey matter map is written to `mri/s6mwp1<name>.nii` alongside the CAT12 segmentation outputs.

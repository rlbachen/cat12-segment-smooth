# cat12-segment-smooth

[![Docker Pulls](https://badgen.net/docker/pulls/rlbachen/cat12-segment-smooth?icon=docker&label=pulls)](https://hub.docker.com/r/rlbachen/cat12-segment-smooth)
[![Docker Image Size](https://badgen.net/docker/size/rlbachen/cat12-segment-smooth/latest/amd64?icon=docker&label=image%20size)](https://hub.docker.com/r/rlbachen/cat12-segment-smooth/tags)
[![Docker Tag](https://badgen.net/badge/docker%20tag/latest/blue?icon=docker)](https://hub.docker.com/r/rlbachen/cat12-segment-smooth/tags)
[![DOI](https://zenodo.org/badge/1140774976.svg)](https://doi.org/10.5281/zenodo.23789383)


The image is published on Docker Hub:  
https://hub.docker.com/r/rlbachen/cat12-segment-smooth

A single command CAT12 pipeline for voxel based morphometry: segments a T1w image with CAT12 and smooths the modulated grey matter map with a 6 mm FWHM Gaussian kernel. Built on [`jhuguetn/cat12`](https://hub.docker.com/r/jhuguetn/cat12), a standalone CAT12 image that needs no MATLAB license.

| Component | Version |
|---|---|
| SPM | SPM25 |
| MATLAB Runtime | R2023b |
| Platform | linux/amd64 |

---

## Pull the image

```bash
docker pull rlbachen/cat12-segment-smooth
```

For reproducible analyses, pin the archived v1.0.0 build by digest:

```bash
docker pull rlbachen/cat12-segment-smooth@sha256:b2b26a88a84ca42f1e126571c3f1bd8cb31bd8dd5444fe4e0fa318f48de6b250
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

With `--containall`, also bind a writable home, since the MATLAB Runtime writes to `$HOME/.matlab`:

```bash
apptainer run --containall --bind /path/to/data:/data --bind "$(mktemp -d)":/home/$USER \
  cat12-segment-smooth.sif /data/sub-01_T1w.nii
```

Batch over a BIDS dataset, one subject per call:

```bash
for t1 in /path/to/bids/sub-*/anat/*_T1w.nii; do
  apptainer run --bind /path/to/bids:/path/to/bids cat12-segment-smooth.sif "$t1"
done
```

## Outputs

All outputs are written next to the input image.

| File | Description |
|---|---|
| `mri/mwp1<name>.nii` | Modulated, normalized grey matter map |
| `mri/s6mwp1<name>.nii` | Same map smoothed with a 6 mm FWHM kernel |
| `report/` | CAT12 quality reports |

Gzipped `.nii.gz` inputs are not supported; decompress first with `gunzip`.

## Citation

If you use this image, please cite the Zenodo record:

> Encin, A. (2026). *cat12-segment-smooth: CAT12 segmentation container with 6 mm smoothing*. Zenodo. https://doi.org/10.5281/zenodo.23789383

Please also cite CAT12 and SPM:

> Gaser, C., Dahnke, R., Thompson, P. M., Kurth, F., Luders, E., & the Alzheimer's Disease Neuroimaging Initiative. (2024). CAT: a computational anatomy toolbox for the analysis of structural MRI data. *GigaScience*, 13, giae049. https://doi.org/10.1093/gigascience/giae049

Citation metadata is also available in [`CITATION.cff`](CITATION.cff), and GitHub's **Cite this repository** button.

## Credit

The base image [`jhuguetn/cat12`](https://hub.docker.com/r/jhuguetn/cat12) is maintained by Jordi Huguet. This repository only adds the smoothing step.

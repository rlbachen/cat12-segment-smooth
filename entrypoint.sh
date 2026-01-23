#!/bin/bash
set -e

INPUT_IMAGE="$1"
BASENAME=$(basename "$INPUT_IMAGE" .nii)
FULL_INPUT_PATH="$INPUT_IMAGE"

echo "Input image: $INPUT_IMAGE"
echo "Full path: $FULL_INPUT_PATH"
echo "Running CAT12 segmentation..."

# Run segmentation
/opt/spm/standalone/cat_standalone.sh -b /opt/spm/standalone/cat_standalone_segment.m "$FULL_INPUT_PATH"

echo "Segmentation done. Searching for mwp1${BASENAME}.nii ..."

# Updated: restrict search to the directory of the input image
MWP1_FILE=$(find "$(dirname "$INPUT_IMAGE")" -type f -name "mwp1${BASENAME}.nii" | head -n 1)

if [ -z "$MWP1_FILE" ]; then
  echo "mwp1 file not found. Aborting smoothing."
  exit 1
fi

echo "Found: $MWP1_FILE"
echo "Running smoothing with FWHM = [6 6 6] ..."

# Run smoothing
/opt/spm/standalone/cat_standalone.sh -b /opt/spm/standalone/cat_standalone_smooth.m \
  "$MWP1_FILE" -a1 "[6 6 6]" -a2 "'s6'"
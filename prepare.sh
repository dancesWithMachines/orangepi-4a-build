#!/bin/bash

# This script fixes build environment without touching any Orangepi scripts, settings, etc.
# The reason for it to exist is I don't want to play rebase game when they update the scripts.

set -e


####################################################################################################
# Fix 1
# It seems the tools now lay in the common directory ..pack-uboot/tools rather than
# ...pack-uboot/<SoC_series_id>/tools. Crate a link to fix the building issue.
####################################################################################################

target="/orangepi-build/external/packages/pack-uboot/tools"
link="/orangepi-build/external/packages/pack-uboot/sun55iw3/tools"

echo "# Creating a symlink for pack-uboot..."

# Ensure parent directory of link exists
mkdir -p "$(dirname "$link")"

# Create the symlink only if it doesn't exist
if [ ! -L "$link" ]; then
    ln -s "$target" "$link"
fi

####################################################################################################
# All jobs done
####################################################################################################

echo "# Done!"

#!/bin/bash
# ===========================================================================
# Copyright (c) 2019 Eclipse Foundation and others.
# 
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
# 
# Contributors:
# Christopher Guindon (Eclipse Foundation)
# 
# SPDX-License-Identifier: EPL-2.0
# ===========================================================================

echo "Processing Jakarta EE Specifications...\n"

echo "Step 1: Clean up specifications content\n"
rmdir /s/q content/specifications 
rmdir /s/q static/specifications

echo "Step 2: Clone specifications git repository"
git clone https://github.com/jakartaee/specifications.git content/specifications

echo "\nStep 3: Remove specifications/.git\n"
rmdir /s/q content/specifications/.git

echo "Step 4: Create static/specifications folder"
mkdir \ static/specifications
cd content
echo "Current working directory: $PWD\n"

echo "Step 5: Preparing to move html files to static folder..."
for f in specifications/*/*/*.html; do
  if [ -f "$f" ]; then
    echo "Moving $f to `dirname ../static/$f`"
    mkdir \ `dirname ../static/$f`
    move \ "$f" "../static/$f"
  fi
done

echo "Step 6: Preparing to move folders to static folder..."
for f in specifications/*/*/*/; do
  if [ -d "$f" ]; then
    echo "Moving $f folder to `dirname ../static/$f`"
    mkdir \ `dirname ../static/$f`
    move \ "$f" "../static/$f"
  fi
done

echo "Done!"

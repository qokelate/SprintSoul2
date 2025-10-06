#!/bin/zsh

set -ex

cd "$(dirname "$0")"

find . -type f | while read line; do
  file "$line" | grep -sq 'PC bitmap, Windows 3.x format' || continue

  "f:/windows/tools/ImageMagick-7.1.0-Q16-HDRI-static/magick.exe" "$line" "$line.bmp"
  mv -fv "$line.bmp" "$line"
  sleep 1
done

exit


#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
for item in adapter collector fit-coupon lid-front lid-back grommet-front grommet-back; do
 openscad -o "prototype-200w/parts/$item.stl" -D "build_part=\"$item\"" prototype-200w.scad
done
for segment in 0 1 2; do
 openscad -o "prototype-200w/parts/transition-$segment.stl" -D 'build_part="transition"' -D "segment=$segment" prototype-200w.scad
done
for item in lid-gasket face-gasket; do
 openscad -o "prototype-200w/parts/$item.dxf" -D "build_part=\"$item\"" prototype-200w.scad
done
for segment in 0 1; do
 openscad -o "prototype-200w/parts/joint-gasket-$segment.dxf" -D 'build_part="joint-gasket"' -D "segment=$segment" prototype-200w.scad
done
openscad -o prototype-200w/assembly.png --imgsize=1600,1100 --camera=0,150,80,65,0,35,1100 --viewall --autocenter --projection=o -D 'exploded=true' prototype-200w.scad

# Max 1100 cooling prototype

Current development: four GPUs at a hard **200 W per card**, horizontal motherboard, approximately 3 mm housing gaps. Build and test the suction duct before designing the enclosure.

- [Agreed plan](PROTOTYPE-PLAN.md)
- [Fabrication notes and physical test sequence](FABRICATION-200W.md)
- [200 W prototype CAD source](prototype-200w.scad)
- [Individual STL and gasket DXF parts](prototype-200w/parts/)
- [Exploded assembly](prototype-200w/assembly.png)
- [Blower support layout](prototype-200w/support-layout.svg)
- [200 W versus preserved 300 W design](COMPARISON.md)

## Print first: the fit coupon

Print [fit-coupon.stl](prototype-200w/parts/fit-coupon.stl) on its broad face: approximately 78 × 117 mm on the bed and 6 mm tall. PLA is suitable for this unpowered fit check. Try it over two adjacent GPU housing ends without forcing it or pressing against circuit boards or fins. This checks the approximate housing profile and 3 mm gap before committing to larger prints.

After the coupon fits, trial the complete four-card adapter and connected cable/bracket clearance. The remaining duct parts are approximate development geometry, not thermally validated hardware. No native Onshape document has been created; source CAD is OpenSCAD.

## Rebuilding the exports

Install OpenSCAD and make its `openscad` command available on your PATH, then run from the repository root:

```sh
sh prototype-200w/export.sh
```

The script regenerates the individual STL parts, gasket DXFs and exploded assembly PNG. CAD sources, fabrication exports, previews and manufacturer reference files are tracked so the project can be reviewed and the fit coupon printed without installing CAD software. Export logs, local editor files and duplicate build-package ZIPs are ignored. `part-sizes.json` records the current exported mesh bounds; the export script does not regenerate that report.

The earlier `duct-v1.*`, `DESIGN.md` and `BLOWER-SELECTION.md` describe the preserved 300 W alternative. `duct-200w.*` retain the earlier complete 200 W concept including the blower envelope. `prototype-200w.scad` adds fabrication details without overwriting either concept.

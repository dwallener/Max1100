# Four Max 1100 GPUs: 200 W prototype build notes

2026-09-18. Development parts, in millimetres. These exports are suitable for fit trials; hardware fit and thermal performance remain untested. The earlier 300 W design is preserved unchanged.

## Design basis

Four parallel card passages feed a sealed suction collector, a three-piece expanding transition, a nominal 203 mm straight inlet spool and the Fantech FG8 EC #49901. Each GPU must stay at or below 200 W total board power. Initial sizing is 120 CFM total at approximately 300 Pa; see [COMPARISON.md](COMPARISON.md) for manufacturer evidence and operating-point limitations. CPU and motherboard cooling require a separate air path.

The card reference envelope is 266.7 × 111.15 × 34.35 mm, with an assumed 3 mm housing gap. This gives a 37.35 mm pitch and 146.4 mm bank width. These envelopes do not establish the actual seal surface, brackets or connected harness geometry. The 120 mm collector provides provisional service space. Confirm which end should exhaust before testing; suction direction shown in CAD is an assumption.

## Files and quantities

Source: `prototype-200w.scad`. Exports: `prototype-200w/parts/`. Rebuild using `sh prototype-200w/export.sh` with OpenSCAD installed. All STL coordinates are in assembly space: rotate and place each part on the bed in the slicer.

| File | Build quantity | Purpose |
|---|---:|---|
| fit-coupon.stl | 1 first | Short two-card clearance trial; not an operating duct |
| adapter.stl | 1 after coupon | Replaceable four-window housing collar |
| collector.stl | 1 | Common chamber, lid rails and pressure-tap boss |
| lid-front.stl, lid-back.stl | 1 each | Split roof closes around connected cables |
| grommet-front.stl, grommet-back.stl | 4 each | Split flexible cable seals; provisional 10 mm bores |
| transition-0/1/2.stl | 1 each | Successive bolted duct sections |
| lid-gasket.dxf | 1 | Lid perimeter gasket |
| face-gasket.dxf | 2 | Adapter/collector and collector/transition seals |
| joint-gasket-0/1.dxf | 1 each | Two transition seam seals |

DXFs are full-size millimetre profiles, with bolt holes. Check one known dimension before cutting: face gasket width 214 mm. Gasket material and bolt washers/spacers are additional purchased/cut parts, not STL meshes. The blower, straight spool, isolation couplings, outlet guard and support are not included among these ten STL files.

## Fit and print sequence

1. Print the coupon flat on its broad face (approximately 78 × 117 mm footprint, 6 mm tall). With power off, try it against two adjacent housing ends. Never force the coupon onto fins, a PCB or connectors. Its rectangular windows are deliberate approximations; change the profile if the actual seal land differs.
2. Adjust `card_gap` and `fit_clearance` in the source if needed. Current clearance is 0.4 mm per side before adding seals. Print the full adapter and verify all four housings, bracket clearance and how it can be installed. Only proceed once it fits without transferring load to the cards.
3. Mock up the connected harness inside the collector envelope, including connector bend clearance. Four 18 mm roof openings contain split inserts with 10 mm cable bores. Edit `cable_bore` inside `grommet()` to suit the actual bundle; these are seals, not certified strain reliefs. Anchor cables independently on the support.
4. Print collector, lid and transition sections. The three transition sections are approximately 220 × 215, 225 × 238 and 225 × 246 mm across their ends, with lengths 100, 100 and 140 mm. A 300 mm bed accommodates these orientations and a brim; smaller machines may need another split. Collector envelope is 214 × 120 × 164 mm. Full bounds are recorded in `prototype-200w/part-sizes.json`.
5. Orient duct axes vertically where practical and inspect the slicer for flange overhangs and the collector roof rails. Use supports where needed. The model has nominal 3 mm walls; choose enough perimeters to make these solid, inspect seams and check for leakage. No universal slicing recipe is assumed.

Use a rigid material whose published continuous-service rating exceeds the measured local temperature with margin; make that choice before a powered test. A cold fit coupon may use ordinary prototype material. Use suitably rated compliant material for seals; the grommet shapes can also serve as tooling references for silicone parts. Filament type alone does not establish suitability.

## Seals and fasteners

- Line each collar window with replaceable soft strips, approximately 10 mm deep along the card. CAD shows 0.6 mm material compressed into 0.4 mm clearance. Treat this as a starting compression trial, not an established gasket specification. Seal against solid housing only, leaving fins and other intended openings clear.
- Use nominal 2 mm compliant sheet for flange and lid gaskets, initially targeting 1 mm compressed thickness. Confirm the material's recommended compression and use stops/shims to prevent crushing printed parts. The lid has a modelled 1 mm gap; flange gaskets add about 4 mm total axial stack across four joints, which is not included in the nominal CAD placement. Allow the support and spool alignment to move accordingly.
- Eight M4 bolts retain the lid. Six M4 bolts serve each of four duct flange joints: 24 flange bolts. All modelled clearance holes are 4.5 mm. Start with 14 M4 × 25 mm bolts (eight lid, six adapter joint), and 18 M4 × 20 mm bolts (remaining joints), plus washers and nuts. Confirm length and wrench access during dry assembly; substitute lengths as needed. Nuts are loose, not captured inserts.
- The two lid halves butt at the cable openings. Seal the exposed butt seam with removable temperature-rated airtight tape, and close the split grommet seams around the cables. There is no hidden overlapping seal at this joint. The removable perimeter gasket remains one piece.
- Use a small nipple fitted and sealed into the pressure boss; the model has a 3 mm pilot bore and 12 mm outer boss. Drill/fit it to the selected fitting and cap it when unused. Keep the internal opening flush and clear. Measure collector static pressure relative to the intake reference; this alone is not an airflow measurement.
- Support collector and blower independently. No blower weight, duct leverage or cable tension should be carried by the GPU housings. Use compatible isolation couplings at the spool and blower and prevent exhaust recirculation into the card inlets.

## Metal support layout

See `prototype-200w/support-layout.svg`: a provisional 380 × 282 mm rectangular base using 20 mm square tube, with slotted mounting straps for the supplied blower bracket. Cut two 282 mm side rails and two 340 mm cross rails for butt joints. Strap and bracket hole positions must be transferred from the actual supplied bracket. Establish height with the actual bracket so the inlet centre is 185 mm above the CAD reference plane; the 337 mm body then has nominal 16.5 mm bottom clearance. The reference plane is not necessarily the underside of the motherboard tray.

Use a separate adjustable cradle under the collector/transition, with compliant pads and straps outside the airflow path. Its exact height follows the motherboard standoffs and actual card seal land; it is intentionally not fixed by this drawing. Base feet, bracket fasteners and support strength need a shop fit check. This is a layout and cut list, not a released production drawing.

## Bench test and acceptance record

Before load, confirm correct airflow direction, unobstructed inlets, sealed joints and installed guards. Run the blower first. Verify the enforced 200 W board-power cap on every card, including after reboot or driver reset. Increase load in steps; stop escalation if temperatures keep climbing toward a device limit or any card throttles.

Record at every step: ambient/card inlet temperature; each card's actual board power, reported temperatures, clocks and thermal-throttle flags; collector/outlet air temperatures; collector pressure; independently measured flow; blower control setting; sound level at a fixed, documented distance. Repeatable sound measurements allow comparison even if the instrument is not calibrated.

Test all four simultaneously at the intended worst inlet temperature. After temperatures settle, sustain at least 30 minutes. Pass only with no thermal throttling, margin to the applicable device temperature limits, and noise acceptable to the user. Compare individual cards: a cool average must not conceal an undercooled passage. Then build the enclosure and repeat the thermal test with it fitted.

| Date / load step | Inlet °C | GPU power/temperature/throttle, all four | Flow / pressure | Blower setting / sound | Result |
|---|---|---|---|---|---|
| Not yet tested | — | — | — | — | Awaiting hardware fit trial |

## Digital checks completed

Ten STL exports completed with OpenSCAD manifold status `NoError`. Four gasket DXFs exported as nonempty 2D geometry. Exploded assembly visually reviewed and part bounds recorded. These checks establish export integrity, not mechanical fit, print quality or cooling performance. Original 300 W model, render, mesh and selection/design documents retain their recorded SHA-256 hashes.

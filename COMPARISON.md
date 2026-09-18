# Four Max 1100 GPUs: 200 W versus 300 W per card

Both designs are retained. The previous 300 W files (`duct-v1.*`, `BLOWER-SELECTION.md`, `DESIGN.md`) are unchanged. Their SHA-256 hashes are recorded in `preserved-300w-sha256.json`. The new alternative is `duct-200w.scad`; `compare-power-designs.scad` displays both at the same scale.

## Comparison

| Design quantity | Previous 300 W/card | New 200 W/card |
|---|---:|---:|
| GPU heat, four cards | 1,200 W | 800 W |
| Provisional total airflow | 160 CFM | 120 CFM |
| Provisional system pressure | 500 Pa | 300 Pa |
| Per-card airflow | 40 CFM | 30 CFM |
| Intel card pressure at that flow | 399 Pa | 247 Pa |
| Allowance for other losses | ~101 Pa | ~53 Pa |
| Blower | FG 12XL EC #49905 | FG 8 EC #49901 |
| Nominal duct connection | 305 mm / 12 inch | 203 mm / 8 inch |
| Blower casing diameter | 406 mm | 337 mm |
| Collector length | 120 mm | 120 mm |
| Transition length | 550 mm | 300 mm |
| Straight inlet spool | 305 mm | 203 mm |
| Custom duct length, including collar | 710 mm | 460 mm |
| Whole straight test layout including cards | 1,695 mm | 1,262 mm |
| Maximum width, at support frame | 460 mm | 380 mm |
| Height, frame bottom to terminal box top | 504 mm | 435 mm |
| Calculated blower input at reference sizing point | 125 W | 55 W |
| Calculated control signal at reference sizing point | 9.8 V | 8.8 V |

The new layout is about 26% shorter, its support is 17% narrower, and custom duct length is 35% shorter. The lengths include different outlet stubs (150 mm versus 100 mm). These are complete straight test rigs, not motherboard/enclosure dimensions. The blower may later be relocated alongside the enclosure. Retaining the large fan at 200 W is also possible; downsizing is a packaging choice, not a requirement of the power cap.

## New blower verification

Selected: Fantech FG 8 EC #49901, 120 V, single phase, 60 Hz. Manufacturer page and live calculation inspected 2026-09-18:

https://www.fantech.net/en-us/products/fans-and-accessories/inline-duct-fans/fg?sku=49901

Calculator version: 2026-09-02.07:32, FG8 EC, identifiers 29419 / 30018. At 0.075 lb/ft3 density, requested 120 CFM and entered 1.205 in.wg (display rounded to 1.21), returned working values:

- 120 CFM, 1.21 in.wg (approximately 301 Pa)
- 55 W input, 2,386 RPM, 0.86 A, 8.8 V control
- Inlet sound power 66 dB(A), outlet sound power 67 dB(A)

At entered density 0.068 lb/ft3 (approximately 1.089 kg/m3, representing warm air near 50 C at sea-level pressure), with the same requested point, the calculator returned 120 CFM, 1.33 in.wg, 61 W, 2,493 RPM, 0.99 A and 9.3 V control; inlet/outlet sound power 67/69 dB(A). Reported working pressure differs from the request; do not conceal that or treat the result as a measured system operating point. Both calculations remain below the 10 V maximum control signal.

These are manufacturer calculations, not hardware tests. Sound power is not sound pressure at the desk; the 6 dB difference from the older design's reference outlet sound-power result does not establish a 6 dB room-noise reduction. Both may still need attenuation.

The live product data gives 80 W nominal input, 1.28 A nominal current, 337 mm casing diameter, 152 mm body depth with two 25 mm spigots, 8.4 lb weight and a maximum transported-air temperature of 140 F / 60 C. The body plus spigots occupies 202 mm axially. Terminal-box width/height are 95/51 mm; the model's 70 mm box depth is an explicit packaging allowance. Exact casing shape and mounting pattern are not reproduced.

## Why 120 CFM

At equal bulk temperature rise, two-thirds of the previous 160 CFM would be approximately 107 CFM. The new 120 CFM target gives some extra airflow. At 800 W and 120 CFM, the ideal bulk temperature rise is approximately 11.7 C at air density 1.2 kg/m3 and cp 1005 J/kg K. GPU/HBM junction temperatures cannot be inferred from this calculation.

Intel pressure polynomial: `249.09 * (-0.0137 + 0.0127*q + 0.0007*q*q - 0.0000002*q*q*q)` Pa, q in CFM per card. At 30 CFM per card it gives 247 Pa. Four parallel paths add flow, not pressure. The 300 Pa total target leaves only about 53 Pa at reference conditions for transition, fittings, guards and leakage effects. A filter or silencer must be evaluated separately; no unverified loss allowance is assigned to one.

Intel source: https://cdrdv2-public.intel.com/817799/817799_Intel%20Data%20Center%20GPU%20Max%201100%20Datasheet_Rev_1_0.pdf

## New geometry and parts

- Same provisional 180 x 130 mm collector and card interface as the previous version. 200 W concept now uses the user-provided approximate 3 mm housing gap: 37.35 mm pitch and 146.4 mm bank width. The preserved 300 W model retains its original 40.64 mm pitch; both remain nominal packaging assumptions, not claims about actual PCIe slot centers.
- 300 mm transition, outlet centerline 185 mm above card reference datum.
- 203 mm OD / 197 mm ID custom collar; confirm compatibility with actual purchased clamp and fan spigot OD. Nominal 8-inch connections are not asserted to be exact machined diameters.
- Straight metal inlet: 203 mm; outlet stub: 100 mm. These are design allowances, not claimed manufacturer minimum lengths.
- Independent 380 x 282 mm steel support-frame envelope. Bracket placement and holes must fit the supplied OEM mounting bracket. No load is carried by the card bank. Frame is not structurally certified.
- Three generic resilient joint envelopes sized for an 8-inch connection, replacing the 12-inch joints. Use compatible FC8-type isolation clamps; verify dimensions/gap capacity before purchase or fabrication.
- Speed control: built-in potentiometer initially, optional compatible EC-10V controller. Follow manufacturer wiring, separate 120 V supply and protective earthing; no motherboard-header power.
- Add suitable outlet guard; optional 8-inch silencer only after pressure and noise testing.

The STL contains custom duct only. Purchased fan, spool, clamps and support envelope are shown in the assembly render. Neither variant is print-ready: service lid, printable splits/joints, fitted card seals, cable exits, GPU airflow direction and actual bracket mounting details remain unresolved. No component was bought and no Onshape document was created.

## Test and power-cap requirement

The 200 W limit means TOTAL board power per GPU, enforced before workload launch and restored after reboot, driver reset and recovery. If the limit cannot be verified, do not start the workload. Brief power transients and fan failure still require thermal monitoring and workload shutdown.

Use the existing staged procedure in DESIGN.md, substituting 200 W/card for the final load. Test all four cards concurrently at the highest expected inlet temperature. Record actual power cap and draw, GPU/HBM temperatures, sustained clocks, thermal-throttle flags, inlet/exhaust temperatures, airflow, differential pressure and sound at a fixed listener distance. Demonstrate stable temperatures and sustained operation before accepting the design. Stop load on airflow loss or invalid cap state. No performance-loss percentage from the cap is assumed; benchmark the intended workload.

## Approximate card-end interface update

The 200 W concept now includes a replaceable four-window adapter, short housing sleeve with between-card webs, and an overlapping removable roof panel. An exploded interface preview is in interface-200w.png. No additional measurement is needed to continue conceptual work.

The adapter uses four 34.35 x 111.15 mm reference card envelopes, separated by the user's approximate 3 mm gap. Provisional per-side clearance is 0.4 mm, leaving 2.2 mm rigid webs between windows. Overall bank width is 146.4 mm. The 8 mm adapter plate bolts to the existing collector flange; a 15 mm sleeve overlaps the housing ends. These windows represent full packaging envelopes, not measured heatsink apertures. Soft gasket lips, electrical clearances and contact surfaces remain to be refined. The collar must not clamp bare boards or fins.

The 120 mm chamber reserves room for the photographed end brackets and power harness. Four provisional 18 mm roof holes mark split-grommet cable routes; hole sizes and locations are placeholders, not connector pass-through dimensions. Split glands permit installation around connected cables. The lid is shown raised only in the exploded view; in the assembly it overlaps the roof opening. Lid fasteners, gasket details and individual gland inserts are not yet modeled. Actual harness routing can change without replacing the long transition.

Part selectors adapter and lid export these separately; interface shows the close-up. adapter-200w.stl is a validated concept mesh, not a fabrication release. The main duct STL excludes the separate adapter and lid. Power-cap, airflow-direction and physical validation assumptions above still apply. Prior 300 W files are preserved unchanged.

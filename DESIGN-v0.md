# Max 1100 duct prototype, revision 0

Status: packaging concept; not a fabrication release or thermally validated design. No Onshape document has been created. Editable geometry is in duct-v0.scad. All dimensions are millimetres.

## Architecture

Four cards in parallel, each drawing room air through its own heatsink. A sealed card-end adapter feeds a shared suction chamber, a gradual rectangular-to-round transition, and a short 200 mm duct to a separate housed, speed-controlled centrifugal blower. Exhaust stays away from GPU intakes. No 40 mm fans. Motherboard remains horizontal, cards vertical in slots as photographed. CPU cooling is separate and is outside this prototype.

The collector is independently supported. Soft seals contact the card housings, never bare boards or heatsink fins. Bridge, PCIe slots and power connectors carry no duct load. The photographed connector/extension-bracket end is a provisional collector location, NOT a confirmed Intel airflow direction. Verify direction from integration guidance or controlled comparison before fitting the end adapter.

## Airflow basis

Intel datasheet revision 1.0, page 32 gives card pressure drop:

    pressure_inH2O = -0.0137 + 0.0127*q + 0.0007*q^2 - 0.0000002*q^3
    q = per-card flow in CFM; 1 inH2O = 249.09 Pa

At 30 CFM/card: 0.9919 inH2O = 247 Pa; total four-card flow is 120 CFM.
At 40 CFM/card: 1.6015 inH2O = 399 Pa; total four-card flow is 160 CFM.
Parallel cards add flow, not pressure. Assumes comparable paths and good seals.

Initial blower procurement envelope: a manufacturer-confirmed operating point of at least 160 CFM (272 m3/h) at 500 Pa external static pressure, with speed control. This provides a provisional ~100 Pa allowance above the 40 CFM/card curve point for the duct, seals and guards. It is NOT measured system resistance, a guaranteed thermal requirement, or permission to substitute a 160 CFM free-air rating and a separate 500 Pa shutoff rating. Check hot-air rating and the actual housed blower curve. No particular blower is selected yet.

At 120 / 160 CFM total, 1,200 W gives ideal bulk air rises of approximately 17.6 / 13.2 C, using air density 1.2 kg/m3 and cp 1005 J/kg K. These do not predict GPU/HBM temperatures. Intel page 29 separately specifies approach velocity versus inlet temperature; establish the relevant inlet measurement area and check that requirement during testing. Do not convert using an assumed open-fin area.

Intel source: https://cdrdv2-public.intel.com/817799/817799_Intel%20Data%20Center%20GPU%20Max%201100%20Datasheet_Rev_1_0.pdf

## Geometry and fabrication status

- Card reference envelopes: 266.7 long, 111.15 high, 34.35 wide (Intel table); assumed 40.64 pitch. Actual seal profile is smaller/different from the full card envelope and must be measured.
- Collector clear section: 180 x 130, length 120. Deliberate service room for cable routing and projecting brackets; check actual harness bend requirements.
- Transition: 220 long, from collector section to 200 clear-diameter outlet. Outlet collar: 40 long. Wall: 3. Joining flanges: 5 thick, 14 wide, M4 clearance holes.
- Approximate duct body length: 380, excluding blower/connecting hose. Envelope including front flanges: 214 wide by 220 high. These are adjustable design choices.
- SCAD includes collector, transition, outlet and reference card boxes. It does NOT include the fitted card-end seal plate, between-card bypass seals, cable pass-throughs, service lid, brackets, pressure taps, guards, print splits or blower mounting. These must be detailed before fabrication.
- Use a sheet-metal collector with removable gasketed lid for first thermal testing; printed transition/collar are options after material temperature limits are checked. Do not assume a printed polymer is suitable from room-temperature fit alone.
- Transition and collar meet at a butt seam in the concept. Add a bonded sleeve or bolted joint before separate fabrication. The 220 mm transition may need splitting for the available printer.

## Test that decides whether to build the enclosure

1. Fit seals and supports with power off. Install a proper CPU/cooler and support the motherboard on standoffs for powered tests. Route and secure GPU power cables, maintaining manufacturer bend clearance. Install blower guard and proper power/control hardware.
2. Run blower first, check bypass leakage and inlet/exhaust separation. Use pressure taps in calm regions upstream and downstream of the card bank with a differential manometer. Keep taps clear of jets. A bank pressure reading cannot prove equal flow through each card.
3. At conservative GPU power, record room/card inlet temperatures, GPU/HBM temperatures, each card's power, clocks and thermal-throttle flags, blower speed, differential pressure and sound at a fixed distance. Log every card, not just an average.
4. Increase load/power in steps, then operate all four at the intended 300 W/card and representative workload. Observe until temperatures settle, then sustain at least 30 minutes. Stop escalation on throttle, uncontrolled temperature rise or any component limit. Test inlet temperature expected in actual use.
5. Pass only with no thermal throttling, sustained intended performance, temperatures below published limits with useful margin, and acceptable measured noise. Use 90 C GPU/HBM as an initial conservative project target, not an Intel specification; verify valid HBM sensor channels and all component-specific limits. Intel notes a disabled HBM stack can report invalid values.
6. Reduce blower speed to find the quietest passing operating point. If one card is hotter, inspect its inlet, seals and obstruction before adding speed. Repeat at maximum expected room temperature and after adding the enclosure/filter/guards because those change resistance.
7. Before unattended operation, tie loss of blower/airflow to workload stop or shutdown. Never rely on a static CAD model to establish thermal safety.

Next physical inputs: actual four-card end profile/pitch, bracket and connected-cable envelope, and intended airflow direction. These are fit-release requirements, not prerequisites to discussing this concept.

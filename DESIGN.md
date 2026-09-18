# Max 1100 cooling prototype, revision 1

Selected blower: Fantech FG 12XL EC #49905, 120 V / 60 Hz. See [selection, evidence and bill of materials](BLOWER-SELECTION.md).

Current editable assembly: duct-v1.scad. duct-v1.stl contains only the custom duct. duct-v1.png shows the assembly. Revision 0 is retained separately for history.

## Current design

Four parallel GPU airflow paths feed a 180 x 130 mm clear collector, 120 mm long. A 550 mm transition leads to a 305 mm nominal connection and straight inlet spool. The purchased blower and its isolation connections sit on an independent frame. CPU and motherboard cooling remain separate. The full straight test layout is approximately 1,695 x 460 x 505 mm, including reference card envelopes.

Intel's pressure polynomial gives approximately 247 Pa at 30 CFM/card and 399 Pa at 40 CFM/card. Four parallel cards therefore need 120 or 160 CFM total at those pressures, plus duct losses. The initial allowance is 160 CFM at 500 Pa at reference density. Fantech's live calculator reaches that point at nearly full drive; hot-air reserve is limited. See the selection note for exact calculator results and limitations.

Status: model checked as manifold and rendered for visual inspection. It has not been fabricated, fit checked, structurally certified or thermally tested. The fan is a purchased-component clearance envelope, not a manufacturer CAD solid. There is no Onshape document yet.

Still required before fabrication: fitted card seals, cable exit profiles, actual GPU pitch, airflow-direction verification, service lid and print splits, collar attachment, and OEM blower bracket mounting holes. Verify purchased coupling fits and keep all assembly load off the GPUs. The blower can be moved remotely without changing the card collector.

## Test that decides whether to build the enclosure

1. Fit seals and supports with power off. Install a proper CPU/cooler and support the motherboard on standoffs for powered tests. Route and secure GPU power cables, maintaining manufacturer bend clearance. Install blower guard and proper power/control hardware.
2. Run blower first, check bypass leakage and inlet/exhaust separation. Use pressure taps in calm regions upstream and downstream of the card bank with a differential manometer. Keep taps clear of jets. A bank pressure reading cannot prove equal flow through each card.
3. At conservative GPU power, record room/card inlet temperatures, GPU/HBM temperatures, each card's power, clocks and thermal-throttle flags, blower speed, differential pressure and sound at a fixed distance. Log every card, not just an average.
4. Increase load/power in steps, then operate all four at the intended 300 W/card and representative workload. Observe until temperatures settle, then sustain at least 30 minutes. Stop escalation on throttle, uncontrolled temperature rise or any component limit. Test inlet temperature expected in actual use.
5. Pass only with no thermal throttling, sustained intended performance, temperatures below published limits with useful margin, and acceptable measured noise. Use 90 C GPU/HBM as an initial conservative project target, not an Intel specification; verify valid HBM sensor channels and all component-specific limits. Intel notes a disabled HBM stack can report invalid values.
6. Reduce blower speed to find the quietest passing operating point. If one card is hotter, inspect its inlet, seals and obstruction before adding speed. Repeat at maximum expected room temperature and after adding the enclosure/filter/guards because those change resistance.
7. Before unattended operation, tie loss of blower/airflow to workload stop or shutdown. Never rely on a static CAD model to establish thermal safety.

Next physical inputs: actual four-card end profile/pitch, bracket and connected-cable envelope, and intended airflow direction. These are fit-release requirements, not prerequisites to discussing this concept.

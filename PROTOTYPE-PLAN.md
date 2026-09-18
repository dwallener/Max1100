# Max 1100 cooling prototype: agreed plan

2026-09-18. Proceed on four GPUs, each with a hard 200 W total-board-power limit. Motherboard horizontal; GPU housings approximately 3 mm apart. Precise measurements are not a prerequisite for concept development. Retain the 300 W alternative for comparison.

## Decisions

- Sealed suction collector serves four parallel GPU heatsinks. Keep the CPU/motherboard air path separate.
- Use the FG8 EC blower selected in COMPARISON.md. Target 120 CFM at approximately 300 Pa for initial sizing, not a validated cooling guarantee.
- Prototype adapter and seals first; modular duct and independent support second. Enclosure follows successful thermal/noise tests.
- Fit-sensitive dimensions are editable assumptions. Do not make the user remeasure dimensions already documented by Intel.
- No purchases, print jobs or hardware tests have been performed by the assistant.

## This design iteration

Create a fabrication-development source in prototype-200w.scad without changing earlier models. Include a bolt-on adapter, replaceable soft seal strips, split lid and cable grommets, three bolted transition sections, pressure-tap provision, and a support layout. Export individual concept parts and gasket profiles. Check manifold geometry and visually inspect the assembly. Document parts, assembly order and test records.

## Physical progression

1. Print the small two-card fit coupon; check housing clearance and the assumed 3 mm gap with power off. Keep it away from boards and fins. Adjust fit_clearance/card_gap if needed.
2. Fit the complete adapter and soft seals; verify bracket and connected harness clearance in the collector. Confirm GPU airflow direction before powered testing.
3. Fabricate collector/duct sections and support; bolt gasketed joints, fit split cable glands, cap unused pressure taps, mount blower independently and install guards.
4. Verify the 200 W cap on every card before launching load. Start blower first. Increase load in steps, recording per-card temperature, actual power, clock and throttle flags plus inlet/outlet air, airflow, differential pressure and sound.
5. Test all four concurrently at the intended inlet temperature. Once temperatures settle, sustain at least 30 minutes; accept only with no thermal throttling, temperature margin and acceptable noise. Add the enclosure only after passing, then repeat the test.

Physical fit, fabrication, airflow-direction confirmation and live tests require access to the user's hardware. CAD validation does not complete these steps. See FABRICATION-200W.md for the next build package and explicit limitations.

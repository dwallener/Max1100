# Selected blower and integration, revision 1

Selected for the prototype: **Fantech FG 12XL EC, item 49905, 120 V / single phase / 60 Hz**. This is a complete housed centrifugal inline fan. No purchase has been made. Current vendor stock, lead time and price have not been verified.

## Selection evidence

The live Fantech product selector and its embedded Systemair calculation tool were inspected on 2026-09-18. Product 49905, variant 99711, calculator version 2026-09-02.07:32. Source:
https://www.fantech.net/en-us/products/fans-and-accessories/inline-duct-fans/fg?sku=49905

At air density 0.075 lb/ft3, input 160 CFM and 2.01 in.wg (~501 Pa), the calculator returned:

| Quantity | Manufacturer calculator result |
|---|---:|
| Working airflow | 160 CFM |
| Working static pressure | 2.01 in.wg |
| Input power | 125 W |
| Fan speed | 2,635 RPM |
| Control signal | 9.8 V |
| Current | 1.60 A |
| Inlet sound power | 71 dB(A) |
| Outlet sound power | 73 dB(A) |

These are calculated fan operating-point data, not measurements of this GPU assembly. Sound power is NOT sound pressure at the listener and must not be advertised as a 73 dBA room noise level. The operating RPM differs from the nominal product-sheet RPM; it is reported as the calculator result without substituting it for the nameplate rating.

This meets our initial reference-density sizing point with little remaining speed-control margin. A second calculation at entered density 0.0675 lb/ft3 (display rounded to 0.068) returned 155 CFM, 2.09 in.wg and 10.0 V rather than the requested point. Thus it is NOT a verified 160 CFM / 500 Pa selection at hot exhaust density. System resistance also changes with density, but the actual nonuniform heated card/duct system must be measured. Do not assume constant cooling mass flow as air temperature rises. The selection is for the test prototype, not an unconditional thermal guarantee.

An older 2016 brochure lists a 1.96 in.wg shutoff pressure for the same model. The newer 2025 makeup-air table lists 2.51 in.wg. We used the live manufacturer's model-specific calculator instead of mixing those versions. Obtain a current submittal matching the supplied unit before purchasing old stock or a used blower.

The older FG8 EC and FG10 EC tables do not meet 160 CFM at 500 Pa; extra free-air capacity does not compensate for insufficient pressure. The selected 12-inch fan's size is accepted because the user prioritized function over footprint.

## Physical integration in duct-v1.scad

- Replace the earlier 200 mm outlet with **305 mm nominal duct size**. Printed adapter is 305 mm OD / 299 mm ID, 3 mm wall. This is an interface design choice; measure fan spigot OD and chosen clamp fit before printing. No interference fit is assumed.
- Keep the provisional 180 x 130 mm collector clear section and 120 mm service chamber.
- Increase transition length to 550 mm and raise round centerline to 220 mm above the card-envelope datum. This clears the large fan casing while retaining a gradual connection. No CFD validation is claimed.
- Provide a 305 mm long straight sheet-metal inlet spool, with resilient FC12 connection envelopes at each end. Straight length is a design allowance, not a certified manufacturer's minimum. Alter if commissioning shows inlet distortion.
- Model the fan as a **406 mm diameter purchased-component envelope**, with 170 mm axial body, 38 mm and 25 mm necks: 233 mm end-to-end. Dimensions follow the 2025 IOM, printed page 19. The terminal box uses published 95 mm width and 51 mm height; its 70 mm depth is an explicit clearance assumption. Casting shape and internal rotor are intentionally not modeled.
- Physical fan arrow must point away from the GPUs. The reference model does not establish fan inlet/outlet by silhouette. If the 38/25 mm necks fall on opposite sides, swap the two parameters and reposition the spool by 13 mm.
- Add an independent steel frame 460 mm wide and 313 mm long beneath the blower; OEM mounting bracket connects to adjustable side supports. Exact bracket holes and final bracket-to-rail fasteners require the received bracket. The frame is a support layout, not a released drilling drawing or load-certified structure.
- Retain a 150 mm outlet stub and native 12-inch connection for a guard / optional silencer. Do not leave the fan accessible without a suitable guard. Optional LD12 silencer is not included in the current geometry or loss allowance as a validated item.
- Total modeled run including 266.7 mm card envelopes is approximately 1,695 mm long, 460 mm wide at the support, and 505 mm tall from frame bottom to terminal-box top. The blower can be placed remotely; this straight test-bench arrangement is not the final case footprint.

SCAD part selectors: assembly (purchased references included), duct (custom collector + transition + collar only), collector, transition, outlet, stand. The delivered STL contains only the custom duct, not the purchased blower. It is still a fit-prototype mesh, not a print release; segmentation, service lid, card seals, cable glands and transition/collar joint details remain pending. Reference GPU pitch remains assumed.

## Prototype bill of materials

| Qty | Item | Status / purpose |
|---:|---|---|
| 1 | Fantech FG 12XL EC, 49905, 120 V 60 Hz | Selected blower; current supplied version must match curve |
| 1 | Fantech EC-10V, 498148 | Optional accessible manual speed controller; built-in potentiometer can commission first |
| 2 packs | Fantech FC12, 411123 (2 clamps per pack) | Three modeled connection positions, one spare; verify allowable joint gap/OD |
| 1 | 12-inch straight metal duct, 305 mm long | Inlet spool; deburr and seal joints |
| 1 | 12-inch straight metal duct, 150 mm long | Outlet stub |
| 1 | Guard appropriate to accessible outlet | Verify attachment and exhaust suitability; do not substitute an obstructive grille |
| 1 set | Independent metal support + OEM bracket + isolation mounts | Mount pattern to actual supplied bracket; size mounts for fan/frame load |
| 1 set | Collector, transition, seals and pressure taps | Custom parts; fit details pending |
| Optional | Fantech LD12, 411287 | Exhaust attenuation if noise testing requires it; remeasure pressure/flow |

Accessories and item IDs were listed on the selected blower's live manufacturer page. No dimensions of purchased clamps, mounts, guard or silencer are asserted as verified.

## Electrical and commissioning decisions

Use the manufacturer's 120 V mains connection and protective earthing, with enclosed terminals and strain relief. This fan is not powered by a motherboard fan header. Speed control is its built-in potentiometer or compatible 0-10 V controller; do not reduce mains voltage with a household dimmer. Follow the supplied revision-specific wiring diagram rather than assuming PC PWM/tach pin compatibility.

Maximum transported-air temperature is 140 F / 60 C. Measure air entering the blower; start with an alarm target of 50 C to leave margin. The initial 160 CFM / 500 Pa sizing point is almost full drive. Reduce speed only after per-card thermal testing shows sufficient margin. A larger blower can remove the 40 mm tonal whine without being quiet at high pressure: acoustic acceptance remains a physical test.

Continue the staged per-card test in DESIGN.md. At final load, measure card inlet/outlet air, GPU/HBM temperature, delivered flow, pressure drop, electrical power and sound. If hot-air testing needs more pressure or unacceptable speed, revise the blower selection rather than claiming the prototype meets the target.

## Saved manufacturer references

- sources/fantech-fg-installation-2025.pdf: mounting, control, thermal limits and dimensions (printed pp. 1, 7-10, 16-19).
- sources/fantech-fg-ec-submittal-2023.pdf: earlier dimensional comparison; 2025 IOM wins where neck lengths differ.
- sources/fantech-dimensions.png: dimension-letter drawing from live product page.

Direct manufacturer documents:
https://stepimassets.blob.core.windows.net/dsassetsprod/400017_IOM_FG_EN_20250305_211356199.PDF
https://stepimassets.blob.core.windows.net/dsassetsprod/483358_FG_EC_SUBMITTAL_SHEET_EN_20230130_230036535.PDF
https://stepimassets.blob.core.windows.net/dsassetsprod/E1574_MAKEUP_AIR_SYSTEM_20250114_203357183.PDF

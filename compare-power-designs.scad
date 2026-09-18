// Both alternatives at the same physical scale. Purchased parts are envelopes.
module design300() { include <duct-v1.scad> }
module design200() { include <duct-200w.scad> }
translate([0,0,0]) design300();
translate([630,0,0]) design200();
// Labels are placed in the XY plane for the orthographic top-view render.
color([0.15,0.15,0.15]) {
    translate([-265,-255,0]) rotate([0,0,90])
        linear_extrude(1) text("300 W/card | 1,695 mm",size=32);
    translate([385,-255,0]) rotate([0,0,90])
        linear_extrude(1) text("200 W/card | 1,262 mm",size=32);
}

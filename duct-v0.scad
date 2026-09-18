// MAX 1100 four-card suction duct: packaging concept, millimetres.
// NOT FIT-CHECKED. Card-end seals, cable glands and supports require measurements.
// Air travels along +Y; motherboard is horizontal in XY.
part = "assembly"; // assembly, collector, transition, outlet
show_cards = true;
wall = 3;
mouth_w = 180;       // provisional clear collector width
mouth_h = 130;       // provisional clear collector height
collector_l = 120;   // bracket/cable service volume, verify with actual harness
transition_l = 220;
outlet_id = 200;
outlet_l = 40;
flange = 14;
flange_t = 5;
bolt_d = 4.5;
card_pitch = 40.64;  // ASSUMED dual-slot pitch, measure installed bank
card_w = 34.35;
card_h = 111.15;
card_l = 266.7;
$fn = 96;

module rect_section(w,h,y,t) {
    translate([-w/2,y,-wall]) cube([w,t,h]);
}
module axial_cylinder(d,y,l) {
    translate([0,y,outlet_id/2]) rotate([-90,0,0]) cylinder(d=d,h=l);
}
module bolt_pattern(y,len) {
    for (x=[-mouth_w/2-wall-flange/2,mouth_w/2+wall+flange/2])
        for(z=[flange/2,mouth_h/2,mouth_h-flange/2])
            translate([x,y,z]) rotate([-90,0,0]) cylinder(d=bolt_d,h=len);
}
module rectangular_flange(y) {
    difference() {
        translate([-mouth_w/2-wall-flange,y,-wall-flange])
            cube([mouth_w+2*(wall+flange),flange_t,mouth_h+2*(wall+flange)]);
        translate([-mouth_w/2,y-1,0]) cube([mouth_w,flange_t+2,mouth_h]);
        bolt_pattern(y-1,flange_t+2);
    }
}
module collector() {
    difference() {
        translate([-mouth_w/2-wall,0,-wall])
            cube([mouth_w+2*wall,collector_l,mouth_h+2*wall]);
        translate([-mouth_w/2,-1,0]) cube([mouth_w,collector_l+2,mouth_h]);
    }
    rectangular_flange(0);
    rectangular_flange(collector_l-flange_t);
}
module transition() {
    difference() {
        hull() {
            rect_section(mouth_w+2*wall,mouth_h+2*wall,collector_l,1);
            axial_cylinder(outlet_id+2*wall,collector_l+transition_l-1,1);
        }
        hull() {
            translate([-mouth_w/2,collector_l-1,0]) cube([mouth_w,2,mouth_h]);
            axial_cylinder(outlet_id,collector_l+transition_l-1,2);
        }
    }
    rectangular_flange(collector_l);
}
module outlet() {
    difference() {
        axial_cylinder(outlet_id+2*wall,collector_l+transition_l,outlet_l);
        axial_cylinder(outlet_id,collector_l+transition_l-1,outlet_l+2);
    }
}
module reference_cards() {
    // Transparent packaging envelopes only; connectors/bridge/brackets omitted.
    for(i=[0:3])
        color([0.3,0.45,0.6,0.35])
            translate([(i-1.5)*card_pitch-card_w/2,-card_l,0])
                cube([card_w,card_l,card_h]);
}
if(part=="collector") collector();
if(part=="transition") translate([0,-collector_l,0]) transition();
if(part=="outlet") translate([0,-collector_l-transition_l,0]) outlet();
if(part=="assembly") {
    color([0.8,0.8,0.82]) collector();
    color([0.85,0.6,0.25]) transition();
    color([0.6,0.6,0.65]) outlet();
    if(show_cards) %reference_cards();
}

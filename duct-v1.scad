// MAX 1100 + Fantech FG 12XL EC #49905, revision 1, millimetres.
// NOT FIT-CHECKED. Card-end seals, cable glands and supports require measurements.
// Air travels along +Y; motherboard is horizontal in XY.
part = "assembly"; // assembly, duct, collector, transition, outlet, stand
show_cards = true;
wall = 3;
mouth_w = 180;       // provisional clear collector width
mouth_h = 130;       // provisional clear collector height
collector_l = 120;   // bracket/cable service volume, verify with actual harness
transition_l = 550;
outlet_id = 299; // 305 mm nominal duct: 305 OD minus two 3 mm walls
outlet_l = 40;
axis_z = 220; // leaves 17 mm below 406 mm blower casing
spool_l = 305; // straight 12-inch sheet-metal inlet, design allowance
joint_gap = 10; // FC12 isolating clamp spans butt joint; verify actual clamp
fan_d = 406;
fan_body_l = 170;
fan_inlet_l = 38;
fan_exit_l = 25;
fan_l = fan_body_l+fan_inlet_l+fan_exit_l;
fan_y = collector_l+transition_l+outlet_l+spool_l+2*joint_gap;
exhaust_l = 150;
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
    translate([0,y,axis_z]) rotate([-90,0,0]) cylinder(d=d,h=l);
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
module tube(od,id,y,l) {
    difference() {
        axial_cylinder(od,y,l);
        axial_cylinder(id,y-0.1,l+0.2);
    }
}
module blower_reference() {
    // PURCHASED reference envelope, not a replica or a printable blower.
    // Orient physical airflow arrow away from cards. Spigot ODs nominal;
    // determine actual diameters and bracket hole pattern on received unit.
    color([0.58,0.62,0.66]) {
        tube(305,302,fan_y,fan_inlet_l);
        tube(fan_d,302,fan_y+fan_inlet_l,fan_body_l);
        tube(305,302,fan_y+fan_inlet_l+fan_body_l,fan_exit_l);
        translate([-47.5,fan_y+fan_inlet_l+15,axis_z+fan_d/2-1])
            cube([95,70,52]); // box depth 70 provisional; 95 x 51 sourced
    }
}
module clamp_reference(y) {
    // Generic isolation clamp envelope, FC12 exact size not asserted.
    color([0.18,0.20,0.22]) tube(319,305,y-25,60);
}
module stand() {
    // Independent steel support frame. Drill OEM bracket holes on receipt.
    // No load carried by GPUs, bridge, or duct joints.
    for(x=[-230,210]) translate([x,fan_y-40,-30]) cube([20,fan_l+80,20]);
    for(y=[fan_y-40,fan_y+fan_l+20])
        translate([-230,y,-30]) cube([460,20,20]);
    // Side rails to receive the OEM bracket; final bracket location adjustable.
    for(x=[-225,215]) {
        translate([x,fan_y+50,-10]) cube([10,100,150]);
        translate([x<0?-225:195,fan_y+50,130]) cube([30,100,10]);
    }
}
module duct() {collector(); transition(); outlet();}
if(part=="collector") collector();
if(part=="transition") translate([0,-collector_l,0]) transition();
if(part=="outlet") translate([0,-collector_l-transition_l,0]) outlet();
if(part=="duct") duct();
if(part=="stand") stand();
if(part=="assembly") {
    color([0.8,0.8,0.82]) collector();
    color([0.85,0.6,0.25]) transition();
    color([0.6,0.6,0.65]) outlet();
    color([0.7,0.75,0.79])
        tube(305,303,collector_l+transition_l+outlet_l+joint_gap,spool_l);
    clamp_reference(collector_l+transition_l+outlet_l);
    clamp_reference(fan_y-joint_gap);
    blower_reference();
    color([0.7,0.75,0.79]) tube(305,303,fan_y+fan_l+joint_gap,exhaust_l);
    clamp_reference(fan_y+fan_l);
    color([0.25,0.28,0.31]) stand();
    if(show_cards) %reference_cards();
}

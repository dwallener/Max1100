// MAX 1100 200 W/card + Fantech FG 8 EC #49901. Units mm.
// Requires enforced 200 W total board-power cap before every workload.
// NOT FIT-CHECKED. Card-end seals, cable glands and supports require measurements.
// Air travels along +Y; motherboard is horizontal in XY.
build_part = "assembly"; // see FABRICATION-200W.md
segment = 0;
exploded = false;
show_cards = true;
wall = 3;
mouth_w = 180;       // provisional clear collector width
mouth_h = 130;       // provisional clear collector height
collector_l = 120;   // bracket/cable service volume, verify with actual harness
transition_l = 300;
outlet_id = 197; // 203 mm nominal duct OD less two 3 mm walls
outlet_l = 40;
axis_z = 185; // leaves 16.5 mm below 337 mm blower casing
spool_l = 203; // one nominal diameter straight inlet; design allowance
joint_gap = 10; // FC8 isolating clamp spans butt joint; verify actual clamp
fan_d = 337;
fan_body_l = 152;
fan_inlet_l = 25;
fan_exit_l = 25;
fan_l = fan_body_l+fan_inlet_l+fan_exit_l;
fan_y = collector_l+transition_l+outlet_l+spool_l+2*joint_gap;
exhaust_l = 100;
flange = 14;
flange_t = 5;
bolt_d = 4.5;
card_w = 34.35;
card_gap = 3; // user-provided approximate gap between housings
card_pitch = card_w + card_gap; // concept spacing, not a motherboard slot specification
fit_clearance = 0.4; // each side, provisional rigid collar clearance
adapter_t = 8;
collar_l = 15;
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
        // Service hatch in roof, bracket/cable volume remains unobstructed.
        translate([-75,12,mouth_h-1]) cube([150,96,wall+2]);
    }
    rectangular_flange(0);
    rectangular_flange(collector_l-flange_t);
}
module adapter() {
    // Replaceable four-aperture plate, bolted to existing inlet flange.
    // Windows surround housing envelopes; they are not claimed fin profiles.
    difference() {
        union() {
            translate([-mouth_w/2-wall-flange,-adapter_t,-wall-flange])
                cube([mouth_w+2*(wall+flange),adapter_t,mouth_h+2*(wall+flange)]);
            // Short common sleeve; webs seal the three between-card bypass paths.
            translate([-3*card_pitch/2-card_w/2-wall,-adapter_t-collar_l,-wall])
                cube([3*card_pitch+card_w+2*wall,collar_l+1,card_h+2*wall]);
        }
        for(i=[0:3])
            translate([(i-1.5)*card_pitch-card_w/2-fit_clearance,
                       -adapter_t-collar_l-1,-fit_clearance])
                cube([card_w+2*fit_clearance,adapter_t+collar_l+2,card_h+2*fit_clearance]);
        bolt_pattern(-adapter_t-1,adapter_t+2);
    }
}
module lid(lift=0) {
    // Overlapping removable panel; gasket and attachment details deferred.
    difference() {
        translate([-81,6,mouth_h+wall+lift]) cube([162,108,3]);
        for(i=[0:3])
            translate([(i-1.5)*card_pitch,72,mouth_h+wall+lift-1])
                cylinder(d=18,h=5); // provisional split-grommet cable exits
    }
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
        tube(203,200,fan_y,fan_inlet_l);
        tube(fan_d,200,fan_y+fan_inlet_l,fan_body_l);
        tube(203,200,fan_y+fan_inlet_l+fan_body_l,fan_exit_l);
        translate([-47.5,fan_y+fan_inlet_l+15,axis_z+fan_d/2-1])
            cube([95,70,52]); // box depth 70 provisional; 95 x 51 sourced
    }
}
module clamp_reference(y) {
    // Generic isolation clamp envelope, FC8 exact size not asserted.
    color([0.18,0.20,0.22]) tube(217,203,y-25,60);
}
module stand() {
    // Independent steel support frame. Drill OEM bracket holes on receipt.
    // No load carried by GPUs, bridge, or duct joints.
    for(x=[-190,170]) translate([x,fan_y-40,-30]) cube([20,fan_l+80,20]);
    for(y=[fan_y-40,fan_y+fan_l+20])
        translate([-190,y,-30]) cube([380,20,20]);
    // Side rails to receive the OEM bracket; final bracket location adjustable.
    for(x=[-185,175]) {
        translate([x,fan_y+50,-10]) cube([10,100,120]);
        translate([x<0?-185:155,fan_y+50,100]) cube([30,100,10]);
    }
}

// Prototype detail layer. Earlier design files remain unmodified.
// Native part exports remain in assembly coordinates; orient in slicer.
module hole_z(x,y,z,d=4.5,h=20) {
 translate([x,y,z]) cylinder(d=d,h=h);
}
module lid_holes(z) {
 for(x=[-84,84]) for(y=[18,54,90,108]) hole_z(x,y,z);
}
module detailed_collector() {
 difference() {
  union() {
   collector();
   // Roof rails provide room for M4 through-bolts and accessible nuts.
   for(x=[-90,77]) translate([x,8,124]) cube([13,104,9]);
   // Flush pressure port, lateral boss clear of cable compartment.
   translate([90,95,60]) rotate([0,90,0]) cylinder(d=12,h=8);
  }
  lid_holes(120);
  translate([88,95,60]) rotate([0,90,0]) cylinder(d=3,h=12);
 }
}
module detailed_lid() {
 difference() {
  translate([-92,4,134]) cube([184,112,4]);
  lid_holes(130);
  for(i=[0:3]) hole_z((i-1.5)*card_pitch,72,130,18,12);
 }
}
module lid_half(back=false) {
 intersection() {
  detailed_lid();
  translate([-100,back?72:0,130]) cube([200,back?60:72,15]);
 }
}
module grommet(back=false) {
 // Split flexible insert: 18 mm neck, 24 mm retaining lips, 10 mm cable bore.
 // Adjust cable_bore to harness bundle. Not a certified strain relief.
 cable_bore=10;
 intersection() {
  difference() {
   union() {
    cylinder(d=17.6,h=4);
    translate([0,0,-1.5]) cylinder(d=24,h=1.5);
    translate([0,0,4]) cylinder(d=24,h=1.5);
   }
   translate([0,0,-2]) cylinder(d=cable_bore,h=9);
  }
  translate([-15,back?0:-15,-2]) cube([30,15,10]);
 }
}
module lid_gasket2d() {
 difference() {
  translate([-90,6]) square([180,108]);
  translate([-75,12]) square([150,96]);
  for(x=[-84,84]) for(y=[18,54,90,108]) translate([x,y]) circle(d=4.5);
 }
}
module face_gasket2d() {
 difference() {
  translate([-107,-17]) square([214,164]);
  translate([-90,0]) square([180,130]);
  for(x=[-100,100]) for(z=[7,65,123]) translate([x,z]) circle(d=4.5);
 }
}
module transition_void() {
 hull() {
  translate([-mouth_w/2,collector_l-1,0]) cube([mouth_w,2,mouth_h]);
  axial_cylinder(outlet_id,collector_l+transition_l-1,2);
 }
}
function jw(y)=186+(203-186)*(y-120)/300;
function jlo(y)=-3+(86.5)*(y-120)/300;
function jhi(y)=133+(153.5)*(y-120)/300;
module joint_bolts(y) {
 w=jw(y); lo=jlo(y); hi=jhi(y);
 for(x=[-w/2-7,w/2+7]) for(z=[lo-7,(lo+hi)/2,hi+7])
  translate([x,y-7,z]) rotate([-90,0,0]) cylinder(d=4.5,h=14);
}
module joint_flange(y) {
 difference() {
  translate([-jw(y)/2-14,y-5,jlo(y)-14])
   cube([jw(y)+28,10,jhi(y)-jlo(y)+28]);
  transition_void();
  joint_bolts(y);
 }
}
module segmented_transition(n=0) {
 // Two mating flanges, each 5 mm thick at y=220 and y=320.
 intersection() {
  union() {transition(); outlet(); joint_flange(220); joint_flange(320);}
  translate([-200,120+100*n,-60]) cube([400,n==2?140:100,460]);
 }
}
module transition_gasket2d(y=220) {
 // Section through mating flange, including flow aperture and bolt holes.
 projection(cut=true) rotate([90,0,0]) translate([0,-y,0]) joint_flange(y);
}
module adapter_gasket() {
 // 0.6 mm compliant sleeve liner compressed into 0.4 mm nominal clearance.
 for(i=[0:3]) translate([(i-1.5)*card_pitch,0,0])
 difference() {
  translate([-card_w/2-0.4,-21,-0.4]) cube([card_w+0.8,10,card_h+0.8]);
  translate([-card_w/2+0.2,-22,0.2]) cube([card_w-0.4,12,card_h-0.4]);
 }
}
module fit_coupon() {
 // Two short windows, with the same rigid clearance and divider as adapter.
 intersection() {
  adapter();
  translate([-card_pitch/2-card_w/2-wall,-23,-3]) cube([card_pitch+card_w+2*wall,6,card_h+6]);
 }
}
module detailed_assembly() {
 color([0.2,0.65,0.65]) adapter();
 color([0.15,0.15,0.15]) adapter_gasket();
 color([0.8,0.8,0.82]) detailed_collector();
 for(back=[false,true]) color([0.8,0.8,0.82])
  translate([0,back&&exploded?25:0,exploded?70:0]) lid_half(back);
 for(i=[0:3]) for(back=[false,true]) color([0.16,0.16,0.18])
  translate([(i-1.5)*card_pitch,72+(back&&exploded?25:0),134+(exploded?70:0)]) grommet(back);
 for(n=[0:2]) color([0.85,0.6+n*0.06,0.25])
  translate([0,exploded?n*20:0,0]) segmented_transition(n);
 if(show_cards) %reference_cards();
}
if(build_part=="assembly") detailed_assembly();
if(build_part=="collector") detailed_collector();
if(build_part=="adapter") adapter();
if(build_part=="fit-coupon") fit_coupon();
if(build_part=="lid-front") lid_half(false);
if(build_part=="lid-back") lid_half(true);
if(build_part=="grommet-front") grommet(false);
if(build_part=="grommet-back") grommet(true);
if(build_part=="transition") segmented_transition(segment);
if(build_part=="lid-gasket") lid_gasket2d();
if(build_part=="face-gasket") face_gasket2d();
if(build_part=="joint-gasket") transition_gasket2d(segment==0?220:320);

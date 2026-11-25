// COMMERCIAL AIRCRAFT NOSE LANDING GEAR - CONCEPTUAL MINI PROJECT
// Units: mm. Simplified non-certified portfolio model.
// Change parameters below to explore proportions.
$fn = 64;
overall_height = 2450;
upper_strut_od = 220;
lower_piston_od = 145;
wheel_d = 700;
wheel_w = 180;
wheel_track = 520;
axle_d = 90;
fork_t = 35;
oleo_stroke = 300;

// Coordinate convention: Z vertical, X wheel axle, Y fore/aft.
// Main strut
module cyl_z(d,h,z0=0) { translate([0,0,z0]) cylinder(d=d,h=h); }
module wheel(x) {
    // tire + simplified hub, wheel axis along X
    translate([x,0,365]) rotate([0,90,0]) {
        color([0.10,0.10,0.12]) cylinder(d=wheel_d,h=wheel_w,center=true);
        color([0.65,0.68,0.72]) cylinder(d=420,h=wheel_w+8,center=true);
        color([0.78,0.80,0.83]) cylinder(d=230,h=wheel_w+14,center=true);
    }
}
module link(p1,p2,d=38) {
    // link between two points using hull of spheres
    hull() {
        translate(p1) sphere(d=d);
        translate(p2) sphere(d=d);
    }
}
module nose_gear() {
    // upper cylinder and mounting head
    color([0.72,0.75,0.78]) {
        translate([0,0,1050]) cylinder(d=upper_strut_od,h=1050);
        translate([0,0,2030]) cylinder(d=330,h=120);
        translate([0,0,2150]) cylinder(d=270,h=90);
        // steering collar
        translate([0,0,1900]) cylinder(d=280,h=90);
    }
    // exposed lower sliding piston
    color([0.82,0.84,0.86]) {
        translate([0,0,365]) cylinder(d=lower_piston_od,h=700);
        translate([0,0,1000]) cylinder(d=190,h=100);
    }
    // axle and twin wheels
    color([0.58,0.60,0.63]) translate([0,0,365]) rotate([0,90,0])
        cylinder(d=axle_d,h=wheel_track+2*wheel_w,center=true);
    wheel(-wheel_track/2-wheel_w/2);
    wheel(wheel_track/2+wheel_w/2);
    // fork: two side arms down to axle, connected at crown
    color([0.72,0.75,0.78]) {
        translate([-wheel_track/2-20,-35,365]) cube([fork_t,70,340]);
        translate([wheel_track/2-15,-35,365]) cube([fork_t,70,340]);
        translate([-wheel_track/2-20,-35,680]) cube([wheel_track+40,70,55]);
    }
    // torque links (scissor links) on aft side
    color([0.80,0.62,0.20]) {
        link([-75,105,1100],[75,105,830],42);
        link([75,105,1100],[-75,105,830],42);
        for (x=[-75,75]) translate([x,105,965]) rotate([90,0,0]) cylinder(d=70,h=40,center=true);
    }
    // drag brace, forward side, simplified twin members
    color([0.30,0.42,0.58]) {
        link([-90,-170,1950],[-240,-720,1180],55);
        link([90,-170,1950],[240,-720,1180],55);
        translate([-255,-740,1160]) cube([510,70,70]);
    }
    // steering actuator housings
    color([0.35,0.48,0.58]) {
        link([-135,0,1870],[-340,0,1760],45);
        link([135,0,1870],[340,0,1760],45);
    }
}
nose_gear();

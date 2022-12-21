include <BOSL/constants.scad>
use <BOSL/involute_gears.scad>
use <BOSL/masks.scad>
include <parameters.scad>
use <utils.scad>

module shower_support(
    width,
    height,
    depth,
    thickness,
    rounding_radius
) {
    color("pink")
    difference() {
        union() {
            fillet(fillet=rounding_radius, size=[width, depth, height], edges=EDGES_ALL-EDGES_LEFT)
                cube([width,depth,height], center=true);

            translate([-width/2, 0, 0])
            copy_mirror([0, 0, 1])
            translate([0, 0, height/2 - SHOWER_SUPPORT_ATTACHING_DISTANCE_TO_EDGES])
            rotate([90,0,-90])                          
                cylinder(h=SHOWER_SUPPORT_ATTACHING_HOLE_DEPTH - SHOWER_SUPPORT_ATTACHING_HOLE_DEPTH_CLEARANCE, d=SHOWER_SUPPORT_ATTACHING_HOLE_DIAMETER - SHOWER_SUPPORT_ATTACHING_HOLE_DIAMETER_CLEARANCE, $fn = 6);
        }

        inner_cube_size = [width-thickness*2,depth,height-thickness*2];
        inner_rounding_radius = rounding_radius-thickness/2;
        translate([0,thickness/2, 0])
            fillet(fillet=inner_rounding_radius, size=inner_cube_size, edges=EDGES_ALL)
                cube(inner_cube_size, center=true);

        translate([-width/2, 0, 0])
        copy_mirror([0, 0, 1])
        translate([0, 0, height/2 - SHOWER_SUPPORT_ATTACHING_DISTANCE_TO_EDGES])
        rotate([90,0,-90]) {
            translate([0, 0, -thickness-NOTHING])
                cylinder(h=M4_HEAD_HEIGHT+SHOWER_SUPPORT_ATTACHING_HOLE_NUT_HOLE_DEPTH_CLEARANCE, d=M4_HEAD_DIAMETER, $fn = 6);

                cylinder(h=thickness + SHOWER_SUPPORT_ATTACHING_HOLE_DEPTH + NOTHING, d=M4_BODY_DIAMETER);
        }
        
        translate([0,0.01,0])
        rotate([90,0,0])
        translate([0,0,(depth-thickness)/2])
        translate([-50, -50, 0])
            linear_extrude(height=thickness+2, center = true, convexity = 10)
                import("./assets/leaf-inverted.svg");

        
        copy_mirror([1, 0, 0])
        copy_mirror([0, 0, 1])
        translate([width/2-10, -(depth-thickness)/2, height/2-10])
        rotate([90,0,0])
        cylinder(h=thickness + NOTHING + NOTHING, d=6, center=true);
    }
    
    color("green")
    translate([0,0.0,0])
    rotate([90,0,0])
    translate([0,0,(depth-thickness)/2])
    translate([-50, -50, -2.001])
        linear_extrude(height=2, convexity = 10)
            import("./assets/leaf.svg");

}

module SHOWER_SUPPORT() {
    shower_support(
        width=SHOWER_SUPPORT_WIDHT,
        height=SHOWER_SUPPORT_HEIGHT,
        depth=SHOWER_SUPPORT_DEPTH,
        thickness=SHOWER_SUPPORT_THICKNESS,
        rounding_radius=ROUNDING_RADIUS
    );
}


SHOWER_SUPPORT();

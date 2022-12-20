include <NopSCADlib/lib.scad>
include <BOSL/constants.scad>
use <BOSL/involute_gears.scad>
use <BOSL/masks.scad>
include <parameters.scad>
use <utils.scad>


module shower_handle_screw(
    width,
    screw_lenght,
    screw_pitch,
    hole_distance,
    rounding_radius,
    bar_diameter,
    height,
    depth,
    screw_diameter_buffer
) {
    screw_diameter = sqrt((bar_diameter) ^ 2 + (depth) ^ 2) + screw_diameter_buffer;
    assert(hole_distance > 0);
    assert(bar_diameter + hole_distance > width, "hole_distance is too short");

    difference(){
        union(){
            cube_size = [ width, depth, height ];

            color("blue")
            fillet(fillet=rounding_radius, size=cube_size,edges=EDGES_ALL - EDGES_RIGHT) {
                cube(cube_size, center=true);
            }

            color("yellow") rotate([ 90, 0, -90 ]) {
                buffer = 0.25 + screw_diameter_buffer;
                translate([ 0, 0, width / 2 + screw_lenght / 2 - buffer / 2 ])
                    male_metric_thread(d=screw_diameter, pitch=screw_pitch, length=screw_lenght + buffer);
            }
        }

        color("blue")
        union() {
            translate([ -bar_diameter / 2 + width / 2 - hole_distance, 0, 0 ]) {
                rotate([ 90, 0, 0 ])
                    cylinder(h = depth + 1, d = bar_diameter, center = true);

                translate([ -(width + screw_lenght + 1) / 2, 0, 0 ])
                    cube([ width + screw_lenght + 1, screw_diameter + 1, bar_diameter ],
                        center = true);
            }

            translate([ 0, depth, 0 ])
                cube([ (width + screw_lenght) * 2, depth, height ], center = true);

            translate([ 0, -depth, 0 ])
                cube([ (width + screw_lenght) * 2, depth, height ], center = true);
        }

        union() {
            copy_mirror([ 0, 0, 1 ])
            translate([ 0, 0, height / 2 - SHOWER_SUPPORT_ATTACHING_DISTANCE_TO_EDGES ])
            rotate([ 90, 0, -90 ])
            union() {
                translate([ 0, 0, width / 2 ])
                translate([ 0, 0, -M4_HEAD_HEIGHT ])
                    cylinder(h = M4_HEAD_HEIGHT + NOTHING, d = M4_HEAD_DIAMETER);

                color("purple")
                translate([ 0, 0, -width / 2 - NOTHING ])
                    cylinder(h = width, d = M4_BODY_DIAMETER);

                translate([ 0, 0, -width / 2 ])
                translate([ 0, 0, -NOTHING ])
                    cylinder(h = SHOWER_SUPPORT_ATTACHING_HOLE_DEPTH, d = SHOWER_SUPPORT_ATTACHING_HOLE_DIAMETER, $fn = 6);
            }
        }
    }
}

module SHOWER_HANDLE_SCREW() {
    shower_handle_screw(
        width=SHOWER_HANDLE_SCREW_WIDHT,
        screw_lenght=SHOWER_HANDLE_SCREW_LENGHT,
        screw_pitch=SHOWER_HANDLE_SCREW_PITCH,
        hole_distance=SHOWER_HANDLE_SCREW_HOLE_DISTANCE,
        rounding_radius=ROUNDING_RADIUS,
        bar_diameter=SHOWER_BAR_DIAMETER,
        height=SHOWER_HANDLE_HEIGHT,
        depth=SHOWER_HANDLE_DEPTH,
        screw_diameter_buffer=SHOWER_HANDLE_SCREW_DIAMETER_BUFFER
    );
}

SHOWER_HANDLE_SCREW();
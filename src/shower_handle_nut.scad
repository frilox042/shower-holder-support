include <BOSL/constants.scad>
use <BOSL/involute_gears.scad>
use <BOSL/masks.scad>
use <BOSL/threading.scad>
include <NopSCADlib/lib.scad>
include <parameters.scad>

module shower_handle_nut(
    nut_lenght,
    screw_pitch,
    thickness,
    bar_diameter,
    depth,
    buffer = 2,
    screw_diameter_buffer
) {
    screw_diameter = sqrt((bar_diameter) ^ 2 + (depth) ^ 2) + screw_diameter_buffer + buffer;
    
    rotate([0,90,0]) {
        union() {
            color("green")
            female_metric_thread(d=screw_diameter, pitch=screw_pitch, length=nut_lenght);

            color("blue")
            difference() {
                cylinder(h=nut_lenght, d=screw_diameter + thickness + buffer, center=true);
                cylinder(h=nut_lenght + buffer, d=screw_diameter, center=true);
            }
        }

        r = (screw_diameter + thickness + buffer) / 2;
        for (i = [0:8:359]) {
            translate([ r * cos(i), r * sin(i), 0 ]) rotate([ 0, 0, i ])
                cube([ 2, 2, nut_lenght ], center = true);
        }
    }
}

module SHOWER_HANDLE_NUT() {

    shower_handle_nut(
        nut_lenght=SHOWER_HANDLE_NUT_LENGHT,
        screw_pitch=SHOWER_HANDLE_SCREW_PITCH,
        thickness=SHOWER_HANDLE_NUT_THICKNESS,
        bar_diameter=SHOWER_BAR_DIAMETER,
        depth=SHOWER_HANDLE_DEPTH,
        screw_diameter_buffer=SHOWER_HANDLE_SCREW_DIAMETER_BUFFER
    );
}

SHOWER_HANDLE_NUT();

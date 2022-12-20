include <parameters.scad>

module shower_handle_washer(
    margin_depth,
    margin_width,
    thickness,
    bar_diameter,
    depth,
) {
    color("red")
    difference() {
        cube([ thickness, depth + margin_depth, bar_diameter + margin_width ], center=true);

        translate([ 0, 0, bar_diameter ])
            cube([ thickness + depth, depth + SHOWER_HANDLE_WASHER_CLEARANCE, bar_diameter + SHOWER_HANDLE_WASHER_CLEARANCE ], center=true);

        translate([ 0, 0, -bar_diameter ])
            cube([ thickness + depth, depth + SHOWER_HANDLE_WASHER_CLEARANCE, bar_diameter + SHOWER_HANDLE_WASHER_CLEARANCE ], center=true);

        translate([ (thickness) / 2, 0, 0 ])
        rotate([ 90, 0, 0 ])
            cylinder(h=depth + margin_depth + SHOWER_HANDLE_WASHER_CLEARANCE, d=bar_diameter, center=true);
    }
}

module SHOWER_HANDLE_WASHER() {
    shower_handle_washer(
        thickness=SHOWER_BAR_DIAMETER/2+SHOWER_HANDLE_WASHER_THICKNESS,
        margin_depth=SHOWER_HANDLE_WASHER_MARGIN,
        margin_width=SHOWER_HANDLE_WASHER_MARGIN,
        bar_diameter=SHOWER_BAR_DIAMETER,
        depth=SHOWER_HANDLE_DEPTH
    );
}

SHOWER_HANDLE_WASHER();

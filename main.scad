use <src/shower_handle_screw.scad>;
use <src/shower_handle_washer.scad>;
use <src/shower_handle_nut.scad>;
use <src/shower_support.scad>;
use <src/utils.scad>;

$fs = 0.01;
$fn = 36;

arrange(spacing=100) {
    color("green")
        SHOWER_HANDLE_NUT();
    SHOWER_HANDLE_WASHER();
    SHOWER_HANDLE_SCREW();
    SHOWER_SUPPORT();
}
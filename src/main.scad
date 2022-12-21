use <shower_handle_screw.scad>;
use <shower_handle_washer.scad>;
use <shower_handle_nut.scad>;
use <shower_support.scad>;
use <utils.scad>;

$fs = 0.01;
$fn = 36;

arrange(spacing=100) {
    color("green")
        SHOWER_HANDLE_NUT();
    SHOWER_HANDLE_WASHER();
    SHOWER_HANDLE_SCREW();
    SHOWER_SUPPORT();
}
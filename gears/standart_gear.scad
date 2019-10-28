include <lib/gears.scad>
include <shaft.scad>

module gear(teeths=20) {
    //spur_gear(modul, tooth_number, width, bore, pressure_angle=20, helix_angle=0, optimized=true)
    spur_gear(5, teeths, 10, shaft_d);
}
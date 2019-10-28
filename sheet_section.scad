include <pin.scad>

// programming sheet constants
sheet_diameter = 600;
sheet_width = 435;
sheet_thickness = 30;
pins_in_column = 256;
pins_in_row = 18;
sections = 8;

pins_in_section = pins_in_column/sections;
pins_v_spacing = ((sheet_diameter*PI)/sections)/pins_in_section - pin_diameter;
pins_h_spacing = (sheet_width-pins_in_row*pin_diameter)/(pins_in_row+1);
pin_shift = (PI*(sheet_diameter/2))/(180*pin_diameter);

module arc(height, depth, radius, degrees) {
    // This dies a horible death if it's not rendered here 
    // -- sucks up all memory and spins out of control 
    render() {
        difference() {
            // Outer ring
            rotate_extrude($fn = 100)
                translate([radius - height, 0, 0])
                    square([height,depth]);
         
            // Cut half off
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
            // Cover the other half as necessary
            rotate([0,0,180-degrees])
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
        }
    }
}

module section_plate(n=1) {
    rotate([0, (360/sections)*(n-1), 0]) {
        rotate([0, -90, 90]) translate([0, 0, -sheet_width/2])
        arc(sheet_thickness, sheet_width, sheet_diameter/2, 360/sections);
    }
}

module pin_column(n=1) {
    for(i = [0:(360/sections/pins_in_section):360/sections]) {
        rotate([0, i+(360/sections)*(n-1), 0]) {
            translate([sheet_diameter/2, 0, 0])
                rotate([0, 90, 0]) pin();
        }
    }
}

module section(n=1) {
    difference() {
        section_plate(n);
        for(i = [0:pins_in_row-1])
        translate([0, pin_diameter/2-sheet_width/2 + pins_h_spacing + i*(pin_diameter+pins_h_spacing), 0]) pin_column(n);
    }
}

section(1);

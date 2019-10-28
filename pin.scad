// programming pin
// pin diameter = real pin diameter (4mm) + clearance (1mm)
pin_diameter = 5;
pin_length = 30;

module pin(diameter=pin_diameter, length=pin_length) {
    cylinder(length, d=diameter, center=true, $fn=100);
}
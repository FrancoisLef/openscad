include <BOSL/constants.scad>
use <BOSL/shapes.scad>

// Print settings
print_thickness = 2;
screw_diameter = 6;
screw_head = 5;
screwdriver_diameter = screw_diameter * 3;

// Relay dimensions
relay_size = 85;
relay_thickness = 25 + screw_head;

difference() {
  support();
  netatmo();
}

module support() {
  support_height = (relay_size / 2) + print_thickness;

  difference() {
    // Base
    translate([
      0,
      relay_size / 2,
      0,
    ]) {
      cube([
        // Left wall + relay + right wall
        print_thickness + relay_size + print_thickness,
        // Half of relay + bottom wall
        print_thickness + relay_size / 2,
        // Back wall + relay + front wall
        print_thickness + relay_thickness + print_thickness,
      ]);
    }

    // Screw hole
    translate([
      // Left wall + half of relay - half of hole diameter
      print_thickness + (relay_size / 2) - (screw_diameter / 2),
      // Half of relay + print thickness
      relay_size / 2 + print_thickness,
      -0.01,
    ]) {
      cyl(
        l=print_thickness + 0.1,
        d=screw_diameter,
        orient=ORIENT_ZNEG,
        align=V_ALLPOS
      );
    }

    // Screwdriver hole
    translate([
      // Left wall + half of relay - half of hole diameter
      print_thickness + (relay_size / 2) - (screwdriver_diameter / 2),
      // Half of relay + print thickness
      relay_size / 2 - print_thickness,
      // Back wall + relay
      print_thickness + relay_thickness - 0.01,
    ]) {
      cyl(
        l=print_thickness + 0.1,
        d=screwdriver_diameter,
        orient=ORIENT_ZNEG,
        align=V_ALLPOS
      );
    }
  }

}

module netatmo() {
  // Relay connector dimensions
  connector_width = 35;
  connector_height = 25;
  connector_depth = 10;

  color("white")
    translate([
      print_thickness,
      0,
      print_thickness,
    ]) {
      difference() {
        // Base
        cube([
          relay_size,
          relay_size,
          relay_thickness,
        ]);

        // Connector
        translate([
          (relay_size - connector_width) / 2, // Centered
          2, // Distance from top
          relay_thickness - connector_depth + 0.01 // 0.01mm overlap
        ])
          cube([
            connector_width,
            connector_height,
            connector_depth
          ]);
      }
    }
}

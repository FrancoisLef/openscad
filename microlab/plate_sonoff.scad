include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

include <rack.scad>

sonoff_width = 26;
sonoff_length = 52;
sonoff_height = 14;

antenna_size = 7;

module sonoff() {
  // Sonoff body
  cuboid(
    [
      sonoff_width,
      sonoff_length,
      sonoff_height
    ],
    align=V_ALLPOS
  );

  // Antenna connector
  up(1) forward(50) right((sonoff_width / 2) - (antenna_size / 2)) {
    cuboid(
      [
        antenna_size,
        100,
        antenna_size
      ],
      align=V_ALLPOS
    );
  }
}

rack_unit() {
  difference() {
    rack_panel();
    up(rack_unit_height + tolerance) right(rack_support_width) back(rack_panel_thickness + tolerance) sonoff();
  }
}


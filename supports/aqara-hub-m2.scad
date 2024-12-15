include <BOSL/constants.scad>
use <BOSL/shapes.scad>

thickness = 6;

translate([
  thickness,
  thickness,
  thickness
]) {
  // aqara_hub();
}

wall_mount(
  thickness = thickness
);

module wall_mount(
  color = "red",
  height = 40,
  diameter = 110,
  thickness = 4,
) {
  difference() {
    // Base
    color(color)
      cyl(
        l=height, // height
        d=diameter, // diameter
        fillet2=10,
        orient=ORIENT_ZNEG,
        align=V_ALLPOS
      );

    // Base hole
    color(color)
      translate([
        thickness / 2,
        thickness / 2,
        thickness / 2,
      ])
        cyl(
          l=height, // height
          d=diameter - thickness, // diameter
          fillet2=10,
          orient=ORIENT_ZNEG,
          align=V_ALLPOS
        );

    // Cut out
    color(color)
      translate([
        -80,
        0,
        thickness * 2,
      ])
        cuboid(
          120,
          p1=[10,0,0]
        );

    // Screw hole
    color(color)
      translate([
        diameter / 2 - 4,
        diameter / 2 - 4,
      ])
        cyl(
          l=50, // height
          d=8, // diameter
          orient=ORIENT_ZNEG,
          align=V_ALLPOS
        );

    color(color)
      translate([
        diameter / 2 - 6,
        diameter / 2 - 6,
        2
      ])
        cyl(
          l=2, // height
          d=12, // diameter
          orient=ORIENT_ZNEG,
          align=V_ALLPOS
        );
  }

  difference() {
    color(color)
      translate([
        diameter,
        0,
        height
      ])
        rotate(a=90, v=[0,0,1])
          teardrop(
            d=diameter,
            h=thickness / 2,
            ang=90,
            cap_h=-thickness,
            orient=ORIENT_ZNEG,
            align=V_ALLPOS
          );
    // Screw hole
    color(color)
      translate([
        diameter / 2 - 10,
        diameter / 2 - 10,
      ])
        cyl(
          l=50, // height
          d=20, // diameter
          orient=ORIENT_ZNEG,
          align=V_ALLPOS
        );
  }
}

// Aqara Hub
module aqara_hub(
  color = "black",
  height = 31,
  diameter = 101,
  btn_diameter = 8,
  btn_height = 5,
  ports_height = 20,
) {
  difference() {
    // Base
    color(color)
      cyl(
        l=height, // height
        d=diameter, // diameter
        fillet2=10,
        orient=ORIENT_ZNEG,
        align=V_ALLPOS
      );
    // Button
    color("grey")
      translate([
        diameter - btn_height,
        (diameter / 2) - (btn_diameter / 2), // center of hub - center of button
        height - (10 + btn_diameter / 2)
      ])
        tube(
          h=btn_height, // button height
          od=btn_diameter, // outer diameter
          id=btn_diameter - 1, // inner diameter
          orient=ORIENT_X,
          align=V_ALLPOS
        );
    // Ports
    color("grey")
      translate([
        diameter / 2 - 1,
        diameter / 2,
        ports_height
      ])
        rotate(a=35, v=[0,0,1])
          pie_slice(
            ang=70,
            h=ports_height,
            d=diameter,
            orient=ORIENT_ZNEG,
            center=true
          );
  }
}

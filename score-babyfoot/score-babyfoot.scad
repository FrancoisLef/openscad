include <BOSL/constants.scad>
use <BOSL/shapes.scad>

support_base_diameter = 25;
support_top_diameter = 23;
support_height = 33;

screwdriver_hole_diameter = 8.5;
screw_hole_diameter = 4;

score_bar_diameter = 6.6;
score_bar_length = 20;

difference() {
  support_score_babyfoot();
  score_bar();
}


module score_bar() {
  translate([score_bar_length / 2 + 7, 0, score_bar_diameter / 2 + 20])
    color("orange")
      cyl(
        l=score_bar_length,
        d=score_bar_diameter,
        orient=ORIENT_X
      );
}

module support_score_babyfoot() {
  difference() {
    color("red")
      cyl(
        l=support_height,
        d1=support_base_diameter,
        d2=support_top_diameter,
        chamfer2=1,
        align=V_UP
      );

    translate([0, 0, 1.5])
      color("yellow")
        cyl(
          l=support_height + 1,
          d=screwdriver_hole_diameter,
          align=V_UP
        );

    translate([0, 0, -1])
      color("green")
        cyl(
          l=support_height + 1,
          d=screw_hole_diameter,
          align=V_UP
        );
  }
}

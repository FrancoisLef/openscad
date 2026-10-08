include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

external_diameter = 24;
external_diameter2 = 40;
external_height = 100;

internal_diameter = 8;
internal_height = 45;

tolerance = .1;

difference() {
  poignee_table_basse();
  internal_hole();
}

module poignee_table_basse() {
  color("orange")
    cyl(
      d1=external_diameter,
      d2=external_diameter2,
      l=external_height,
      fillet1=4,
      fillet2=16,
      align=ALIGN_POS
    );
}

module internal_hole() {
  color("red")
    down(tolerance) cyl(
      d=internal_diameter + tolerance,
      l=internal_height + tolerance,
      align=ALIGN_POS
    );
}

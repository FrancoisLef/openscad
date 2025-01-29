include <BOSL/constants.scad>
use <BOSL/shapes.scad>

external_diameter = 17;
internal_diameter = 8;
height = 9;
diff_tolerance = .1;

difference() {
  roulement_table_basse();
  internal_hole();
}

module roulement_table_basse() {
  color("orange")
    cyl(
      d=external_diameter,
      l=height,
      fillet=1
    );
}

module internal_hole() {
  color("red")
    cyl(
      d=internal_diameter,
      l=height + diff_tolerance
    );
}

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

use <power_supply.scad>;

thickness = 10;

//----------------------------------------
// Case sub-modules
//----------------------------------------
module case_bottom () {
  color("red") cuboid([ 250, 250, thickness ], align = V_ALLPOS);
}

//----------------------------------------
// Case assembly
//----------------------------------------
module case () {
  case_bottom();
}

case();
up(thickness) power_supply();

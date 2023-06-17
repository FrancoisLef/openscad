include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

//----------------------------------------
// Screen sub-modules
//----------------------------------------
module screen_case () {
  color("silver") cuboid([ 235, 143, 5 ], align = V_ALLPOS);
}

module screen_panel () {
  color("black") cuboid([ 226, 128, 5 ], align = V_ALLPOS);
}

module screen_power () {
  color("black") cuboid([ 10, 5, 3 ], align = V_ALLPOS);
}

module screen_connector () {
  color("orange") cuboid([ 40, 70, 1 ], align = V_ALLPOS);
}

//----------------------------------------
// Screen assembly
//----------------------------------------
module screen () {
  interf = 0.1;

  screen_case();
  up(interf) right(5) back(8) screen_panel();
  up(interf) left(interf) back(110) screen_power();
  up(3.5) right(97) back(143) screen_connector();
}

screen();

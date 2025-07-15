include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>
include <rpi5.scad>

__WALL = 2;
__FEET_HEIGHT = 5;

module rpi5_case() {
  __WIDTH = 60;
  __HEIGHT = 70;
  __LENGTH = 95;

  diff("pi") {
    //----------------
    // External case
    //----------------
    fwd(__WALL) down(__WALL) left(__WALL) rect_tube(
            isize=[__HEIGHT, __LENGTH],
            wall=__WALL,
            rounding=__WALL,
            irounding=0,
            h=__WIDTH,
            orient=LEFT,
            anchor=LEFT + TOP + FRONT
          );

    //----------------
    // Raspberry Pi feets
    //----------------
    back(__RPI_LENGTH - __RPI_HOLE_SPACE_FROM_EDGE)
      cuboid([__RPI_WIDTH, __RPI_HOLE_DIAMETER * 2, __FEET_HEIGHT], rounding=1, edges=TOP, anchor=BOTTOM + LEFT);
    back(__RPI_LENGTH - __RPI_HOLE_SPACE_FROM_EDGE - __RPI_HOLE_Y_SPACING)
      cuboid([__RPI_WIDTH, __RPI_HOLE_DIAMETER * 2, __FEET_HEIGHT], rounding=1, edges=TOP, anchor=BOTTOM + LEFT);

    //----------------
    // EnoCean antenna
    //----------------

    //----------------
    // Raspberry Pi 5
    //----------------
    tag("pi") up(__FEET_HEIGHT) rpi5(extrude=10, anchor=LEFT + BOTTOM + FRONT);
  }
}

rpi5_case();

include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <BOSL2/screws.scad>
include <constants.scad>
include <rpi5.scad>

// Internal dimensions of the case
WIDTH = 60;
HEIGHT = 70;
LENGTH = 95;

// Misc.
WALL = 2;
FEET = 5;

module rpi5_case() {

  diff("holes") {
    //----------------
    // Case
    //----------------
    left(WALL) fwd(WALL) down(WALL) rect_tube(
            isize=[HEIGHT, LENGTH],
            wall=WALL,
            rounding=5,
            irounding=0,
            h=WIDTH,
            orient=LEFT,
            anchor=LEFT + TOP + FRONT
          );

    //----------------
    // Raspberry Pi feets
    //----------------
    back(__RPI_LENGTH - __RPI_HOLE_SPACE_FROM_EDGE)
      cuboid([__RPI_WIDTH, __RPI_HOLE_DIAMETER * 2, FEET], rounding=1, edges=TOP, anchor=BOTTOM + LEFT);
    back(__RPI_LENGTH - __RPI_HOLE_SPACE_FROM_EDGE - __RPI_HOLE_Y_SPACING)
      cuboid([__RPI_WIDTH, __RPI_HOLE_DIAMETER * 2, FEET], rounding=1, edges=TOP, anchor=BOTTOM + LEFT);

    //----------------
    // Side mounting points
    //----------------

    //----------------
    // External antenna connector
    //----------------
    tag("holes") right(WIDTH / 2 - WALL) up(HEIGHT / 2 + WALL) teardrop(d=6.5, h=10, cap_h=3);

    //----------------
    // Raspberry Pi 5
    //----------------
    tag("holes") up(FEET) rpi5(extrude=10, margin=0.5, anchor=LEFT + BOTTOM + FRONT) {
          screw_hole("M3x1", length=__RPI_HEIGHT + FEET, head="socket", anchor=BOTTOM, orient=DOWN);
        }
  }
}

rpi5_case();

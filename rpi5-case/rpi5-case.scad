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
FEET = 8;
SPACER = 6; // Spacer between the Raspberry Pi and the case
ROUNDING = 5;

module rpi5_case() {

  diff("holes") {
    //----------------
    // Case
    //----------------
    left(WALL) fwd(WALL) down(WALL) rect_tube(
            isize=[HEIGHT, LENGTH],
            wall=WALL,
            rounding=ROUNDING,
            irounding=0,
            h=WIDTH,
            orient=LEFT,
            anchor=TOP + LEFT + FRONT
          );

    //----------------
    // Raspberry Pi feets
    //----------------
    left(WALL) union() {
        // Back feet
        back(__RPI_LENGTH - __RPI_HOLE_SPACE_FROM_EDGE)
          cuboid([WIDTH, __RPI_HOLE_DIAMETER * 2, FEET], rounding=1, edges=TOP, anchor=BOTTOM + LEFT);
        // Front feet
        back(__RPI_LENGTH - __RPI_HOLE_SPACE_FROM_EDGE - __RPI_HOLE_Y_SPACING)
          cuboid([WIDTH, __RPI_HOLE_DIAMETER * 2, FEET], rounding=1, edges=TOP, anchor=BOTTOM + LEFT);
      }

    //----------------
    // Side mounting points
    //----------------
    left(WALL) union() {
        // Bottom front side
        union() {
          cuboid([WIDTH, FEET, FEET], rounding=ROUNDING, edges=TOP + BACK, anchor=BOTTOM + LEFT + FRONT);
          tag("holes") back(WALL) up(WALL) left(get_slop()) xcyl(length=WIDTH + get_slop() * 2, d=3, anchor=BOTTOM + FRONT + LEFT);
        }

        // Bottom back side
        back(LENGTH) union() {
            cuboid([WIDTH, FEET, FEET], rounding=ROUNDING, edges=TOP + FRONT, anchor=BOTTOM + LEFT + BACK);
            tag("holes") fwd(WALL) up(WALL) left(get_slop()) xcyl(length=WIDTH + get_slop() * 2, d=3, anchor=BOTTOM + BACK + LEFT);
          }

        // Top front side
        up(HEIGHT) union() {
            cuboid([WIDTH, FEET, FEET], rounding=ROUNDING, edges=BOTTOM + BACK, anchor=TOP + LEFT + FRONT);
            tag("holes") back(WALL) down(WALL) left(get_slop()) xcyl(length=WIDTH + get_slop() * 2, d=3, anchor=TOP + FRONT + LEFT);
          }

        // Top back side
        up(HEIGHT) back(LENGTH) union() {
              cuboid([WIDTH, FEET, FEET], rounding=ROUNDING, edges=BOTTOM + FRONT, anchor=TOP + LEFT + BACK);
              tag("holes") fwd(WALL) down(WALL) left(get_slop()) xcyl(length=WIDTH + get_slop() * 2, d=3, anchor=TOP + BACK + LEFT);
            }
      }

    //----------------
    // Ventilation holes
    //----------------
    tag("holes") right((WIDTH / 2) - WALL) union() {
          HOLE_DIAMETER = 4;

          // Top holes
          up(HEIGHT - get_slop()) back(LENGTH / 2) grid_copies(
                size=[WIDTH - FEET - WALL * 2, LENGTH - FEET * 2 - WALL * 2],
                spacing=[HOLE_DIAMETER, HOLE_DIAMETER],
                stagger=true
              ) cylinder(d=HOLE_DIAMETER, h=WALL + get_slop() * 2);

          // Back holes
          up(HEIGHT / 2) back(LENGTH + WALL - 1) grid_copies(
                size=[WIDTH - FEET - WALL * 2, HEIGHT - FEET * 2 - WALL * 2],
                spacing=[HOLE_DIAMETER, HOLE_DIAMETER],
                stagger=true,
                axes="xz"
              ) ycyl(d=HOLE_DIAMETER, h=WALL + get_slop() * 2);

          // Bottom holes
          down(WALL + get_slop()) back(LENGTH / 2 + FEET / 2) grid_copies(
                size=[WIDTH - FEET - WALL * 2, 40],
                spacing=[HOLE_DIAMETER, HOLE_DIAMETER],
                stagger=true
              ) cylinder(d=HOLE_DIAMETER, h=WALL + get_slop() * 2);
        }

    //----------------
    // External antenna connector
    //----------------
    tag("holes") right(WIDTH / 2 - WALL) up(SPACER + HEIGHT / 2 + WALL) teardrop(d=6.5, h=10, cap_h=3);

    //----------------
    // Raspberry Pi 5
    //----------------
    tag("holes") up(FEET + SPACER) rpi5(extrude=10, margin=0.5, anchor=LEFT + BOTTOM + FRONT) {
          screw_hole("M3x1", length=SPACER + __RPI_HEIGHT + FEET + WALL / 2, head="socket", anchor=BOTTOM, orient=DOWN);
        }
  }
}

rpi5_case();

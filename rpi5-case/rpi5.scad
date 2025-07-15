include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>

// Dimensions
__RPI_WIDTH = 56;
__RPI_LENGTH = 85;
__RPI_HEIGHT = 1.5;

// Misc.
__RPI_CORNER_RADIUS = 3;
__RPI_HOLE_DIAMETER = 2.7;
__RPI_HOLE_Y_SPACING = 58; // Distance between the centers of the holes in the Y direction
__RPI_HOLE_X_SPACING = 49; // Distance between the centers of the
__RPI_HOLE_SPACE_FROM_EDGE = 3.5; // Distance from the edge to the center of the hole

//----------------
// Raspberry Pi model 5
//----------------
module rpi5(anchor = [0, 0, 0], extrude = 0, margin = 0) {
  //----------------
  // Raspberry Pi PCB
  //----------------
  ghost_this() cuboid(
      [__RPI_WIDTH, __RPI_LENGTH, __RPI_HEIGHT],
      rounding=__RPI_CORNER_RADIUS,
      edges=["Z"],
      anchor=anchor
    ) {
      union() {
        //----------------
        // Raspberry Pi mounting holes
        //----------------
        // The holes are 2.7mm in diameter and are placed on the PCB following a grid.
        // Each hole is 49mm apart in the X direction and 58mm apart in the Y direction.
        //----------------
        position(BOTTOM + BACK)
          up(__RPI_HEIGHT)
            fwd(__RPI_HOLE_SPACE_FROM_EDGE + (__RPI_HOLE_Y_SPACING / 2))
              down(get_slop())
                grid_copies(n=[2, 2], spacing=[__RPI_HOLE_X_SPACING, __RPI_HOLE_Y_SPACING]) {
                  if ($children == 0)
                    cyl(
                      d=__RPI_HOLE_DIAMETER,
                      h=__RPI_HEIGHT + get_slop() * 2 + extrude,
                      anchor=TOP
                    );
                  else
                    children();
                }

        //----------------
        // Raspberry Pi face connectors (USB, Ethernet)
        //----------------
        position(TOP + FRONT)
          back(22 - 3)
            up(16 / 2)
              cuboid([52 + margin, 22 + extrude, 16 + margin], rounding=1, edges=["Y"], anchor=BACK);

        //----------------
        // Raspberry Pi side connectors (Power, micro HDMI)
        //----------------
        position(TOP + BACK + LEFT)
          fwd(7)
            right(8)
              up(5 / 2)
                cuboid([8 + extrude, 40 + margin, 5 + margin], rounding=1, edges=["X"], anchor=BACK + RIGHT);
      }
    }
}

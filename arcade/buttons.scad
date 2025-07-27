include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>

//----------------
// Arcade joystick Zippy
//----------------
module joystick_zippy(anchor = [0, 0, 0]) {
  _plate_width = 65;
  _plate_length = 95;
  _plate_height = 1.5;

  _plate_hole_radius = 9 / 2;
  _plate_hole_length = 3.2;

  _shaft_radius = 30 / 2;

  //----------------
  // Plate
  //----------------
  cuboid(
    [
      _plate_width,
      _plate_length,
      _plate_height,
    ],
    rounding=5,
    edges="Z",
    anchor=anchor
  ) {
    //----------------
    // Joystick shaft hole
    //----------------
    ghost_this() zcyl(
        r=_shaft_radius,
        l=_plate_height + get_slop()
      );

    //----------------
    // Joystick mounting holes
    //----------------
    // 2 rows and 2 columns of holes
    grid_copies(
      n=[2, 2],
      spacing=45
    ) {
      position(TOP) up(get_slop()) zcyl(
            r=_plate_hole_radius,
            l=_plate_hole_length + get_slop(),
            anchor=TOP
          );
    }
  }
}

//----------------
// Arcade button Sanwa
//----------------
module button_sanwa(size = "big", anchor = [0, 0, 0]) {
  assert(size == "big" || size == "small", "Error: size must be 'big' or 'small'");

  _bottom_radius = size == "big" ? 29.5 / 2 : 23.5 / 2;
  _bottom_length = size == "big" ? 19 : 18;

  _top_radius = size == "big" ? 33 / 2 : 27 / 2;
  _top_length = 3;

  _push_radius = size == "big" ? 25 / 2 : 19.5 / 2;
  _push_length = 3;

  //----------------
  // Bottom cylinder
  //----------------
  zcyl(
    r=_bottom_radius,
    l=_bottom_length,
    anchor=anchor
  ) {
    //----------------
    // Cap cylinder
    //----------------
    position(TOP) ghost_this() zcyl(
          r=_top_radius,
          r2=_push_radius,
          l=_top_length,
          anchor=BOTTOM
        ) {
          //----------------
          // Push cylinder
          //----------------
          position(TOP) ghost_this() zcyl(
                r=_push_radius,
                rounding2=1.5,
                l=_push_length,
                anchor=BOTTOM
              );
        }
  }
}

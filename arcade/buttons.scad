include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>

//----------------
// Arcade joystick Zippy
//----------------
module joystick_zippy(extrude = 3.2, anchor = [0, 0, 0]) {
  _plate_width = 65;
  _plate_length = 95;
  _plate_height = 1.5;

  _plate_hole_radius = 9 / 2;
  _plate_hole_length = extrude; // 3.2 (default)

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
module button_sanwa(type = "big", extrude = 0, margin = 0, anchor = [0, 0, 0]) {
  assert(type == "big" || type == "small", "Error: type must be 'big' or 'small'");
  _is_big = type == "big";

  module base() {
    zcyl(
      r=(_is_big ? 29.5 / 2 : 23.5 / 2) + margin,
      l=(_is_big ? 19 : 18) + extrude,
      anchor=anchor
    ) {
      children();
    }
  }

  module cover() {
    zcyl(
      r=_is_big ? 33 / 2 : 27 / 2,
      r2=_is_big ? 27 / 2 : 21 / 2,
      l=3,
      anchor=BOTTOM
    ) {
      children();
    }
  }

  module plunger() {
    zcyl(
      r=_is_big ? 25 / 2 : 19.5 / 2,
      rounding2=1.5,
      l=3,
      anchor=BOTTOM
    ) {
      children();
    }
  }

  base() {
    position(TOP)
      up(get_slop())
        cover() {
          position(TOP) plunger();
        }
  }
}

button_sanwa();

include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <buttons.scad>
include <constants.scad>

//----------------
// Arcade buttons
//----------------
module arcade_joystick_and_buttons(anchor = [0, 0, 0]) {
  // Sanwa button radius (big) radius
  _btn_radius = 29.5 / 2;
  // Joystick plate width
  _stick_width = 65;
  _stick_length = 95;
  // Space between joystick and buttons
  _btn_stick_space = 95;

  // Width is computed as follows:
  // (_stick_width / 2) + _btn_stick_space + 31.25 + 36 + _btn_radius
  _width = _stick_width / 2 + _btn_stick_space + 31.25 + 36 + _btn_radius;

  // Length is computed as follows:
  // (_stick_length / 2) + 18 + 18 + 18
  _length = _stick_length / 2 + 18 + 18 + 18;

  ghost_this() cuboid(
    [
      _width,
      _length,
      0,
    ],
    anchor=anchor
  ) {
    position(FRONT + LEFT + TOP)
      right(_stick_width / 2) back(_length / 2) up(get_slop()) union() {
        // ----------------
        // Joystick
        // ----------------
        joystick_zippy(extrude = 10, anchor=TOP);

        // ----------------
        // Rows of buttons
        // ----------------
        right(_btn_stick_space) union() {
          // Bottom left button
          fwd(18) button_sanwa(anchor=TOP);
          // Bottom middle button
          right(31.25) button_sanwa(anchor=TOP);
          // Bottom right button
          right(31.25 + 36) button_sanwa(anchor=TOP);

          // Top left button
          back(18) button_sanwa(anchor=TOP);
          // Top middle button
          back(18 * 2) right(31.25) button_sanwa(anchor=TOP);
          // Top right button
          back(18 * 2) right(31.25 + 36) button_sanwa(anchor=TOP);
        }
      }
  }
}

//----------------
// Arcade controller
//----------------
// Ref: https://www.slagcoin.com/joystick/layout/cluster36_l.png
module arcade_controller() {
  // Plate dimensions
  _width = 245;
  _length = 120;
  _height = 4;

  diff("holes") {
    //----------------
    // Plate
    //----------------
    down(get_slop()) cuboid(
        [
          _width,
          _length,
          _height,
        ],
        // rounding=5,
        // edges="Z",
        anchor=TOP
      );

    //----------------
    // Legs
    //----------------
    // Left
    left(_width / 2 - _height / 2) cuboid(
      [
        _height,
        _length,
        40
      ],
      anchor=TOP
    );
    // Right
    right(_width / 2 - _height / 2) cuboid(
      [
        _height,
        _length,
        40
      ],
      anchor=TOP
    );
    // Back
    back(_length / 2 - _height / 2) cuboid(
      [
        _width,
        _height,
        40
      ],
      anchor=TOP
    );

    //----------------
    // Buttons and joystick
    //----------------
    tag("holes") arcade_joystick_and_buttons(anchor=TOP);
  }
}

arcade_controller();

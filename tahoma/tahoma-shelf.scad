include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <BOSL2/screws.scad>
include <constants.scad>

thick = 3;
rounding = 1;

module tahoma_shelf() {
  width = 110;
  length = 97;
  border_height = 14;
  back_plate_height = 30;

  //----------------
  // Plate
  //----------------
  cuboid(
    [width + thick, length + thick, thick],
    edges="Z",
    rounding=rounding,
    except=BACK,
    anchor=BOTTOM + FRONT + LEFT
  );

  //----------------
  // Plate border
  //----------------
  rect_tube(
    isize=[width, length],
    wall=thick,
    height=border_height,
    rounding=[0, 0, rounding, rounding],
    anchor=BOTTOM + FRONT + LEFT
  );

  diff("screw") {
    //----------------
    // Back plate
    //----------------
    back(length + thick) cuboid(
        [width + thick * 2, thick, back_plate_height],
        rounding=rounding,
        edges=[TOP + LEFT, TOP + RIGHT],
        anchor=BOTTOM + FRONT + LEFT
      );

    //----------------
    // Back plate holes
    //----------------
    right((width + thick) / 2)
      up((back_plate_height / 2) + 2)
        back(length + 8 + thick * 2)
          xcopies(spacing=60, n=2) tag("screw") screw(
                "M4",
                thread=false,
                head="pan",
                length=10,
                orient=FRONT,
                anchor=BOTTOM + FRONT
              );
  }
}

tahoma_shelf();

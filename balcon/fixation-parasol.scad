include <BOSL2/screws.scad>
include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>

//------------------------------------------------------------------------
// External parameters
//------------------------------------------------------------------------
//
// @param tube_diameter: Diameter of the parasol tube in mm (default is 38mm)
// @param rectangle_width: Width of the rectangle in mm (default is 10.5mm)
// @param rectangle_length: Length of the rectangle in mm (default is 51mm)
// @param distance: Distance between the tube and the rectangle in mm (default is 160mm)
//------------------------------------------------------------------------
tube_diameter = 38;
rectangle_width = 10.5;
rectangle_length = 51;
distance = 160;
ear_length = 40;

//------------------------------------------------------------------------
// Print parameters
//------------------------------------------------------------------------
//
// @param height: Height of the print in mm (default is 30mm)
// @param width: Width (thickness) of the print in mm (default is 3mm)
//------------------------------------------------------------------------
height = 50;
width = 10;

//------------------------------------------------------------------------
// Model parameters - do not change
//------------------------------------------------------------------------
half_distance = distance / 2;
total_length = distance + rectangle_length + tube_diameter + ear_length * 2 + width * 4;

//------------------------------------------------------------------------
// Screw and nut parameters
//------------------------------------------------------------------------
module screw_nut(anchor = [ 0, 0, 0 ])
{
    screw = screw_info("M4", head = "pan", shaft_oversize = .2, head_oversize = .2);
    screw_head_height = 3;
    nut_height = 4;

    tag("screw") screw_hole(screw, length = width - screw_head_height, orient = RIGHT, anchor = anchor) position(BOT)
        nut_trap_inline(nut_height);
}

//------------------------------------------------------------------------
// Model
//------------------------------------------------------------------------
module model()
{
    union() diff("screw")
    {
        //----------------
        // Ear
        //----------------
        back(half_distance + rectangle_length + width) cuboid(size = [ width, ear_length, height ], anchor = FRONT)
        {
            zcopies(n = 3, spacing = (height - 1) / 3) position(RIGHT) screw_nut(anchor = TOP);
        }

        //----------------
        // Rectangle
        //----------------
        back(half_distance - width)
            rect_tube(h = height, isize = [ rectangle_width, rectangle_length ], wall = width, anchor = FRONT);

        //----------------
        // Center
        //----------------
        cuboid(size = [ width, distance, height ])
        {
            fwd(half_distance / 3) zcopies(n = 3, spacing = (height - 1) / 3) position(RIGHT) screw_nut(anchor = TOP);
            back(half_distance / 3) zcopies(n = 3, spacing = (height - 1) / 3) position(RIGHT) screw_nut(anchor = TOP);
        }

        //----------------
        // Tube
        //----------------
        fwd(half_distance - width) tube(h = height, id = tube_diameter, wall = width, anchor = BACK);

        //----------------
        // Ear
        //----------------
        fwd(half_distance + (tube_diameter + width) - 3) cuboid(size = [ width, ear_length + 3, height ], anchor = BACK)
        {
            zcopies(n = 3, spacing = (height - 1) / 3) position(RIGHT) screw_nut(anchor = TOP);
        }
    }
}

model();

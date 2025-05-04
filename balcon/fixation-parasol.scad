include <BOSL2/screws.scad>
include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>

//------------------------------------------------------------------------
// Print parameters
//------------------------------------------------------------------------
//
// @param height: Height of the print in mm (default is 30mm)
// @param width: Width (thickness) of the print in mm
//------------------------------------------------------------------------
height = 50;
width = 10;
rounding = 10;
ear = width * 2;

//------------------------------------------------------------------------
// External parameters
//------------------------------------------------------------------------
//
// @param umbrella_diameter: Diameter of the parasol tube in mm (default is 38mm)
// @param pole_width: Width of the rectangle in mm (default is 10.5mm)
// @param pole_length: Length of the rectangle in mm (default is 51mm)
// @param gap: Distance between the pole and the umbrella in mm (default is 160mm)
//------------------------------------------------------------------------
umbrella_diameter = 38;
pole_width = 10.5;
pole_length = 51;
gap = 160;

//------------------------------------------------------------------------
// Model parameters - do not change
//------------------------------------------------------------------------
distance = gap - width * 2;
half_distance = distance / 2;
total_length = ear + width + umbrella_diameter + width * 2 + distance + width * 2 + pole_length + width + ear;

//------------------------------------------------------------------------
// Screw and nut parameters
//------------------------------------------------------------------------
module screw_nut(anchor = TOP)
{
    screw = screw_info("M4", head = "pan", shaft_oversize = .1, head_oversize = .1);
    screw_head_height = 3;
    nut_height = 4;

    tag("screw") screw_hole(screw, length = width * 2 - screw_head_height, orient = RIGHT, teardrop = "max", spin = 90,
                            anchor = anchor) position(BOT) nut_trap_inline(nut_height, $slop = .05);
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
        back(half_distance + pole_length + width * 2) cuboid(size = [ width * 2, ear, height ], rounding =
        rounding, edges = [ BACK + LEFT, BACK + RIGHT ], anchor = FRONT)
        {
            zcopies(n = 2, spacing = height / 2) position(RIGHT) screw_nut();
        }

        //----------------
        // Pole
        //----------------
        back(half_distance) rect_tube(h = height, isize = [ pole_width, pole_length ], wall = width,
                                      chamfer = pole_width / 2, anchor = FRONT);

        //----------------
        // Center
        //----------------
        cuboid(size = [ width * 2, distance, height ])
        {
            fwd(half_distance - width) zcopies(n = 2, spacing = height / 2) position(RIGHT) screw_nut();
            back(half_distance - width) zcopies(n = 2, spacing = height / 2) position(RIGHT) screw_nut();
        }

        //----------------
        // Umbrella
        //----------------
        fwd(half_distance)
        {
            tube(h = height, id = umbrella_diameter, wall = width, anchor = BACK);
            // Smooth transition between the center and the umbrella
            prismoid(size1 = [width * 2, height], size2 = [width * 2 + width, height], h = width, orient = FRONT);
        }

        //----------------
        // Ear
        //----------------
        fwd(half_distance + umbrella_diameter + width * 2)
        {
            cuboid(size = [ width * 2, ear, height ], rounding = rounding,
                edges = [ FRONT + LEFT, FRONT + RIGHT ], anchor = BACK)
            {
                zcopies(n = 2, spacing = height / 2) position(RIGHT) screw_nut();
            }

            // Smooth transition between the center and the umbrella
            back(width) prismoid(size1 = [width * 2 + width, height], size2 = [width * 2, height], h = width, orient = FRONT);
        }
    }
}

left(15) left_half(total_length) model();
right(15) right_half(total_length) model();

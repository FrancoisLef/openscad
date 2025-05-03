include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>

//------------------------------------------------------------------------
// Print parameters
//------------------------------------------------------------------------
//
// @param HEIGHT: Height of the print in mm (default is 30mm)
// @param WALL: Wall thickness of the print in mm (default is 3mm)
// @param DISTANCE: Distance between the tube and the rectangle in mm (default is 160mm)
//------------------------------------------------------------------------
HEIGHT = 50;
WALL = 30;
DISTANCE = 160;

//------------------------------------------------------------------------
// External parameters
//------------------------------------------------------------------------
//
// @param UMBRELLA_TUBE_DIAMETER: Diameter of the parasol tube in mm (default is 38mm)
// @param RECTANGLE_SUPPORT_WIDTH: Width of the rectangle in mm (default is 10.5mm)
// @param RECTANGLE_SUPPORT_DEPTH: Depth of the rectangle in mm (default is 51mm)
//------------------------------------------------------------------------
UMBRELLA_TUBE_DIAMETER = 38;

RECTANGLE_SUPPORT_WIDTH = 10.5;
RECTANGLE_SUPPORT_DEPTH = 51;

diff("hole")
{
    // Link between the tube and the rectangle
    cuboid(size = [ WALL, DISTANCE, HEIGHT ], anchor = [ 0, 0, 0 ])
    {
        // Support rectangle
        position(BACK)
        {
            tag_this("hole")
                cuboid(size = [ RECTANGLE_SUPPORT_WIDTH, RECTANGLE_SUPPORT_DEPTH, HEIGHT + get_slop() ], anchor = FRONT)
            {
                cuboid(size = [ RECTANGLE_SUPPORT_WIDTH + WALL, RECTANGLE_SUPPORT_DEPTH + WALL, HEIGHT ]);
            }
        }

        // Umbrella tube
        position(FRONT)
        {
            tag_this("hole") cylinder(h = HEIGHT + get_slop(), r = UMBRELLA_TUBE_DIAMETER / 2, anchor = BACK)
            {
                cylinder(h = HEIGHT, r = (UMBRELLA_TUBE_DIAMETER / 2) + (WALL / 2), anchor = [ 0, 0, 0 ]);
            }
        }
    }
}

include <BOSL2/screws.scad>
include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>

exterior_diameter = 35.5;
interior_diameter = 31.5;
loquet_diameter = 9;
loquet_top_from_tube_top = 39;
height = 60;

TUBE_DIAMETER = 35.5;
TUBE_HEIGHT = 60;

TUBE_LOCK_DIAMETER = 9;
TUBE_LOCK_HEIGHT = 7;
TUBE_LOCK_SPACE_FROM_TOP = 39;

THICKNESS = 6;

diff("tube")
{
    color_this("red") cylinder(h = TUBE_HEIGHT + THICKNESS, d = TUBE_DIAMETER + THICKNESS);

    // Parasol tube
    tag("tube") down(get_slop()) cylinder(h = TUBE_HEIGHT, d = TUBE_DIAMETER)
    {
        down(TUBE_LOCK_SPACE_FROM_TOP) left(2) position(TOP + RIGHT)
            cylinder(h = TUBE_LOCK_HEIGHT + 2, d = TUBE_LOCK_DIAMETER + 1, orient = RIGHT, anchor = BOTTOM + LEFT);
    }
}

include <BOSL2/std.scad>
include <constants.scad>

// ------------------------------------------------------------------------
// Usage examples:
//
// microlab_plate(length = 80) {
//    position(BOTTOM + FRONT) microlab_panel(u = 1, lenght = 80);
// }
// ------------------------------------------------------------------------

//------------------------------------------------------------------------
// Microlab plate
//------------------------------------------------------------------------
// This module is used to create a plate unit for the Microlab rack system.
// The plate width will fill the entire width of the rack, and the length is adjustable.
//
// @param length: Length of the plate (default is 90mm)
// @param anchor: Anchor point of the plate (default is BOTTOM + LEFT + FRONT)
//------------------------------------------------------------------------
module microlab_plate(length = 90, anchor = TOP + LEFT + FRONT)
{
    __PLATE_WIDTH = 112;
    __PLATE_THICKNESS = 2;
    __PLATE_SIZE = [ __PLATE_WIDTH, length, __PLATE_THICKNESS ];

    cuboid(__PLATE_SIZE, rounding = __PLATE_THICKNESS, edges = [ BACK + LEFT, BACK + RIGHT ], anchor = anchor)
    {
        children();
    }
}

//------------------------------------------------------------------------
// Microlab panel
//------------------------------------------------------------------------
// This module is used to create a panel for the Microlab rack system.
// The panel height is adjustable based on the number of rack units (U) to cover.
// You can also add supports to the panel that connects with the plate.
//
// @param u: Number of rack units (U) to cover (0.5, 1, 1.5, 2)
// @param support: Whether to add support (default is true)
// @param anchor: Anchor point of the plate (default is BOTTOM + LEFT + FRONT)
//------------------------------------------------------------------------
module microlab_panel(u = 0.5, support = true, length = 80, anchor = BOTTOM + BACK)
{
    assert(u == 0.5 || u == 1 || u == 1.5 || u == 2, "Error: u must be 0.5, 1, 1.5, or 2");

    __U_DEFAULT = 0.5;
    __U_MULTIPLE = u / __U_DEFAULT; // When u is 0.5 -> 1, 1 -> 2, 1.5 -> 3, 2 -> 4
    __PANEL_WIDTH = 148;
    __PANEL_HEIGHT = 22;
    __PANEL_THICKNESS = 3;

    __PANEL_SUPPORT_THICKNESS = 2;

    __PANEL_HOLE_DIAMETER = 3 + get_slop();
    __PANEL_HOLE_PADDING = 9;
    __PANEL_HOLE_Z_COPIES = support ? __U_MULTIPLE : 2;

    __PANEL_EAR_WIDTH = 18;

    // Remove the holes from the panel
    diff("holes")
    {
        // Draw the panel
        cuboid([ __PANEL_WIDTH, __PANEL_THICKNESS, __PANEL_HEIGHT * __U_MULTIPLE ], rounding = __PANEL_THICKNESS / 2,
               edges = [ TOP + LEFT, TOP + RIGHT, BOTTOM + LEFT, BOTTOM + RIGHT ], anchor = anchor)
        {
            // Copy and spread holes along the Z axis up based on U size
            zcopies(n = __PANEL_HOLE_Z_COPIES, spacing = __PANEL_HEIGHT * (__U_MULTIPLE - 1), sp = 0)
                // Copy and spread 2 holes along the X axis
                xcopies(n = 2, spacing = __PANEL_WIDTH - __PANEL_HOLE_DIAMETER - __PANEL_HOLE_PADDING * 2, sp = 0)
                // Center the hole vertically and add a left padding
                position(BOTTOM + LEFT) up(__PANEL_HEIGHT / 2) right(__PANEL_HOLE_PADDING)
                // Draw the hole on the left of the panel
                tag("holes") cylinder(d = __PANEL_HOLE_DIAMETER, h = __PANEL_THICKNESS + get_slop(), orient = BACK,
                                      anchor = LEFT);

            if (support)
            {
                // Copy and spread 2 supports along the X axis
                xcopies(n = 2, spacing = __PANEL_WIDTH - __PANEL_EAR_WIDTH * 2 - __PANEL_SUPPORT_THICKNESS, sp = 0)
                    position(LEFT + BOTTOM + BACK) right(__PANEL_EAR_WIDTH) union()
                {
                    // Draw the first part of the support (rectangle)
                    cuboid([ __PANEL_SUPPORT_THICKNESS, __PANEL_THICKNESS, __PANEL_HEIGHT * __U_MULTIPLE ],
                           anchor = LEFT + BOTTOM + FRONT);
                    // Draw the second part of the support (triangle)
                    back(__PANEL_THICKNESS)
                        wedge([ __PANEL_SUPPORT_THICKNESS, length * 0.7, __PANEL_HEIGHT * __U_MULTIPLE ],
                              anchor = LEFT + BOTTOM + FRONT);
                }
            }

            // Render children
            children();
        }
    }
}

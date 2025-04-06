include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>

//------------------------------------------------------------------------
// Microlab panel
//------------------------------------------------------------------------
// This module is used to create a panel for the Microlab rack system.
// The panel height is adjustable based on the number of rack units (U) to cover.
//
// @param U: Number of rack units (U) to cover (0.5, 1, 1.5, 2)
// @param thick: Thickness of the panel (default is 2mm)
// @param anchor: Anchor point of the plate (default is centered)
//------------------------------------------------------------------------
module microlab_panel(U = 0.5, thick = 2, anchor = [ 0, 0, 0 ])
{
    assert(U == 0.5 || U == 1 || U == 1.5 || U == 2, "Error: U must be 0.5, 1, 1.5, or 2");

    __U_DEFAULT = 0.5;
    __U_MULTIPLE = U / __U_DEFAULT; // When U is 0.5 -> 1, 1 -> 2, 1.5 -> 3, 2 -> 4

    __PANEL_WIDTH = 112;
    __PANEL_HEIGHT = 22;

    __EAR_WIDTH = 18;
    __EAR_THICKNESS = 3;

    __HOLE_DIAMETER = 3 + get_slop();
    __HOLE_THICKNESS = __EAR_THICKNESS + get_slop();
    __HOLE_PADDING = 9;

    diff("microlab_panel_hole")
    {
        //----------------
        // Panel
        //----------------
        cuboid([ __PANEL_WIDTH, thick, __PANEL_HEIGHT * __U_MULTIPLE ], anchor = anchor)
        {
            //----------------
            // Ear
            //----------------
            xflip_copy() position(BOTTOM + FRONT + LEFT)
            {
                cuboid([ __EAR_WIDTH, __EAR_THICKNESS, __PANEL_HEIGHT * __U_MULTIPLE ], rounding = 2,
                       edges = [ TOP + LEFT, BOTTOM + LEFT ], anchor = BOTTOM + FRONT + RIGHT)
                {
                    zcopies(n = 2, spacing = __PANEL_HEIGHT * (__U_MULTIPLE - 1), sp = 0) position(BOTTOM + LEFT)
                        up(__PANEL_HEIGHT / 2) right(__HOLE_PADDING)
                    {
                        tag("microlab_panel_hole")
                            cylinder(d = __HOLE_DIAMETER, h = __HOLE_THICKNESS, orient = BACK, anchor = LEFT);
                    }
                }
            }

            //----------------
            // Children
            //----------------
            children();
        }
    }
}

//------------------------------------------------------------------------
// Microlab plate
//------------------------------------------------------------------------
// This module is used to create a plate unit for the Microlab rack system.
// The plate width will fill the entire width of the rack, and the length is adjustable.
//
// @param length: Length of the plate (default is 90mm)
// @param U: Number of rack units (U) to support (0.5, 1, 1.5, 2)
// @param side_supports: Whether to include a support (default is true)
// @param panel_thick: Thickness of the panel (default is 2mm)
// @param anchor: Anchor point of the plate (default is TOP + FRONT + LEFT)
//------------------------------------------------------------------------
module microlab_plate(length = 90, U = 0.5, side_supports = true, panel_thick = 2, anchor = [ 0, 0, 0 ])
{
    assert(U == 0.5 || U == 1 || U == 1.5 || U == 2, "Error: U must be 0.5, 1, 1.5, or 2");

    __U_DEFAULT = 0.5;
    __U_MULTIPLE = U / __U_DEFAULT; // When U is 0.5 -> 1, 1 -> 2, 1.5 -> 3, 2 -> 4

    __PANEL_HEIGHT = 22;

    __PLATE_WIDTH = 112;
    __PLATE_THICKNESS = 2;

    __SUPPORT_THICKNESS = 2;

    //----------------
    // Plate
    //----------------
    cuboid([ __PLATE_WIDTH, length, __PLATE_THICKNESS ], rounding = __PLATE_THICKNESS,
           edges = [ BACK + LEFT, BACK + RIGHT ], anchor = anchor)
    {
        //----------------
        // Side supports
        //----------------
        if (side_supports)
        {
            xcopies(spacing = __PLATE_WIDTH - __SUPPORT_THICKNESS, n = 2, sp = 0)
            {
                position(BOTTOM + FRONT + LEFT)
                {
                    cuboid([ __SUPPORT_THICKNESS, __SUPPORT_THICKNESS, __PANEL_HEIGHT * __U_MULTIPLE ],
                           anchor = BOTTOM + FRONT + LEFT);

                    back(__SUPPORT_THICKNESS)
                        wedge([ __SUPPORT_THICKNESS, length * 0.7, __PANEL_HEIGHT * __U_MULTIPLE ],
                              anchor = BOTTOM + FRONT + LEFT);
                }
            }
        }

        //----------------
        // Panel
        //----------------
        position(BOTTOM + FRONT + LEFT) microlab_panel(U = U, thick = panel_thick, anchor = BOTTOM + BACK + LEFT);

        //----------------
        // Children
        //----------------
        children();
    }
}

// ------------------------------------------------------------------------
// Usage examples:
//
// microlab_panel(U = 1.5);
// microlab_plate(100, 1.5);
// microlab_plate(length = 50, u = 1);
// ------------------------------------------------------------------------

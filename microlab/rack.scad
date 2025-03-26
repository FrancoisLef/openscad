include <BOSL2/std.scad>

/**
 * Circle resolution constants
 *
 * The $fa, $fs, and $fn special variables control the number of facets used to generate an arc:
 * $fa: Minimum angle for a fragment. Default value is 12 (i.e. 30 fragments for a full circle)
 * $fs: Minimum size of a fragment. Default value is 2 (so very small circles have a smaller number of fragments)
 * $fn: Number of fragments. Default value is 0 (i.e. automatic calculation based on the circle radius and the $fa and
 * $fs values)
 */
$fa = 1;
$fs = $preview ? 1 : 0.1;
$slop = 0.01;

/**
 * Parametric rack module plate
 * - length: Length of the plate (default is 90mm)
 * - anchor: Anchor point of the plate (default is BOTTOM + LEFT + FRONT)
 **/
module rack_plate(length = 90, anchor = TOP + LEFT + FRONT)
{
    __PLATE_WIDTH = 112;
    __PLATE_THICKNESS = 2;

    cuboid([ __PLATE_WIDTH, length, __PLATE_THICKNESS ], rounding = __PLATE_THICKNESS,
           edges = [ BACK + LEFT, BACK + RIGHT ], anchor = anchor) children();
}

/**
 * Parametric rack module panel
 * - u: Number of rack units (U) to cover (0.5, 1, 1.5, 2)
 * - anchor: Anchor point of the plate (default is BOTTOM + BACK)
 **/
module rack_panel(u = 0.5, length = 90, anchor = BOTTOM + BACK)
{
    assert(u == 0.5 || u == 1 || u == 1.5 || u == 2, "Error: u must be 0.5, 1, 1.5, or 2");

    /**
     * Internal variables
     */
    // When u is 0.5 -> 1, 1 -> 2, 1.5 -> 3, 2 -> 4
    __U_DEFAULT = 0.5;
    __U_MULTIPLE = u / __U_DEFAULT;
    __PANEL_WIDTH = 148;
    __PANEL_HEIGHT = 22;
    __PANEL_THICKNESS = 3;

    __PANEL_SUPPORT_THICKNESS = 2;

    __PANEL_HOLE_DIAMETER = 3 + get_slop();
    __PANEL_HOLE_PADDING = 9;

    __PANEL_EAR_WIDTH = 18;

    // Remove the holes from the panel
    diff("holes")
    {
        // Draw the panel
        cuboid([ __PANEL_WIDTH, __PANEL_THICKNESS, __PANEL_HEIGHT * __U_MULTIPLE ], rounding = __PANEL_THICKNESS,
               edges = [ TOP + LEFT, TOP + RIGHT, BOTTOM + LEFT, BOTTOM + RIGHT ], anchor = anchor)
        {
            // Copy and spread holes along the Z axis up based on U size
            zcopies(n = __U_MULTIPLE, spacing = __PANEL_HEIGHT, sp = 0)
                // Copy and spread 2 holes along the X axis
                xcopies(n = 2, spacing = __PANEL_WIDTH - __PANEL_HOLE_DIAMETER - __PANEL_HOLE_PADDING * 2, sp = 0)
                // Center the hole vertically and add a left padding
                position(BOTTOM + LEFT) up(__PANEL_HEIGHT / 2) right(__PANEL_HOLE_PADDING)
                // Draw the hole on the left of the panel
                tag("holes") cylinder(d = __PANEL_HOLE_DIAMETER, h = __PANEL_THICKNESS + get_slop(), orient = BACK,
                                      anchor = LEFT);

            xcopies(n = 2, spacing = __PANEL_WIDTH - __PANEL_EAR_WIDTH * 2 - __PANEL_SUPPORT_THICKNESS, sp = 0)
                position(LEFT + BOTTOM + BACK) right(__PANEL_EAR_WIDTH) union()
            {
                cuboid([ __PANEL_SUPPORT_THICKNESS, __PANEL_THICKNESS, __PANEL_HEIGHT * __U_MULTIPLE ],
                       anchor = LEFT + BOTTOM + FRONT);

                back(__PANEL_THICKNESS)
                    wedge([ __PANEL_SUPPORT_THICKNESS, length * 0.7, __PANEL_HEIGHT * __U_MULTIPLE ],
                          anchor = LEFT + BOTTOM + FRONT);
            }

            // Render children
            children();
        }
    }
}

// Example:
// rack_plate()
// {
//     position(BOTTOM + FRONT) rack_panel();
//     position(LEFT + FRONT) cuboid(50, anchor = BOTTOM + LEFT + FRONT);
// }

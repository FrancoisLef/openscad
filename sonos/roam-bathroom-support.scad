include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>

__HEATER_TUBE_DIAMETER = 23;
__HEATER_TUBE_SPACING = 20;
__HEATER_TUBE_LENGTH = 300;

module heater_tubes(extra = false, anchor = [ 0, 0, 0 ])
{
    // Bottom tube
    xcyl(d = __HEATER_TUBE_DIAMETER, l = __HEATER_TUBE_LENGTH, anchor = anchor)
    {
        // Spacer filler
        cuboid(
            [
                __HEATER_TUBE_LENGTH + get_slop() * 2, __HEATER_TUBE_DIAMETER, __HEATER_TUBE_DIAMETER +
                __HEATER_TUBE_SPACING
            ],
            anchor = BOTTOM);

        up(__HEATER_TUBE_DIAMETER + __HEATER_TUBE_SPACING)
        {
            // Top tube
            xcyl(d = __HEATER_TUBE_DIAMETER, l = __HEATER_TUBE_LENGTH);

            if (extra)
            {
                // Extra top spacer
                cuboid(
                    [
                        __HEATER_TUBE_LENGTH + get_slop() * 2, __HEATER_TUBE_DIAMETER, __HEATER_TUBE_DIAMETER +
                        __HEATER_TUBE_SPACING
                    ],
                    anchor = BOTTOM);
            }
        }
    }
}

module sonos_roam(anchor = [ 0, 0, 0 ])
{
    __WIDTH = 200;
    __THICKNESS = 3;
    __DEPTH = 70;

    __SUPPORT_WIDTH = 20;
    // (Diameter of a tube * number of tubes to cover) + spacing between tubes
    __SUPPORT_HEIGHT = (__HEATER_TUBE_DIAMETER * 2) + __HEATER_TUBE_SPACING;

    diff("tubes")
    {
        // Base
        cuboid([ __WIDTH, __DEPTH, __THICKNESS ], rounding = 3, edges = [ FRONT, BACK ], except = [ TOP, BOTTOM ],
               anchor = anchor)
        {
            position(TOP) xcopies(n = 2, spacing = __WIDTH / 2 + __SUPPORT_WIDTH / 2)
            {
                // Tube support
                prismoid(size1 = [ __SUPPORT_WIDTH, __DEPTH - 10 ], size2 = [ __SUPPORT_WIDTH, __DEPTH - 40 ],
                         height = __SUPPORT_HEIGHT, rounding = 5);
            }

            tag("tubes") position(TOP) up(5) heater_tubes(extra = false, anchor = BOTTOM);
        }
    }
}

sonos_roam();

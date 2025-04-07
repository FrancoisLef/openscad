include <../constants.scad>
include <BOSL2/std.scad>

//------------------------------------------------------------------------
// Antenna for Sonoff Zigbee 3.0 USB Dongle Plus
//------------------------------------------------------------------------
// This module is used to create an antenna for the Sonoff Zigbee 3.0 USB Dongle.
//
// @param diameter: Diameter of the antenna connector (default is false)
// @param extension: Whether to include the antenna extension (default is true)
// @param oriented: Whether to pivot the antenna extension (default is true)
// @param anchor: Anchor point of the antenna (default is center)
//------------------------------------------------------------------------
module sonoff_zigbee_3_0_antenna(diameter = false, extension = true, oriented = true, anchor = [ 0, 0, 0 ])
{
    assert(diameter == false || (is_num(diameter)), "Error: diameter must be false or a valid number");

    __CONNECTOR_DIAMETER = (diameter == false || diameter == 0) ? 6.1 : diameter;
    __EXTENSION_CORE_DIAMETER = __CONNECTOR_DIAMETER + 3.4;
    __EXTENSION_PIVOT_DIAMETER = __CONNECTOR_DIAMETER + 1.9;

    //----------------
    // Antenna - Plate
    //----------------
    color_this("goldenrod") cuboid([ 6.5, 1.5, 6.5 ], rounding = .2,
                                   edges = [ TOP + LEFT, TOP + RIGHT, BOTTOM + LEFT, BOTTOM + RIGHT ], anchor = anchor)
    {
        //----------------
        // Antenna - Connector
        //----------------
        color_this("goldenrod") position(FRONT) back(get_slop()) ycyl(d = __CONNECTOR_DIAMETER, h = 8, anchor = BACK);

        if (extension)
        {
            //----------------
            // Antenna - Extension core
            //----------------
            color_this("dimgray") position(FRONT) fwd(3)
                ycyl(d2 = __EXTENSION_CORE_DIAMETER + 0.5, d1 = __EXTENSION_CORE_DIAMETER, h = 21, rounding = .5,
                     anchor = BACK)
            {
                //----------------
                // Antenna - Extension pivot
                //----------------
                if (oriented)
                {
                    color_this("dimgray") position(BOTTOM + FRONT)
                        zcyl(d1 = __EXTENSION_PIVOT_DIAMETER + 1.5, d2 = __EXTENSION_PIVOT_DIAMETER, h = 86,
                             rounding2 = 4, rounding1 = .5, anchor = BOTTOM + BACK);
                }
                else
                {
                    color_this("dimgray") position(FRONT)
                        ycyl(d2 = __EXTENSION_PIVOT_DIAMETER + 1.5, d1 = __EXTENSION_PIVOT_DIAMETER, h = 86,
                             rounding1 = 4, rounding2 = .5, anchor = BACK);
                }
            }
        }
    }
}

//------------------------------------------------------------------------
// USB connector for Sonoff Zigbee 3.0 USB Dongle Plus
//------------------------------------------------------------------------
// This module is used to create an USB connector for the Sonoff Zigbee 3.0 USB Dongle.
//
// @param anchor: Anchor point of the antenna (default is center)
//------------------------------------------------------------------------
module sonoff_zigbee_3_0_usb(anchor = [ 0, 0, 0 ])
{
    diff("usb_hole")
    {
        //----------------
        // USB - Shell
        //----------------
        color_this("gainsboro")
            cuboid([ 12, 19, 4.6 ], rounding = .2, edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ],
                   anchor = anchor)
        {
            //----------------
            // USB - Foolproof hole
            //----------------
            color_this("white") tag("usb_hole") position(TOP + FRONT) down(0.3) fwd(get_slop())
                cuboid([ 11, 9, 2 ], anchor = TOP + FRONT);

            //----------------
            // USB - Top holes
            //----------------
            color_this("gainsboro") tag("usb_hole") xcopies(spacing = 5.5, n = 2, sp = 0) position(TOP + FRONT + LEFT)
                right(2) back(5) up(get_slop())
                    cuboid([ 2, 2, 2 ], edges = [ BACK + LEFT, BACK + RIGHT, FRONT + LEFT, FRONT + RIGHT ],
                           rounding = .2, anchor = TOP + FRONT + LEFT);

            //----------------
            // USB - Connection
            //----------------
            color_this("white") position(BOTTOM + FRONT) up(0.3) fwd(get_slop())
                cuboid([ 11, 9, 2 ], anchor = BOTTOM + FRONT);
        }
    }
}

//------------------------------------------------------------------------
// Sonoff Zigbee 3.0 USB Dongle PCB
//------------------------------------------------------------------------
// This module is used to create a PCB model for the Sonoff Zigbee 3.0 USB Dongle.
//
// @param extension: Whether to include the antenna extension (default is true)
// @param diameter: Diameter of the antenna connector (default is false)
// @param hole_length: Length of the holes (default is 5)
// @param anchor: Anchor point of the antenna (default is center)
//------------------------------------------------------------------------
module sonoff_zigbee_3_0_pcb(extension = true, diameter = false, hole_length = 5, anchor = [ 0, 0, 0 ])
{
    color_this("green") cuboid([ 23, 50, 1.6 ], anchor = anchor)
    {
        //----------------
        // Antenna
        //----------------
        position(BOTTOM + FRONT) down(1)
            sonoff_zigbee_3_0_antenna(diameter = diameter, extension = extension, anchor = BACK + BOTTOM);

        //----------------
        // USB
        //----------------
        position(BOTTOM + BACK) zrot(180) up(.5) back(4) sonoff_zigbee_3_0_usb(anchor = BACK + BOTTOM);

        //----------------
        // Hole - Front Left
        //----------------
        position(TOP + FRONT + LEFT) up(get_slop()) back(2) right(2.5)
            zcyl(d = 2, l = hole_length, anchor = TOP + FRONT + LEFT);

        //----------------
        // Hole - Front Right
        //----------------
        position(TOP + FRONT + RIGHT) up(get_slop()) back(2) left(2.5)
            zcyl(d = 2, l = hole_length, anchor = TOP + FRONT + RIGHT);

        //----------------
        // Hole - Back Left
        //----------------
        position(TOP + BACK + LEFT) up(get_slop()) fwd(2) right(2.5)
            zcyl(d = 2, l = hole_length, anchor = TOP + BACK + LEFT);

        //----------------
        // Hole - Back Right
        //----------------
        position(TOP + BACK + RIGHT) up(get_slop()) fwd(2) left(2.5)
            zcyl(d = 2, l = hole_length, anchor = TOP + BACK + RIGHT);
    }
}

//------------------------------------------------------------------------
// Sonoff Zigbee 3.0 USB Dongle Plus
//------------------------------------------------------------------------
// This module is used to create a Sonoff Zigbee 3.0 USB Dongle Plus model.
//
// @param extension: Whether to include the antenna extension (default is true)
// @param diameter: Diameter of the antenna connector (default is false)
// @param anchor: Anchor point of the dongle (default is center)
//------------------------------------------------------------------------
module sonoff_zigbee_3_0_dongle(extension = true, diameter = false, anchor = [ 0, 0, 0 ])
{
    assert(diameter == false || (is_num(diameter) && diameter > 0), "Error: diameter must be false or a valid number");

    //----------------
    // Body
    //----------------
    color_this("dimgray") cuboid([ 26, 52, 14 ], rounding = .5,
                                 edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = anchor)
    {
        //----------------
        // Antenna
        //----------------
        position(BOTTOM + FRONT) up(1.5) back(1.5 - get_slop())
            sonoff_zigbee_3_0_antenna(diameter = diameter, extension = extension, anchor = BACK + BOTTOM);

        //----------------
        // USB connector
        //----------------
        color_this("lightgray") position(BACK + BOTTOM) up(3) fwd(5) zrot(180)
            sonoff_zigbee_3_0_usb(anchor = BACK + BOTTOM);
    };
}

// ------------------------------------------------------------------------
// Usage examples:
//
// sonoff_zigbee_3_0_pcb();
// sonoff_zigbee_3_0_pcb(diameter = 12, extension = true, hole_length = 20);
//
// sonoff_zigbee_3_0_dongle();
// sonoff_zigbee_3_0_dongle(diameter = 1);
// sonoff_zigbee_3_0_dongle(diameter = 12, extension = true);
//
// Sub-modules:
//
// sonoff_zigbee_3_0_usb();
// sonoff_zigbee_3_0_antenna(diameter = false, extension = true, oriented = true);
// ------------------------------------------------------------------------

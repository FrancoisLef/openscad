include <../constants.scad>
include <BOSL2/std.scad>

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

    __BODY_WIDTH = 26;
    __BODY_LENGTH = 52;
    __BODY_HEIGHT = 14;

    __ANTENNA_CONNECTOR_WIDTH = 6.5;
    __ANTENNA_CONNECTOR_DIAMETER = (diameter == false) ? 6 : diameter;
    __ANTENNA_CONNECTOR_LENGTH = 10;
    __ANTENNA_CONNECTOR_VISIBLE_LENGTH = 3;

    __ANTENNA_EXTENSION_DIAMETER = (diameter == false) ? 10 : diameter + get_slop();
    __ANTENNA_EXTENSION_LENGTH = 105;

    __USB_WIDTH = 12;
    __USB_LENGTH = 14;
    __USB_HEIGHT = 5;

    //----------------
    // Body
    //----------------
    color_this("dimgray") cuboid([ __BODY_WIDTH, __BODY_LENGTH, __BODY_HEIGHT ], rounding = .5,
                                 edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = anchor)
    {
        //----------------
        // Antenna - support
        // First draw the gold cube that supports the antenna connector, then draw the antenna connector centered on it.
        //----------------
        color_this("goldenrod") position(BOTTOM + FRONT) up(1.5)
            cuboid([ __ANTENNA_CONNECTOR_WIDTH, get_slop() / 2, __ANTENNA_CONNECTOR_WIDTH ], anchor = BACK + BOTTOM)
        {
            //----------------
            // Antenna - threaded connector
            //----------------
            color_this("goldenrod") position(FRONT)
                ycyl(d = __ANTENNA_CONNECTOR_DIAMETER, h = __ANTENNA_CONNECTOR_LENGTH, anchor = BACK)
            {
                //----------------
                // Antenna - extension
                //----------------
                if (extension)
                {
                    position(FRONT) back(__ANTENNA_CONNECTOR_LENGTH - __ANTENNA_CONNECTOR_VISIBLE_LENGTH)
                        // Extension straight
                        color_this("black") ycyl(d = __ANTENNA_EXTENSION_DIAMETER, h = 21, anchor = BACK);
                    // Extension antenna
                    position(FRONT + BOTTOM) color_this("black")
                        zcyl(d = __ANTENNA_EXTENSION_DIAMETER, h = 87, rounding2 = __ANTENNA_EXTENSION_DIAMETER / 2,
                             anchor = BOTTOM + BACK);
                }
            }
        }

        //----------------
        // USB connector
        //----------------
        color_this("lightgray") position(BACK + BOTTOM) up(3)
            cuboid([ __USB_WIDTH, __USB_LENGTH, __USB_HEIGHT ], rounding = .2,
                   edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = FRONT + BOTTOM);
    };
}

// ------------------------------------------------------------------------
// Usage examples:
//
// sonoff_zigbee_3_0_dongle();
// sonoff_zigbee_3_0_dongle(diameter = 1);
// sonoff_zigbee_3_0_dongle(diameter = 12, extension = true);
// ------------------------------------------------------------------------

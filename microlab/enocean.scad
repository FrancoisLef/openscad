include <BOSL2/std.scad>
include <constants.scad>

//------------------------------------------------------------------------
// Enocean TCM310 USB Dongle
//------------------------------------------------------------------------
// This module is used to create an Enocean TCM 310 USB Dongle model.
//
// @param anchor: Anchor point of the dongle (default is BOTTOM + LEFT + FRONT)
//------------------------------------------------------------------------
// Example usage:
//
// enocean_tcm_310();
// enocean_tcm_310(antenna_extension = false);
// ------------------------------------------------------------------------
module enocean_tcm_310(antenna_extension = true, anchor = BOTTOM + LEFT + FRONT)
{
    __BODY_WIDTH = 23;
    __BODY_LENGTH = 51;
    __BODY_HEIGHT = 9;

    __ANTENNA_CONNECTOR_DIAMETER = 6.5;
    __ANTENNA_CONNECTOR_LENGTH = 5.5;

    __ANTENNA_EXTENSION_DIAMETER = 9;
    __ANTENNA_EXTENSION_LENGTH = 12;

    __USB_WIDTH = 12;
    __USB_LENGTH = 12.5;
    __USB_HEIGHT = 5;

    // Body
    color_this("white") cuboid([ __BODY_WIDTH, __BODY_LENGTH, __BODY_HEIGHT ], rounding = 1,
                               edges = [ FRONT, LEFT, RIGHT ], anchor = anchor)
    {
        // Antenna
        color_this("gold") position(FRONT)
            ycyl(d = __ANTENNA_CONNECTOR_DIAMETER, h = __ANTENNA_CONNECTOR_LENGTH, anchor = BACK)
        {
            if (antenna_extension)
            {
                // Extension body
                color_this("gold") position(FRONT) back(__ANTENNA_CONNECTOR_LENGTH)
                    ycyl(d = __ANTENNA_EXTENSION_DIAMETER, h = __ANTENNA_EXTENSION_LENGTH, anchor = BACK)
                    // Extension cube
                    position(FRONT) cuboid(7, anchor = BACK)
                    // Extension antenna
                    color_this("black") position(TOP)
                        zcyl(d1 = 10, d2 = 8, h = 100, rounding1 = 1, rounding2 = 4, anchor = BOTTOM);
            }
        }

        // USB connector
        color_this("lightgray") position(BACK)
            cuboid([ __USB_WIDTH, __USB_LENGTH, __USB_HEIGHT ], rounding = .2,
                   edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = FRONT);
    }
}

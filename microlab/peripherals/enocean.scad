include <../constants.scad>
include <BOSL2/std.scad>

//------------------------------------------------------------------------
// Enocean TCM310 USB Dongle
//------------------------------------------------------------------------
// This module is used to create an Enocean TCM 310 USB Dongle model.
//
// @param extension: Whether to include the antenna extension (default is true)
// @param diameter: Diameter of the antenna connector (default is false)
// @param anchor: Anchor point of the dongle (default is center)
//------------------------------------------------------------------------
module enocean_tcm_310(extension = true, diameter = false, anchor = [ 0, 0, 0 ])
{
    assert(diameter == false || (is_num(diameter) && diameter > 0), "Error: diameter must be false or a valid number");

    __BODY_WIDTH = 23;
    __BODY_LENGTH = 51;
    __BODY_HEIGHT = 9;

    __ANTENNA_CONNECTOR_DIAMETER = (diameter == false) ? 6.5 : diameter;
    __ANTENNA_CONNECTOR_LENGTH = 5.5;

    __ANTENNA_EXTENSION_DIAMETER = (diameter == false) ? 9 : diameter;
    __ANTENNA_EXTENSION_LENGTH = 12;

    __USB_WIDTH = 12;
    __USB_LENGTH = 12.5;
    __USB_HEIGHT = 5;

    //----------------
    // Body
    //----------------
    color_this("white") cuboid([ __BODY_WIDTH, __BODY_LENGTH, __BODY_HEIGHT ], rounding = 1,
                               edges = [ FRONT, LEFT, RIGHT ], anchor = anchor)
    {
        //----------------
        // Antenna
        //----------------
        color_this("goldenrod") position(FRONT)
            ycyl(d = __ANTENNA_CONNECTOR_DIAMETER, h = __ANTENNA_CONNECTOR_LENGTH, anchor = BACK)
        {
            //----------------
            // Antenna extension
            //----------------
            if (extension)
            {
                color_this("goldenrod") position(FRONT) back(__ANTENNA_CONNECTOR_LENGTH - 2)
                    ycyl(d = __ANTENNA_EXTENSION_DIAMETER, h = __ANTENNA_EXTENSION_LENGTH, anchor = BACK)
                    // Extension cube
                    position(FRONT) cuboid(7, anchor = BACK)
                    // Extension antenna
                    color_this("black") position(TOP)
                        zcyl(d1 = 10, d2 = 8, h = 100, rounding1 = 1, rounding2 = 4, anchor = BOTTOM);
            }
        }

        //----------------
        // USB connector
        //----------------
        color_this("lightgray") position(BACK)
            cuboid([ __USB_WIDTH, __USB_LENGTH, __USB_HEIGHT ], rounding = .2,
                   edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = FRONT);
    }
}

// ------------------------------------------------------------------------
// Usage examples:
//
// enocean_tcm_310();
// enocean_tcm_310(diameter = 12);
// enocean_tcm_310(diameter = 12, extension = false);
// ------------------------------------------------------------------------

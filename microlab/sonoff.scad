include <BOSL2/std.scad>
include <constants.scad>

//------------------------------------------------------------------------
// Sonoff Zigbee 3.0 USB Dongle Plus
//------------------------------------------------------------------------
// This module is used to create a Sonoff Zigbee 3.0 USB Dongle Plus model.
//------------------------------------------------------------------------
// Example usage:
//
// sonoff_zigbee_3_0_dongle();
// sonoff_zigbee_3_0_dongle(antenna_extension = false);
// ------------------------------------------------------------------------
module sonoff_zigbee_3_0_dongle(antenna_extension = true)
{
    __BODY_WIDTH = 26;
    __BODY_LENGTH = 52;
    __BODY_HEIGHT = 14;

    __ANTENNA_CONNECTOR_DIAMETER = 6.5;
    __ANTENNA_CONNECTOR_LENGTH = 10;
    __ANTENNA_CONNECTOR_VISIBLE_LENGTH = 3;

    __ANTENNA_EXTENSION_DIAMETER = 10;
    __ANTENNA_EXTENSION_LENGTH = 105;

    __USB_WIDTH = 12;
    __USB_LENGTH = 14;
    __USB_HEIGHT = 5;

    // Body
    color_this("dimgray")
        cuboid([ __BODY_WIDTH, __BODY_LENGTH, __BODY_HEIGHT ], rounding = .5,
               edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = LEFT + BOTTOM + FRONT)
    {
        // Antenna
        color_this("gold") position(FRONT + BOTTOM) up(1.5)
            ycyl(d = __ANTENNA_CONNECTOR_DIAMETER, h = __ANTENNA_CONNECTOR_LENGTH, anchor = BOTTOM + BACK)
        {
            // Extension
            if (antenna_extension)
            {
                color_this("black") position(FRONT)
                    back(__ANTENNA_CONNECTOR_LENGTH - __ANTENNA_CONNECTOR_VISIBLE_LENGTH)
                    // Extension straight
                    ycyl(d = __ANTENNA_EXTENSION_DIAMETER, h = 21, anchor = BACK)
                    // Extension antenna
                    position(FRONT + BOTTOM) color_this("black")
                        zcyl(d = __ANTENNA_EXTENSION_DIAMETER, h = 87, rounding2 = 5, anchor = BOTTOM + BACK);
            }
        }

        // USB connector
        color_this("lightgray") position(BACK + BOTTOM) up(3)
            cuboid([ __USB_WIDTH, __USB_LENGTH, __USB_HEIGHT ], rounding = .2,
                   edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = FRONT + BOTTOM);
    };
}

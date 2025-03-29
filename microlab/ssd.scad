include <BOSL2/std.scad>
include <constants.scad>

//------------------------------------------------------------------------
// SSD NVMe M.2 2230 - Orico Enclosure
//------------------------------------------------------------------------
// This module is used to create a model of the SSD M.2 2230 Orico enclosure.
//
// @param anchor: Anchor point of the ssd (default is BOTTOM + LEFT + FRONT)
//------------------------------------------------------------------------
// Example usage:
//
// ssd_2230();
// ------------------------------------------------------------------------
module ssd_2230(usb_cable = true, anchor = BOTTOM + LEFT + FRONT)
{
    __BODY_WIDTH = 46;
    __BODY_LENGTH = 46;
    __BODY_HEIGHT = 12.5;

    __HEATSINK_WIDTH = 23;
    __HEATSINK_LENGTH = 32;
    __HEATSINK_HEIGHT = 1;

    __USB_WIDTH = 10;
    __USB_LENGTH = 8;
    __USB_HEIGHT = 4;

    __USB_CABLE_WIDTH = 12;
    __USB_CABLE_LENGTH = 27;
    __USB_CABLE_HEIGHT = 8;

    // Body
    color_this("white") cuboid([ __BODY_WIDTH, __BODY_LENGTH, __BODY_HEIGHT ], rounding = 6,
                               edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = anchor)
    {
        // Heatsink
        position(TOP) color_this("silver") down(__HEATSINK_HEIGHT - get_slop())
            cuboid([ __HEATSINK_WIDTH, __HEATSINK_LENGTH, __HEATSINK_HEIGHT ], rounding = 1,
                   edges = [ BACK + LEFT, BACK + RIGHT, FRONT + LEFT, FRONT + RIGHT ], anchor = BOTTOM);

        // USB Type-C connector
        position(FRONT) color_this("lightgray") fwd(get_slop())
            cuboid([ __USB_WIDTH, __USB_LENGTH, __USB_HEIGHT ], rounding = 2,
                   edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = FRONT);

        if (usb_cable)
        {
            // USB Type-C cable
            position(FRONT) color_this("black") fwd(get_slop())
                cuboid([ __USB_CABLE_WIDTH, __USB_CABLE_LENGTH, __USB_CABLE_HEIGHT ], rounding = 2,
                       edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = BACK);
        }
    };
}

include <BOSL2/std.scad>

include <rack.scad>

module sonoff()
{
    __SONOFF_BODY_WIDTH = 26;
    __SONOFF_BODY_LENGTH = 52;
    __SONOFF_BODY_HEIGHT = 14;

    __ANTENNA_CONNECTOR = 10;
    __ANTENNA_LENGTH = 35;

    __USB_WIDTH = 12;
    __USB_LENGTH = 14;
    __USB_HEIGHT = 5;

    // Body
    back($slop) right(2 + $slop)
        cuboid([ __SONOFF_BODY_WIDTH, __SONOFF_BODY_LENGTH, __SONOFF_BODY_HEIGHT ], anchor = LEFT + BOTTOM + FRONT)
    {
        // Antenna
        position(FRONT + BOTTOM)
            cuboid([ __ANTENNA_CONNECTOR, __ANTENNA_LENGTH, __ANTENNA_CONNECTOR ], anchor = BACK + BOTTOM);

        // USB connector
        position(BACK + BOTTOM) up(3) cuboid([ __USB_WIDTH, __USB_LENGTH, __USB_HEIGHT ], anchor = FRONT + BOTTOM);
    }
}

module sonoff_support()
{
    back($slop) right(2 + $slop) cuboid([ 29, 55, 7.5 ], anchor = LEFT + BOTTOM + FRONT);
}

module usb_expansion()
{
    __USB_EXPANSION_WIDTH = 22;
    __USB_EXPANSION_HEIGHT = 11;
    __USB_EXPANSION_LENGTH = 50;

    // USB expansion
    right(35) fwd(30) cuboid([ __USB_EXPANSION_WIDTH, __USB_EXPANSION_LENGTH, __USB_EXPANSION_HEIGHT ],
                             anchor = LEFT + BOTTOM + FRONT);
}

module ssd()
{
    __SSD_WIDTH = 41;
    __SSD_HEIGHT = 12;
    __SSD_LENGTH = 45;

    // SSD
    left(2) cuboid([ __SSD_WIDTH, __SSD_LENGTH, __SSD_HEIGHT ], anchor = RIGHT + BOTTOM + FRONT);
}

module ssd_support()
{
    left(2) cuboid([ 44, 48, 3 ], anchor = RIGHT + BOTTOM + FRONT);
}

rack_plate()
{
    difference()
    {
        // Show panel
        position(BOTTOM + FRONT) rack_panel();

        position(LEFT + FRONT + TOP)
        {
            // Remove sonoff
            sonoff();
            // Remove USB expansion
            usb_expansion();
        }
    }

    position(RIGHT + FRONT + TOP) difference()
    {
        ssd_support();
        ssd();
    }

    position(LEFT + FRONT + TOP) difference()
    {
        // Show sonoff support
        sonoff_support();
        sonoff();
    }
}

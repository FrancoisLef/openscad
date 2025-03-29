include <BOSL2/std.scad>

include <rack.scad>

SONOFF_BODY_WIDTH = 26;
SONOFF_BODY_LENGTH = 52;
SONOFF_BODY_HEIGHT = 14;
SONOFF_BODY_SIZE = [ SONOFF_BODY_WIDTH, SONOFF_BODY_LENGTH, SONOFF_BODY_HEIGHT ];

SONOFF_ANTENNA_CONNECTOR = 10;
SONOFF_ANTENNA_LENGTH = 10;
SONOFF_ANTENNA_SIZE = [ SONOFF_ANTENNA_CONNECTOR, SONOFF_ANTENNA_LENGTH, SONOFF_ANTENNA_CONNECTOR ];

SONOFF_USB_WIDTH = 12;
SONOFF_USB_LENGTH = 14;
SONOFF_USB_HEIGHT = 5;
SONOFF_USB_SIZE = [ SONOFF_USB_WIDTH, SONOFF_USB_LENGTH, SONOFF_USB_HEIGHT ];

module sonoff()
{
    // Body
    cuboid(SONOFF_BODY_SIZE, anchor = LEFT + BOTTOM + FRONT)
    {
        // Antenna
        position(FRONT + BOTTOM) up(1)
            cuboid(SONOFF_ANTENNA_SIZE, rounding = 2,
                   edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ], anchor = BACK + BOTTOM);

        // USB
        position(BACK + BOTTOM) up(3)
            cuboid(SONOFF_USB_SIZE, rounding = .2, edges = [ LEFT + TOP, LEFT + BOTTOM, RIGHT + TOP, RIGHT + BOTTOM ],
                   anchor = FRONT + BOTTOM);
    };
}

module sonoff_support()
{
    right(28)
        cuboid([ 1, SONOFF_BODY_LENGTH + 3, 5 ], rounding = 1, edges = [BACK + RIGHT], anchor = LEFT + BOTTOM + FRONT)
        // Left turn
        position(BACK + LEFT + TOP)
            cuboid([ SONOFF_BODY_WIDTH, 1, 5 ], rounding = 1, edges = [TOP + LEFT], anchor = BACK + RIGHT + TOP);
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

rack_plate(70)
{
    diff("sonoff")
    {
        position(BOTTOM + FRONT) rack_panel();
        position(LEFT + FRONT + TOP) sonoff_support();
        position(LEFT + FRONT + TOP) right(2 + $slop) up($slop) back($slop) tag("sonoff") sonoff();
    }

    // position(RIGHT + FRONT + TOP) difference()
    // {
    //     ssd_support();
    //     ssd();
    // }

    // position(LEFT + FRONT + TOP) difference()
    // {
    //     // Show sonoff support
    //     sonoff_support();
    //     sonoff();
    // }
}

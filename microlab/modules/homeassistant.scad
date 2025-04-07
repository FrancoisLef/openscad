include <BOSL2/std.scad>

include <../microlab.scad>
include <../peripherals/enocean.scad>
include <../peripherals/sonoff.scad>
include <../peripherals/ssd.scad>

DONGLE_DIAMETER = 8;
DONGLE_EXTENSION = false;

diff("peripheral") microlab_plate(length = 60) back(get_slop()) up(get_slop())
{
    //----------------
    // Left position - Sonoff Zigbee Dongle
    //----------------
    position(TOP + FRONT + LEFT) right(2 + get_slop())
    {
        //----------------
        // Bottom support - elevate the dongle
        //----------------
        back(5) cuboid([ 26, 47, 4.22 ], anchor = BOTTOM + FRONT + LEFT) position(TOP + FRONT + LEFT) fwd(5)
            up(get_slop())
            //----------------
            // Peripheral - Sonoff Zigbee Dongle
            //----------------
            tag("peripheral") sonoff_zigbee_3_0_dongle(diameter = DONGLE_DIAMETER, extension = DONGLE_EXTENSION,
                                                       anchor = BOTTOM + FRONT + LEFT);

        //----------------
        // Right support
        //----------------
        right(26 + get_slop()) cuboid([ 2, 55, 2 ], rounding = 1, edges = [ TOP + RIGHT, BACK + RIGHT, BACK + TOP ],
                                      anchor = FRONT + LEFT + BOTTOM);
        //----------------
        // Back support
        //----------------
        back(53)
            cuboid([ 26, 2, 2 ], rounding = 1, edges = [ TOP + FRONT, TOP + BACK ], anchor = FRONT + LEFT + BOTTOM);
    }

    //----------------
    // Right position - Enocean TCM310
    //----------------
    position(TOP + FRONT + RIGHT) left(2 + get_slop())
    {
        //----------------
        // Bottom support - elevate the dongle
        //----------------
        back(5) cuboid([ 23, 46, 4.48 ], anchor = BOTTOM + FRONT + RIGHT) position(TOP + FRONT + RIGHT) fwd(5)
            up(get_slop())
            //----------------
            // Peripheral - Enocean TCM310
            //----------------
            tag("peripheral") enocean_tcm_310(diameter = DONGLE_DIAMETER, extension = DONGLE_EXTENSION,
                                              anchor = BOTTOM + FRONT + RIGHT);

        //----------------
        // Left support
        //----------------
        left(23) cuboid([ 2, 51, 2 ], rounding = 1, edges = [LEFT + TOP], anchor = FRONT + RIGHT + BOTTOM);

        //----------------
        // Back support
        //----------------
        back(51) cuboid([ 25, 2, 2 ], rounding = 1, edges = [ TOP + BACK, TOP + BACK + LEFT ],
                        anchor = FRONT + RIGHT + BOTTOM);
    }

    //----------------
    // Center position - SSD M.2 2230
    //----------------
    position(TOP + RIGHT + FRONT) left(2 + 29 + get_slop())
    {
        //----------------
        // Peripheral - SSD
        //----------------
        tag("peripheral") xrot(180) ssd_2230(anchor = TOP + BACK + RIGHT);

        //----------------
        // Right support
        //----------------
        cuboid([ 2, 46, 10 ], anchor = FRONT + LEFT + BOTTOM, rounding = 5, edges = [BACK + TOP]);

        //----------------
        // Left support
        //----------------
        left(46) cuboid([ 2, 46, 10 ], anchor = FRONT + RIGHT + BOTTOM, rounding = 5, edges = [BACK + TOP]);

        //----------------
        // Back support
        //----------------
        back(46) right(2) cuboid([ 50, 2, 2 ], rounding = 1,
                                 edges = [ TOP + FRONT, TOP + BACK, BACK + TOP + LEFT, BACK + TOP + RIGHT ],
                                 anchor = FRONT + RIGHT + BOTTOM);
    }
}

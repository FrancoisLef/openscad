include <BOSL2/std.scad>

include <enocean.scad>
include <microlab.scad>
include <sonoff.scad>
include <ssd.scad>

module sonoff_support()
{
    right(28)
        cuboid([ 1, SONOFF_BODY_LENGTH + 3, 5 ], rounding = 1, edges = [BACK + RIGHT], anchor = LEFT + BOTTOM + FRONT)
        // Left turn
        position(BACK + LEFT + TOP)
            cuboid([ SONOFF_BODY_WIDTH, 1, 5 ], rounding = 1, edges = [TOP + LEFT], anchor = BACK + RIGHT + TOP);
}

microlab_plate(60)
{
    diff("minus")
    {
        position(BOTTOM + FRONT) microlab_panel(length = 70);

        // SONOFF ZIGBEE DONGLE
        position(TOP + FRONT + LEFT) fwd(.9) up(get_slop()) right(2 + get_slop())
        {
            // right support
            right(26) cuboid([ 2, 55, 2 ], rounding = 1, edges = [ TOP + RIGHT, BACK + RIGHT, BACK + TOP ],
                             anchor = FRONT + LEFT + BOTTOM);
            // back support
            back(53)
                cuboid([ 26, 2, 2 ], rounding = 1, edges = [ TOP + FRONT, TOP + BACK ], anchor = FRONT + LEFT + BOTTOM);
            tag("minus") sonoff_zigbee_3_0_dongle();
        }

        // SSD M.2 2230
        position(TOP + RIGHT + FRONT) up(get_slop()) left(2 + 29 + get_slop())
        {
            // right support
            cuboid([ 2, 46, 10 ], anchor = FRONT + LEFT + BOTTOM, rounding = 5, edges = [BACK + TOP]);
            // left support
            left(46) cuboid([ 2, 46, 10 ], anchor = FRONT + RIGHT + BOTTOM, rounding = 5, edges = [BACK + TOP]);
            // back support
            back(46) right(2) cuboid([ 50, 2, 2 ], rounding = 1,
                                     edges = [ TOP + FRONT, TOP + BACK, BACK + TOP + LEFT, BACK + TOP + RIGHT ],
                                     anchor = FRONT + RIGHT + BOTTOM);
            tag("minus") xrot(180) ssd_2230(anchor = TOP + RIGHT + BACK);
        }

        // ENOCEAN TCM310
        position(TOP + FRONT + RIGHT) fwd(.9) up(get_slop()) left(2 + get_slop())
        {
            // left support
            left(23) cuboid([ 2, 51, 2 ], rounding = 1, edges = [LEFT + TOP], anchor = FRONT + RIGHT + BOTTOM);
            // back support
            back(51) cuboid([ 25, 2, 2 ], rounding = 1, edges = [ TOP + BACK, TOP + BACK + LEFT ],
                            anchor = FRONT + RIGHT + BOTTOM);
            tag("minus") enocean_tcm_310(anchor = FRONT + RIGHT + BOTTOM);
        }
    }
}

include <BOSL2/std.scad>

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

microlab_plate(70)
{
    diff()
    {
        position(BOTTOM + FRONT) microlab_panel(length = 70);
        position(TOP + FRONT + LEFT) tag("sonoff") fwd(get_slop()) up(get_slop()) right(2 + get_slop())
            sonoff_zigbee_3_0_dongle();
    }

    position(TOP + RIGHT + FRONT) ssd_2230(anchor = BOTTOM + RIGHT + FRONT);
}

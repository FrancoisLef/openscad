include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <constants.scad>

module citronhaj_container(anchor = [ 0, 0, 0 ])
{
    WIDTH = 42;
    HEIGHT = 82;

    LID_WIDTH = 37;
    LID_HEIGHT = 10;

    color_this("snow") cyl(h = HEIGHT, d = WIDTH, rounding1 = 2, rounding2 = 4, anchor = anchor)
    {
        color_this("silver") position(TOP) cyl(h = LID_HEIGHT, d = LID_WIDTH, anchor = BOTTOM);
    }
}

module citronhaj_box(anchor = [ 0, 0, 0 ])
{
    // Internal width of the drawer
    WIDTH = 85;
    // WIDTH = 87;
    // LENGTH = 450;
    LENGTH = 150;
    // HEIGHT = 250;
    HEIGHT = 50;

    color_this("red")
        rect_tube(size = [ WIDTH + 2, LENGTH + 2 ], isize = [ WIDTH, LENGTH ], h = HEIGHT, anchor = anchor)
    {
        children();
    }
}

citronhaj_box(anchor = BOTTOM + LEFT + FRONT)
{
    position(BOTTOM + LEFT + FRONT) right(2) back(23)
    {
        citronhaj_container(anchor = BOTTOM + LEFT);
        right(43) citronhaj_container(anchor = BOTTOM + LEFT);

        back(45)
        {
            citronhaj_container(anchor = BOTTOM + LEFT);
            right(43) citronhaj_container(anchor = BOTTOM + LEFT);
        }

        back(45 * 2)
        {
            citronhaj_container(anchor = BOTTOM + LEFT);
            right(43) citronhaj_container(anchor = BOTTOM + LEFT);
        }
    }
}

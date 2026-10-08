include <BOSL/constants.scad>
use <BOSL/shapes.scad>

shovel_length = 80;
shovel_height = 50;
shovel_width = 50;
shovel_thickness = 3;

handle_length = 70;
handle_width = 50;
handle_thickness = 10;

hole_width = 15;
hole_height = (handle_length + shovel_height + shovel_thickness) - hole_width - 10;

color("yellow")
    cuboid([shovel_length, shovel_width, shovel_thickness], p1=[0, 0, 0]);

color("yellow")
    translate([0, 0, shovel_thickness])
        right_triangle([shovel_length, shovel_thickness, shovel_height]);

color("yellow")
    translate([0, shovel_width - shovel_thickness, shovel_thickness])
        right_triangle(
            [shovel_length, shovel_thickness, shovel_height]
        );

color("yellow")
    translate([shovel_length, 0, 0])
        right_triangle(
            [shovel_thickness, shovel_width, shovel_thickness]
        );

color("yellow")
    translate([-handle_thickness, 0, 0])
        cuboid(
            [handle_thickness, shovel_width, shovel_height + shovel_thickness],
            p1=[0, 0, 0],
            fillet=3,
            trimcorners=false,
            edges=
            EDGE_FR_LF+
            EDGE_BK_LF+
            EDGE_BOT_LF
        );

difference() {
    color("yellow")
        translate([-handle_thickness, 0, shovel_height + shovel_thickness])
            cuboid(
                [handle_thickness, handle_width, handle_length],
                p1=[0, 0, 0],
                fillet=3,
                trimcorners=false,
                edges=
                EDGES_Z_ALL+
                EDGE_TOP_RT+
                EDGE_TOP_LF+
                EDGE_TOP_FR+
                EDGE_TOP_BK
            );

    color("black")
        translate([0, shovel_width / 2, hole_height])
            rotate(a=[0, 0, 90]) {
                teardrop(r=hole_width, h=handle_thickness*3, ang=50, cap_h=10);
            }
}


include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

pcb_z = 1.5; // PCB thickness

//----------------------------------------
// Screen control sub-modules (model A)
//----------------------------------------
module screen_control_a_pcb () {
  interf = 0.2;

  color("green") difference() {
    cuboid([ 75, 16.5, pcb_z ], align = V_ALLPOS);

    // Screw holes
    back(3) down(interf / 2) {
      right(14) cyl(l = pcb_z + interf, d = 3.6, $fn = 360, align = V_ALLPOS);
      right(59) cyl(l = pcb_z + interf, d = 3.6, $fn = 360, align = V_ALLPOS);
    }
  }
}

module screen_control_a_connector () {
  color("white") right(11.5) back(11.5) cuboid([ 22, 6.5, 5 ], align = V_ALLPOS);
}

module screen_control_a_button () {
  color("black") cuboid([ 6, 6, 3.4 ], align = V_ALLPOS);
  color("silver") up(3.4) cuboid([ 6, 6, 0.1 ], align = V_ALLPOS);
  color("black") up(3.5) right(1.25) back(1.25) cyl(l = 1, d = 3.5, $fn = 360, align = V_ALLPOS);
}

module screen_control_a_buttons () {
  back(1.5) {
    right(3) screen_control_a_button();
    right(20.5) screen_control_a_button();
    right(33.5) screen_control_a_button();
    right(49.5) screen_control_a_button();
    right(67) screen_control_a_button();
  }
}

//----------------------------------------
// Screen control assembly (model A)
//----------------------------------------
module screen_control_a () {
  screen_control_a_pcb();
  up(pcb_z) {
    screen_control_a_connector();
    screen_control_a_buttons();
  }
}

//----------------------------------------
// Screen control sub-modules (model B)
//----------------------------------------
module screen_control_b_pcb () {
  interf = 0.2;

  color("darkslategray") difference() {
    cuboid([ 76, 16, pcb_z ], align = V_ALLPOS);

    // Screw holes
    back(3) down(interf / 2) {
      right(14) cyl(l = pcb_z + interf, d = 4, $fn = 360, align = V_ALLPOS);
      right(59) cyl(l = pcb_z + interf, d = 4, $fn = 360, align = V_ALLPOS);
    }
  }
}

module screen_control_b_connector () {
  color("white") right(43) back(12) cuboid([ 22, 6.5, 5 ], align = V_ALLPOS);
}

module screen_control_b_button () {
  color("black") cuboid([ 6, 6, 3.4 ], align = V_ALLPOS);
  color("silver") up(3.4) cuboid([ 6, 6, 0.1 ], align = V_ALLPOS);
  color("black") up(3.5) right(1.25) back(1.25) cyl(l = 10, d = 3.5, $fn = 360, align = V_ALLPOS);
}

module screen_control_b_buttons () {
  back(1.5) {
    right(3) screen_control_b_button();
    right(22) screen_control_b_button();
    right(37) screen_control_b_button();
    right(50) screen_control_b_button();
    right(67.5) screen_control_b_button();
  }
}

//----------------------------------------
// Screen control assembly (model B)
//----------------------------------------
module screen_control_b () {
  screen_control_b_pcb();
  down(5) screen_control_b_connector();
  up(pcb_z) screen_control_b_buttons();
}

back(50) screen_control_a();
screen_control_b();

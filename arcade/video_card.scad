include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

interf = 0.2;
pcb_z = 1.5; // PCB thickness

//----------------------------------------
// Video card sub-modules
//----------------------------------------
module video_card_pcb () {
  color("green") difference() {
    cuboid([ 90.5, 65.5, pcb_z ], align = V_ALLPOS);

    // Holes
    down(interf / 2) {
      back(1) right(1) video_card_pcb_hole(); // Bottom left
      right(78) video_card_pcb_hole(); // Bottom right
      back(61) right(1.5) video_card_pcb_hole(); // Top left
      back(60.5) right(87.5) video_card_pcb_hole(); // Top right
    }
  }
}

module video_card_pcb_hole () {
  cyl(l = pcb_z + interf, d = 3, $fn = 360, align = V_ALLPOS);
}

module video_card_screen () {
  color("white") right(20.5) cuboid([ 28.5, 5, 2.2 ], align = V_ALLPOS);
}

module video_card_screen_control () {
  color("white") right(3) back(11) cuboid([ 5, 22, 6.5 ], align = V_ALLPOS);
}

module video_card_screen_power () {
  color("beige") right(73) back(3.7) cuboid([ 11, 8, 3.8 ], align = V_ALLPOS);
}

module video_card_power () {
  color("black") right(78.5) back(54) cuboid([ 9, 13.4, 11 ], align = V_ALLPOS);
}

module video_card_hdmi () {
  color("gold") right(52) back(55.5) cuboid([ 15, 11, 6 ], align = V_ALLPOS);
}

module video_card_vga () {
  color("blue") right(18) back(51.5) cuboid([ 31, 15, 12.5 ], align = V_ALLPOS);
}

//----------------------------------------
// Video card assembly
//----------------------------------------
module video_card () {
  video_card_pcb();

  up(pcb_z) {
    video_card_screen();
    video_card_screen_control();
    video_card_screen_power();
    video_card_power();
    video_card_hdmi();
    video_card_vga();
  }
}

video_card();

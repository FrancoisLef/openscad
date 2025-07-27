include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

interf = 0.2;
pcb_z = 1.3; // PCB thickness

//----------------------------------------
// Audio card sub-modules
//----------------------------------------
module audio_card_pcb () {
  color("red") difference() {
    cuboid([ 40, 40, pcb_z ], align = V_ALLPOS);

    // Holes
    down(interf / 2) {
      back(3) right(1) audio_card_pcb_hole(); // Bottom left
      back(3) right(36) audio_card_pcb_hole(); // Bottom right
      back(27) right(1) audio_card_pcb_hole(); // Top left
      back(24) right(36) audio_card_pcb_hole(); // Top right
    }
  }
}

module audio_card_pcb_hole () {
  cyl(l = pcb_z + interf, d = 3, $fn = 360, align = V_ALLPOS);
}

module audio_card_power () {
  color("black") right(23) back(26) cuboid([ 9, 14, 11 ], align = V_ALLPOS);
}

module audio_card_speaker () {
  color("lightgreen") right(2) back(31) cuboid([ 20.5, 8, 10 ], align = V_ALLPOS);
}

module audio_card_jack () {
  color("black") right(33) back(28) cuboid([ 6, 14, 5 ], align = V_ALLPOS);
}

module audio_card_capacitor () {
  color("silver") right(22) back(7.5) cyl(
    l = 27,
    d = 16,
    $fn = 360,
    align = V_ALLPOS
  );
}

module audio_card_potentiometer () {
  right(6) {
    color("green") cuboid(
      [ 10, 9.5, 11.5 ],
      align = V_ALLPOS
    );

    color("silver") right(10 / 2 - 7 / 2) up(3) xrot(90) cyl(
      l = 15,
      d = 7,
      $fn = 360,
      align = V_ALLPOS
    );
  }
}

//----------------------------------------
// Audio card assembly
//----------------------------------------
module audio_card () {
  audio_card_pcb();

  up(pcb_z) {
    audio_card_power();
    audio_card_speaker();
    audio_card_jack();
    audio_card_capacitor();
    audio_card_potentiometer();
  }
}

audio_card();

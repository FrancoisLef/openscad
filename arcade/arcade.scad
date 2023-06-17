include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

use <rpi4_b.scad>;
use <screen.scad>;
use <screen_control.scad>;
use <video_card.scad>;
use <audio_card.scad>;
use <power_socket.scad>;
use <power_supply.scad>;
use <speaker.scad>;

rpi4_b();
right(0) back(120) audio_card();
right(0) back(170) speaker();
right(0) back(240) speaker();
right(70) screen();
right(70) back(150) screen_control_b();
right(70) back(180) screen_control_a();
right(215) back(150) video_card();
right(310) power_socket();
right(310) back(50) power_supply();

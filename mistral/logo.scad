include <BOSL2/std.scad>
include <constants.scad>

$size=20;
$thick=1;

module mistral_logo_red(thick) {
  color("red") {
    cuboid([$size, $size, $thick]);
    right($size) cuboid([$size, $size, $thick]);
    right($size * 2) cuboid([$size, $size, $thick]);

    right($size * 4) cuboid([$size, $size, $thick]);
    right($size * 5) cuboid([$size, $size, $thick]);
    right($size * 6) cuboid([$size, $size, $thick]);
  }
}

module mistral_logo_dark_orange(thick) {
  color("orangered") {
    cuboid([$size, $size, $thick]);
    right($size * 2) cuboid([$size, $size, $thick]);
    right($size * 4) cuboid([$size, $size, $thick]);
  }
}

module mistral_logo_orange(thick) {
  color("DarkOrange") {
    cuboid([$size, $size, $thick]);
    right($size) cuboid([$size, $size, $thick]);
    right($size * 2) cuboid([$size, $size, $thick]);
    right($size * 3) cuboid([$size, $size, $thick]);
    right($size * 4) cuboid([$size, $size, $thick]);
  }
}

module mistral_logo_light_orange(thick) {
  color("orange") {
    cuboid([$size, $size, $thick]);
    right($size) cuboid([$size, $size, $thick]);

    right($size * 3) cuboid([$size, $size, $thick]);
    right($size * 4) cuboid([$size, $size, $thick]);
  }
}

module mistral_logo_yellow(thick) {
  cuboid([$size, $size, $thick]);
  right($size * 4) cuboid([$size, $size, $thick]);
}

union() {
  mistral_logo_red($thick);
  right($size) back($size) mistral_logo_dark_orange($thick);
  right($size) back($size * 2) mistral_logo_orange($thick);
  right($size) back($size * 3) mistral_logo_light_orange($thick);
  color("yellow") right($size) back($size * 4) mistral_logo_yellow($thick);
}


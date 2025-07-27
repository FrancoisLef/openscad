include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

//----------------------------------------
// Speaker sub-modules
//----------------------------------------
module speaker_core () {
  color("silver") right(68 / 2 - 44.5 / 2) back(68 / 2 - 44.5 / 2) cyl(
    l = 12,
    d = 44.5,
    $fn = 360,
    align = V_ALLPOS
  );
}

module speaker_face_holes () {
  back(68 / 2 - 4.5 / 2) right(1.5) down(0.1) cyl(
    l = 20,
    d = 4.5,
    $fn = 360,
    align = V_ALLPOS
  );

  back(68 / 2 - 4.5 / 2) right(61.5) down(0.1) cyl(
    l = 20,
    d = 4.5,
    $fn = 360,
    align = V_ALLPOS
  );
}

module speaker_face () {
  difference() {
    color("goldenrod") difference() {
      cyl(
        l = 18.5,
        d1 = 68,
        d2 = 44.5,
        $fn = 360,
        align = V_ALLPOS
      );

      speaker_face_holes();
    }

    color("black") right(68 / 2 - 50 / 2) back(68 / 2 - 50 / 2) down(0.1) cyl(
      l = 2,
      d = 50,
      $fn = 360,
      align = V_ALLPOS
    );
  }
}

//----------------------------------------
// Speaker assembly
//----------------------------------------
module speaker () {
  speaker_face();
  up(18.5) speaker_core();
}

speaker();

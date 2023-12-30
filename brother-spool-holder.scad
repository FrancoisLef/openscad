include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

// Tolérance pour les ajustements
tolerance = .5;
diff_tolerance = .1;

// Diamètre du pin
brother_pin_diameter = 4.5 + tolerance;
// Hauteur du pin quand il est ouvert
brother_pin_height = 52 + tolerance;
// Hauteur du pin quand il est fermé
brother_pin_height_closed = 11.5 + tolerance;
// Diamètre de la base du pin
brother_pin_base_diameter = 14 + tolerance;
// Hauteur de la base du pin
brother_pin_base_height = 1.5;

// Espace entre le pin et le dévidoir à canette
// Le socle ne doit pas dépasser ce rayon pour ne pas gêner le dévidoir
brother_socle_max_radius = 40;

// Diamètre du socle
socle_diameter = 60;
// Epaisseur du socle
socle_thickness = 2;

// Diamètre du support (diamètre intérieur d'une bobine au plus large)
support_diameter_start = 35 - tolerance;
// Diamètre du support (diamètre intérieur d'une bobine au plus étroit)
support_diameter_end = 30 - tolerance;
// Hauteur du support
support_height = 65 - tolerance;

module pin(opened = true) {
  color("red") {
    cyl(
      h = brother_pin_base_height,
      d = brother_pin_base_diameter,
      orient=ORIENT_Z,
      align=ALIGN_POS
    );

    up(brother_pin_base_height - diff_tolerance) {
      cyl(
        h = opened ? brother_pin_height : brother_pin_height_closed,
        d = brother_pin_diameter,
        fillet2 = .5,
        orient=ORIENT_Z,
        align=ALIGN_POS
      );
    }
  }
}

module support() {
  color("yellow") {
    cyl(
      h = socle_thickness,
      d = socle_diameter,
      orient=ORIENT_Z,
      align=ALIGN_POS
    );

    cyl(
      h = support_height,
      d1 = support_diameter_start,
      d2 = support_diameter_end,
      fillet2 = 5,
      orient=ORIENT_Z,
      align=ALIGN_POS
    );
  }
}

difference() {
  support();
  down(diff_tolerance) pin(opened = true);
}

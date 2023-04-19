include <BOSL/constants.scad>
use <BOSL/shapes.scad>

// Définir les dimensions de la base
base_width = 50;   // 50 mm
base_length = 25;  // 25 mm
base_height = 50;  // 45 mm

// Définir les dimensions des rectangles
rect_width = 16;   // 16 mm
rect_length = 16;  // 16 mm
rect_height = 16;  // 16 mm

// Définir l'espacement entre les rectangles
rect_spacing = 4;  // 4 mm

module grid_base() {
  cuboid([
   base_width,
    base_length,
    base_height
  ], align=V_ALLPOS);
}

module grid_pin() {
  cuboid([
    rect_width,
    rect_length,
    rect_height
  ], chamfer=5, align=V_ALLPOS, edges=EDGES_TOP);
}

// Créer la base rectangulaire
translate([
  -base_width/2,
  -base_length/2,
  0
]) {
  grid_base();
}

// Créer le premier rectangle centré sur la face supérieure de la base
translate([
  -rect_width - rect_spacing/2,
  -rect_length/2,
  base_height,
]) {
  grid_pin();
};

// Créer le deuxième rectangle centré sur la face supérieure de la base
translate([
  rect_spacing/2,
  -rect_length/2,
  base_height,
]) {
  grid_pin();
};

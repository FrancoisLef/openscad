include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

// Cache lumières
tube(
  h=30, // Hauteur du tube
  id=105, // Diametre interne du tube
  wall=5 // Épaisseur du tube
);

// Lèvre de maintien
up(30) tube(
  h=5, // Hauteur du tube
  id=95, // Diametre interne du tube
  wall=10 // Épaisseur du tube
);

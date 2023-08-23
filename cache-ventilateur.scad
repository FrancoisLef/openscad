include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

// Lèvre de maintien
color("red") up(12) tube(
  h=3, // Hauteur du tube
  id=90, // Diametre interne du tube
  wall=8 // Épaisseur du tube
);

difference() {
  // Cache lumières
  color("blue") tube(
    h=12, // Hauteur du tube
    id=100, // Diametre interne du tube
    wall=3 // Épaisseur du tube
  );

  color("green") down(.1) pie_slice(
    ang=45,
    d=110,
    h=10
  );
}

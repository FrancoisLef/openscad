include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

hauteur = 45;
largeur = 70;
profondeur = 15;
epaisseur = 2;

jeu = 1;
interf = 0.1;
center = [0,0,0];

module cave() {
  color("grey") cuboid(
    [
      largeur + interf * 2,
      profondeur,
      hauteur + jeu
    ],
    p1=center
  );
}

module cache() {
  color("yellow") cuboid(
    [
      largeur,
      profondeur,
      hauteur + epaisseur * 2
    ],
    p1=center
  );
}

difference() {
  cache();
  back(epaisseur) up(epaisseur - jeu / 2) left(interf) cave();
}

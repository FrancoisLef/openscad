include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

largeur = 118;
hauteur = 10;
profondeur = 45;
retour = 5;
epaisseur = 2;
center = [0,0,0];

module chargeur() {
  color("grey") cuboid(
    [
      largeur,
      profondeur,
      hauteur
    ],
    p1=center
  );
}

module cache() {
  color("red") cuboid(
    [
      largeur + epaisseur * 2,
      profondeur + epaisseur,
      hauteur + epaisseur
    ],
    p1=center
  );
}

module retours() {
  // Retour gauche
  color("red") cuboid(
    [
      retour,
      epaisseur,
      hauteur
    ],
    p1=center
  );

  // Retour droit
  color("red") cuboid(
    [
      retour,
      epaisseur,
      hauteur
    ],
    p1=[largeur - retour + epaisseur,0,0]
  );
}

difference() {
  // Cache
  back(0.1) up(0.1) cache();

  // Chargeur de batterie
  right(epaisseur) chargeur();
}

back(0.1) up(0.1) color("yellow") retours();


include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

// Print settings
tolerance = .1;

// Plaque de base
x_plaque = 60; // largeur de la plaque
y_plaque = 35; // longueur de la plaque
z_plaque = 2.5; // épaisseur de la plaque

// Ailette
x_ailette = 3; // largeur de l'ailette
y_ailette = 33; // longueur de l'ailette
z_ailette = 5; // épaisseur de l'ailette

// Ergot inférieur
x_ergot_inf = 5; // largeur de l'ergot inférieur
y_ergot_inf = 6; // longueur de l'ergot inférieur
z_ergot_inf = 2; // épaisseur de l'ergot inférieur
gap_ergot_inf = 11.5; // espacement entre les ergots inférieurs

// Ergot supérieur
x_ergot_sup = 11; // largeur de l'ergot supérieur
y_ergot_sup = 8.5; // longueur de l'ergot supérieur
z_ergot_sup = 4.5; // épaisseur de l'ergot supérieur
link_ergot_sup = 2.5; // longueur du lien entre l'ergot supérieur et la plaque

// Bowl
x_bowl = 43; // largeur du bol
y_bowl = 37; // longueur du bol
z_bowl = 5; // épaisseur du bol

// Butée
x_butee = x_bowl; // largeur de la butée
y_butee = 12; // longueur de la butée
z_butee = 4; // épaisseur de la butée

trappe_ski();

module trappe_ski() {
  color("red") {
    cuboid(
      [
        x_plaque,
        y_plaque,
        z_plaque
      ],
      align=V_ALLPOS
    );
  }

  // Ailettes
  color("yellow") back((y_plaque - y_ailette) / 2) {
    // Gauche
    up(z_plaque) plaque_ailette();

    // Droite
    right(x_plaque - x_ailette) up(z_plaque) plaque_ailette();
  }

  // Ergots inférieurs
  color("green") forward(y_ergot_inf) right((x_plaque / 2) - (x_ergot_sup / 2) - x_ergot_inf) {
    // Gauche
    plaque_ergot_inferieur();

    // Droite
    right(x_ergot_inf + x_ergot_sup) plaque_ergot_inferieur();
  }

  // Ergot supérieur
  color("orange") up(z_plaque) forward(y_ergot_sup - link_ergot_sup) {
    right((x_plaque / 2) - (x_ergot_sup / 2)) plaque_ergot_superieur();
  }

  // Bowl
  right((x_plaque / 2) - (x_bowl /2)) back(12.5) {
    plaque_bowl();
  }
}

module plaque_bowl() {
  thickness_hole = 3;
  x_hole = x_bowl - thickness_hole * 2;
  y_hole = y_bowl - thickness_hole * 2;
  z_hole = thickness_hole / 2;

  difference() {
    // Base
    cuboid(
      [
        x_bowl,
        y_bowl,
        z_bowl
      ],
      chamfer=2.5,
      fillet=1,
      edges=EDGE_BOT_BK,
      align=V_ALLPOS
    );

    // Vide
    right(thickness_hole) back(thickness_hole) up(z_bowl + tolerance - z_hole) cuboid(
      [
        x_hole,
        y_hole,
        z_hole
      ],
      fillet=.5,
      align=V_ALLPOS
    );
  }

  up(z_bowl) cuboid(
    [
      x_butee,
      y_butee,
      z_butee
    ],
    align=V_ALLPOS
  );
}

module plaque_ergot_superieur() {
  difference() {
    // Ergot
    cuboid(
      [
        x_ergot_sup,
        y_ergot_sup,
        z_ergot_sup
      ],
      fillet=.2,
      edges=EDGES_TOP,
      align=V_ALLPOS
    );

    // Vide
    left(tolerance) forward(tolerance) down(tolerance) cuboid(
      [
        x_ergot_sup +  tolerance * 2,
        y_ergot_sup - link_ergot_sup + tolerance * 2,
        2 + tolerance
      ],
      align=V_ALLPOS
    );
  }
}

module plaque_ergot_inferieur() {
  cuboid(
    [
      x_ergot_inf,
      y_ergot_inf,
      z_ergot_inf
    ],
    chamfer=.2,
    edges=
      EDGE_TOP_LF+ // Top left
      EDGE_TOP_RT+ // Top right
      EDGE_TOP_FR+ // Front top
      EDGE_FR_LF+ // Front left
      EDGE_FR_RT, // Front right
    align=V_ALLPOS
  );
}

module plaque_ailette() {
  cuboid(
    [
      x_ailette,
      y_ailette,
      z_ailette
    ],
    fillet=.5,
    edges=EDGES_TOP,
    align=V_ALLPOS
  );
}

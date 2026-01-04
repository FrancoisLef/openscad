include <BOSL2/std.scad>
include <constants.scad>
include <dewalt.scad>

module makita_circulaire() {
  // Valeur partagée
  __transition    = 5;

  down(__transition)
  dewalt(rounding = 0, anchor = TOP);

  // Tube
  __height  = 30;
  __inner_d = 31 + $tolerance;
  __outer_d = __inner_d + 6;

  // 1. Créer une transition entre le tube DEWALT et le tube MAKITA
  down(__transition)
  tube(
    h = __transition,
    // Diametre externe bas
    od1 = __dewalt_outer_d,
    // Diametre externe haut
    od2 = __outer_d,
    // Diametre interne bas
    id1 = __dewalt_inner_d,
    // Diametre interne haut
    id2 = __inner_d,
    anchor = BOTTOM
  );

  // 2. Construire le corps du tube principal
  tube(
    h = __height,
    // Diametre externe
    od = __outer_d,
    // Diametre interne
    id = __inner_d,
    // Arrondi du haut
    orounding2 = 2,
    anchor = BOTTOM
  );
}

makita_circulaire();

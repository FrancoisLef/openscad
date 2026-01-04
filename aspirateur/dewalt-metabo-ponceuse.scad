include <BOSL2/std.scad>
include <constants.scad>
include <dewalt.scad>

module metabo_ponceuse() {
  // Valeur partagée
  __transition    = 5;

  down(__transition)
  dewalt(rounding = 0, anchor = TOP);

  // Tube
  __height  = 30;
  __inner_d = 29 + $tolerance;
  __outer_d = __inner_d + 6;

  // Rainure
  __rainure_depth  = 4 + $tolerance;
  __rainure_height = 3 + $tolerance;
  __rainure_width  = 11 + $tolerance;

  // 1. Créer une transition entre le tube DEWALT et le tube METABO
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
  diff()
  tube(
    h = __height,
    // Diametre externe
    od = __outer_d,
    // Diametre interne
    id = __inner_d,
    // Arrondi du haut
    orounding2 = 2,
    anchor = BOTTOM
  ) {
    // 3. Créer une rainure interne pour sécuriser le tube à la METABO
    tag("remove")
    position(TOP)
    down(5)
    tube(
      h = __rainure_height + __rainure_depth * 2,
      od = __inner_d +  __rainure_depth,
      id = __inner_d - __rainure_depth * 2,
      chamfer = __rainure_depth,
      anchor = TOP
    );

    // 4. Créer une rainure verticale pour laisser passer le pin
    tag("remove")
    position(TOP + LEFT)
    up(1)
    right(1.5)
    cuboid(
      [
        __rainure_width,
        __rainure_width,
        __rainure_height + 8
      ],
      rounding = .1,
      anchor = TOP + LEFT
    );
  }
}

metabo_ponceuse();

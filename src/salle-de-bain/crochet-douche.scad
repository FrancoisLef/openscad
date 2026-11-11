include <BOSL2/std.scad>
include <../_lib/print-settings.scad>

largeur = 8 * 3;
epaisseur = 4;

epaisseur_paroi = 19.5;
longueur_crochet = 60;
extension_crochet = 8;

module crochet() {
  // Dessus
  cuboid(
    [
      epaisseur_paroi,
      largeur,
      epaisseur
    ],
    anchor = BOTTOM + LEFT
  );

  // Tige crochet
  up(epaisseur)
  right(epaisseur_paroi)
  cuboid(
    [
      epaisseur,
      largeur,
      longueur_crochet + epaisseur
    ],
    rounding = epaisseur,
    edges = [TOP + RIGHT],
    anchor = TOP + LEFT
  );

  // Crochet
  largeur_crochet = largeur;

  down(longueur_crochet)
  right(epaisseur_paroi)
  half_of(DOWN)
  tube(
    h = largeur,
    id = largeur_crochet,
    wall = epaisseur,
    orient = FWD,
    anchor = LEFT
  );

  // Extension crochet
  right(epaisseur_paroi + largeur_crochet + epaisseur)
  down(longueur_crochet - extension_crochet)
  cuboid(
    [
      epaisseur,
      largeur,
      extension_crochet
    ],
    rounding = min(epaisseur / 2, extension_crochet / 2),
    edges = [TOP + LEFT, TOP + RIGHT],
    anchor = TOP + LEFT
  );

  // Retour porte
  up(epaisseur)
  cuboid(
    [
      epaisseur,
      largeur,
      epaisseur + 12
    ],
    rounding = epaisseur,
    edges = [TOP + LEFT],
    anchor = TOP + RIGHT
  );

  // Clip de fixation
  down(12)
  left(epaisseur)
  cuboid(
    [
      epaisseur + 5,
      largeur,
      epaisseur
    ],
    rounding = epaisseur,
    edges = [BOTTOM + LEFT],
    anchor = TOP + LEFT
  );
}

crochet();

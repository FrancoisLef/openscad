include <BOSL2/std.scad>
include <constants.scad>

// ------------------------------------------------------------------------
// DEWALT DCV584L portable vacuum
// ------------------------------------------------------------------------
//
// Usage examples:
//
// dewalt();
// dewalt(rounding = 0);
// dewalt(rounding = 0, anchor = BOTTOM);
// ------------------------------------------------------------------------

__dewalt_outer_d = 42;
__dewalt_inner_d = 35;

module dewalt(
  rounding = 2,
  anchor = [0, 0, 0]
) {
  // Tube
  __height        = 35;

  // Rainure
  __groove_depth  = 2;
  __groove_height = 6;

  // Levre
  __levre_depth  = 1;
  __levre_height = 3;

  diff() {
    // 1. Créer le tube principal
    tube(
      h = __height,
      // Diametre externe
      od = __dewalt_outer_d,
      // Diametre interne
      id = __dewalt_inner_d,
      // Arrondi du bas
      orounding1 = 2,
      // Arrondi du haut
      orounding2 = rounding,
      anchor = anchor
    ) {
      // 2. Creuser le tube pour pouvoir créer une rainure
      tag("remove")
      position(BOTTOM)
      up(15)
      tube(
        h  = __groove_height,
        od = __dewalt_outer_d + get_slop(),
        id = __dewalt_inner_d - get_slop(),
        anchor = BOTTOM
      );

      // 3. Ajouter une tranche de tube avec un chamfer
      tag("keep")
      position(BOTTOM)
      up(15)
      tube(
        h  = __groove_height,
        od = __dewalt_outer_d - (__groove_depth * 2),
        id = __dewalt_inner_d,
        ochamfer = - __groove_depth,
        anchor   = BOTTOM
      );

      // 4. Ajouter une lèvre d'étanchéité en bas
      tag("keep")
      position(BOTTOM)
      up(12)
      tube(
        h = __levre_height,
        od = __dewalt_outer_d + __levre_depth,
        id = __dewalt_inner_d + get_slop(),
        chamfer = 1,
        anchor  = BOTTOM
      );

      // 5. Ajouter une lèvre d'étanchéité en haut
      tag("keep")
      position(BOTTOM)
      up(30)
      tube(
        h = __levre_height,
        od = __dewalt_outer_d + __levre_depth,
        id = __dewalt_inner_d + get_slop(),
        chamfer = 1,
        anchor  = BOTTOM
      );
    }
  }
}

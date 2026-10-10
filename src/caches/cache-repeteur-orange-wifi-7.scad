/**
 * Cache-lumiere en U pour repeteur Wi-Fi 7 Orange.
 *
 * Orientation d'impression: la base du U est sur le plateau (Z=0),
 * les deux parois se construisent verticalement. Le repeteur se glisse
 * ensuite dans l'ouverture echancree de 29 a 40 mm.
 *
 * Cette piece masque une source lumineuse sans enfermer le repeteur:
 * ses deux extremites restent ouvertes. Verifier que le cache ne couvre
 * aucune grille de ventilation avant impression.
 */

include <../_lib/print-settings.scad>

// Profil interieur voulu (mm): base resserree et sommet a 40 mm.
espace_base = 29;
espace_haut = 40;
hauteur_parois = 30;
profondeur_cache = 50;

// Epaisseur opaque adaptee a une buse de 0,4 mm (neuf lignes de paroi).
epaisseur_paroi = 3.6;
segments_arrondi = 16;

/**
 * Points d'un arc 2D dans le plan du profil [X, Z].
 */
function points_arc(centre, rayon, angle_debut, angle_fin, segments) = [
    for (i = [0 : segments])
        let(angle = angle_debut + (angle_fin - angle_debut) * i / segments)
            [centre[0] + rayon * cos(angle), centre[1] + rayon * sin(angle)]
];

// Supprime le premier point d'un arc deja raccorde au contour precedent.
function sans_premier(points) = [for (i = [1 : len(points) - 1]) points[i]];

/**
 * Profil d'un vrai U: l'ouverture passe doucement de espace_base a
 * espace_haut. Le rayon interieur est contraint par cette difference,
 * ce qui maintient exactement les deux mesures du repeteur.
 */
function profil_u(
    espace_bas,
    espace_sup,
    hauteur,
    epaisseur,
    segments
) =
    let(
        rayon_interieur = (espace_sup - espace_bas) / 2,
        rayon_exterieur = rayon_interieur + epaisseur,
        demi_base = espace_bas / 2,
        demi_haut_interieur = espace_sup / 2,
        demi_haut_exterieur = demi_haut_interieur + epaisseur,
        centre_droit = [demi_base, epaisseur + rayon_interieur],
        centre_gauche = [-demi_base, epaisseur + rayon_interieur]
    )
        concat(
            // Contour exterieur, de gauche a droite, puis vers le haut.
            [[-demi_base, 0], [demi_base, 0]],
            sans_premier(points_arc(centre_droit, rayon_exterieur, -90, 0, segments)),
            [[demi_haut_exterieur, hauteur], [demi_haut_interieur, hauteur]],

            // Contour interieur, du haut vers la base puis retour a gauche.
            [[demi_haut_interieur, epaisseur + rayon_interieur]],
            sans_premier(points_arc(centre_droit, rayon_interieur, 0, -90, segments)),
            [[-demi_base, epaisseur]],
            sans_premier(points_arc(centre_gauche, rayon_interieur, -90, -180, segments)),
            [[-demi_haut_interieur, hauteur], [-demi_haut_exterieur, hauteur]],
            sans_premier(points_arc(centre_gauche, rayon_exterieur, 180, 270, segments))
        );

/**
 * Retourne le cache en U ouvert au-dessus et aux deux extremites.
 *
 * espace_bas: ouverture libre au niveau de la base du repeteur.
 * espace_sup: ouverture libre au-dessus de la courbe.
 * hauteur: hauteur totale depuis le plateau jusqu'au sommet des parois.
 * profondeur: longueur du cache dans le sens du glissement.
 */
module cache_lumiere_u(
    espace_bas = espace_base,
    espace_sup = espace_haut,
    hauteur = hauteur_parois,
    profondeur = profondeur_cache,
    epaisseur = epaisseur_paroi,
    segments = segments_arrondi
) {
    rayon_interieur = (espace_sup - espace_bas) / 2;

    assert(espace_bas > 0, "L'espace a la base doit etre positif.");
    assert(espace_sup > espace_bas, "L'espace en haut doit etre plus grand que celui de la base.");
    assert(hauteur > epaisseur + rayon_interieur, "La hauteur est insuffisante pour la courbe de la base.");
    assert(profondeur > 0, "La profondeur du cache doit etre positive.");
    assert(epaisseur > 0, "L'epaisseur des parois doit etre positive.");
    assert(segments >= 4, "Utiliser au moins quatre segments pour chaque arrondi.");

    // Le profil [X, Z] est extrude dans l'axe de profondeur Y.
    rotate([90, 0, 0])
        linear_extrude(height = profondeur, center = true, convexity = 10)
            polygon(points = profil_u(espace_bas, espace_sup, hauteur, epaisseur, segments));
}

cache_lumiere_u();

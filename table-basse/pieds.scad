include <BOSL2/std.scad>
include <constants.scad>

diametre_externe = 38.5;
longueur_pied = 185;
tolerance = 0.5;
epaisseur = 2;

module pieds()
{
	tube(id = diametre_externe + tolerance, h = longueur_pied, wall = epaisseur, anchor = BOTTOM);

	difference()
	{
		half_of(DOWN) spheroid(d = diametre_externe + tolerance + epaisseur * 2);
		half_of(DOWN) spheroid(d = diametre_externe + tolerance + epaisseur * 2 - epaisseur);
	}
}

pieds();

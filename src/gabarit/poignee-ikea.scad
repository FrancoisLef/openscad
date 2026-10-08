include <BOSL2/std.scad>
include <../lib/print-settings.scad>

// BORGHAMN "40 mm" : 40 est la longueur, l'entraxe reel est 32 mm
entraxe = 32;
percage = 5;
// bord exterieur de la poignee a 30 mm, pied de poignee de 8 mm
bord = 30 + 8 / 2;

ep_plaque = 4;
ep_rebord = 4;
prof_rebord = 10;

largeur = bord + 22;
longueur = entraxe + 34;

module gabarit() {
    difference() {
        union() {
            cuboid([largeur, longueur, ep_plaque], anchor=BOTTOM + LEFT);
            down(prof_rebord)
                cuboid([ep_rebord, longueur, ep_plaque + prof_rebord],
                       anchor=BOTTOM + RIGHT);
        }
        ycopies(entraxe) {
            translate([bord, 0, ep_plaque - 1])
                cyl(d1 = percage + 4, d2 = percage, h = 1, anchor = BOTTOM);
            translate([bord, 0, -1])
                cyl(d = percage, h = ep_plaque + 2, anchor = BOTTOM);
        }
        translate([largeur / 2, 0, ep_plaque])
            xrot(45) cuboid([largeur + 2, 2.4, 2.4]);
    }
}

gabarit();

include <BOSL2/std.scad>
include <../_lib/print-settings.scad>

hauteur = 20;
largeur = 30;
longueur = 50;

print_width = 1;

goulotte_longueur = longueur + 20;
goulotte_largeur = 12;
goulotte_hauteur = 10;

module goulotte() {
  difference() {
    // Goulotte exterieure
    cuboid(
      [
        goulotte_longueur,
        goulotte_largeur,
        goulotte_hauteur
      ],
      anchor = BOTTOM,
      rounding = 2,
      edges = [TOP+FRONT, TOP+BACK]
    );

    // Goulotte interieur
    down($slop) cuboid(
      [
        goulotte_longueur + 2 * $slop,
        goulotte_largeur - 2 * print_width,
        goulotte_hauteur - print_width
      ],
      anchor = BOTTOM,
      rounding = 2,
      edges = [TOP+FRONT, TOP+BACK]
    );
  }
}

module cache() {
  difference() {
    // Boitier exterieur
    cuboid(
      [
        longueur,
        largeur,
        hauteur
      ],
      anchor = BOTTOM,
      rounding = 4,
      edges = [TOP, FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT]
    ) {
      position(BOTTOM) goulotte();
    }

    // Espace interieur
    down($slop) cuboid(
      [
        longueur - 2 * print_width,
        largeur - 2 * print_width,
        hauteur - print_width
      ],
      anchor = BOTTOM,
      rounding = 4,
      edges = [TOP, FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT]
    );

    down($slop) cuboid(
      [
        goulotte_longueur + 2 * $slop,
        goulotte_largeur - 2 * print_width,
        goulotte_hauteur - print_width
      ],
      anchor = BOTTOM,
      rounding = 2,
      edges = [TOP+FRONT, TOP+BACK]
    );
  }
}

cache();

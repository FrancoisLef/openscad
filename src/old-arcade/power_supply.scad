include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

interf = 0.1;

//----------------------------------------
// Power supply sub-modules
//----------------------------------------
module power_supply_core () {
  color("silver") difference() {
    cuboid(
      [ 98, 158.2, 39 ],
      align = V_ALLPOS
    );

    forward(interf) up(2) left(2) cuboid(
      [98, 15, 39],
      align = V_ALLPOS
    );
  }

  color("black") up(2) right(10) cuboid(
    [ 68, 15, 15 ],
    align = V_ALLPOS
  );
}

module power_supply_hole () {
  color("black") cyl(
    l = 3,
    d = 2.5,
    $fn = 360,
    align = V_ALLPOS
  );
}

module power_supply_holes () {
  // Front bottom left
  right(3) back(3) power_supply_hole();

  // Front bottom right
  right(91) back(3) power_supply_hole();

  // Front bottom middle
  right(62.5) back(23) power_supply_hole();

  // Back bottom middle
  right(64) back(101) power_supply_hole();

  // Back bottom left
  right(6) back(153.2) power_supply_hole();
}

//----------------------------------------
// Power supply assembly
//----------------------------------------
module power_supply () {
  difference() {
    power_supply_core();
    down(interf) power_supply_holes();
  }
}

power_supply();

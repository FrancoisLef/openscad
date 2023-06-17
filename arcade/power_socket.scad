include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

//----------------------------------------
// Power socket sub-modules
//----------------------------------------
module power_socket_core () {
  cuboid(
    [ 27.5, 24, 42 ],
    chamfer = 6.25,
    edges = EDGES_Y_TOP,
    align = V_ALLPOS
  );
}

module power_socket_side () {
  yrot(-90) difference() {
    prismoid(
      size1 = [ 58, 3 ],
      size2 = [ 0, 3 ],
      h = 11,
      align = V_ALLPOS
    );

    back(3.1) right(27) up(4) xrot(90) cyl(
      l = 3.2,
      d = 4,
      $fn = 360,
      align = V_ALLPOS
    );
  }

}

module power_socket_face () {
  power_socket_side();

  cuboid(
    [ 27.5, 3, 58 ],
    align = V_ALLPOS
  );

  right(27.5) xflip() power_socket_side();
}

//----------------------------------------
// Power socket assembly
//----------------------------------------
module power_socket () {
  color("black") right(11) {
    up(5) back(3) power_socket_core();
    power_socket_face();
  }
}

power_socket();

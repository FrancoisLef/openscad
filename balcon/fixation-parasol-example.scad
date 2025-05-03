// First cube with holes

difference()
{

    // Main cube 1

    translate([ 7.5, -20, -10 ]) cube([ 25, 20, 60 ]);

    // First wide cylinder hole (Z=0)

    translate([ 7.5, -10, 0 ]) rotate([ 0, 90, 0 ]) #cylinder(h = 4, r1 = 5, r2 = 5);

    // First narrow cylinder hole (inside the wide one)

    translate([ 7.5, -10, 0 ]) rotate([ 0, 90, 0 ]) cylinder(h = 40, r1 = 3, r2 = 3);

    // Second wide cylinder hole (Z=20)

    translate([ 7.5, -10, 20 ]) rotate([ 0, 90, 0 ]) cylinder(h = 4, r1 = 5, r2 = 5);

    // Second narrow cylinder hole (inside the wide one)

    translate([ 7.5, -10, 20 ]) rotate([ 0, 90, 0 ]) cylinder(h = 40, r1 = 3, r2 = 3);

    // Third wide cylinder hole (Z=40)

    translate([ 7.5, -10, 40 ]) rotate([ 0, 90, 0 ]) cylinder(h = 4, r1 = 5, r2 = 5);

    // Third narrow cylinder hole (inside the wide one)

    translate([ 7.5, -10, 40 ]) rotate([ 0, 90, 0 ]) cylinder(h = 40, r1 = 3, r2 = 3);

    // First hexagonal hole (Z=0)

    translate([ 32.5, -10, 0 ]) rotate([ 180, 90, 0 ]) linear_extrude(height = 5) circle(d = 8 / cos(30), $fn = 6);

    // Second hexagonal hole (Z=20)

    translate([ 32.5, -10, 20 ]) rotate([ 180, 90, 0 ]) linear_extrude(height = 5) circle(d = 8 / cos(30), $fn = 6);

    // Third hexagonal hole (Z=40)

    translate([ 32.5, -10, 40 ]) rotate([ 180, 90, 0 ]) linear_extrude(height = 5) circle(d = 8 / cos(30), $fn = 6);
}

// Second cube (at [10,40,0]) with identical holes

difference()
{

    // Main cube 2

    translate([ 7.5, 35, -10 ]) cube([ 25, 40, 60 ]);

    // First wide cylinder hole (Z=0)

    translate([ 7.5, 55, 0 ]) rotate([ 0, 90, 0 ]) cylinder(h = 4, r1 = 5, r2 = 5);

    // First narrow cylinder hole (inside the wide one)

    translate([ 7.5, 55, 0 ]) rotate([ 0, 90, 0 ]) cylinder(h = 40, r1 = 3, r2 = 3);

    // Second wide cylinder hole (Z=20)

    translate([ 7.5, 55, 20 ]) rotate([ 0, 90, 0 ]) cylinder(h = 4, r1 = 5, r2 = 5);

    // Second narrow cylinder hole (inside the wide one)

    translate([ 7.5, 55, 20 ]) rotate([ 0, 90, 0 ]) cylinder(h = 40, r1 = 3, r2 = 3);

    // Third wide cylinder hole (Z=40)

    translate([ 7.5, 55, 40 ]) rotate([ 0, 90, 0 ]) cylinder(h = 4, r1 = 5, r2 = 5);

    // Third narrow cylinder hole (inside the wide one)

    translate([ 7.5, 55, 40 ]) rotate([ 0, 90, 0 ]) cylinder(h = 40, r1 = 3, r2 = 3);

    // First hexagonal hole (Z=0)

    translate([ 32.5, 55, 0 ]) rotate([ 180, 90, 0 ]) linear_extrude(height = 5) circle(d = 8 / cos(30), $fn = 6);

    // Second hexagonal hole (Z=20)

    translate([ 32.5, 55, 20 ]) rotate([ 180, 90, 0 ]) linear_extrude(height = 5) circle(d = 8 / cos(30), $fn = 6);

    // Third hexagonal hole (Z=40)

    translate([ 32.5, 55, 40 ]) rotate([ 180, 90, 0 ]) linear_extrude(height = 5) circle(d = 8 / cos(30), $fn = 6);
}

// Third bracket with 2 hole sets instead of 3

difference()
{

    // Main cube 3

    // translate([10,10,-10]) cube([20,20,60]);

    translate([ 7.5, 115, -10 ]) cube([ 25, 20, 60 ]);

    // First wide cylinder hole (Z=10)

    translate([ 7.5, 125, 10 ]) rotate([ 0, 90, 0 ]) cylinder(h = 4, r1 = 5, r2 = 5);

    // First narrow cylinder hole (inside the wide one)

    translate([ 7.5, 125, 10 ]) rotate([ 0, 90, 0 ]) cylinder(h = 40, r1 = 3, r2 = 3);

    // Second wide cylinder hole (Z=30)

    translate([ 7.5, 125, 30 ]) rotate([ 0, 90, 0 ]) cylinder(h = 4, r1 = 5, r2 = 5);

    // Second narrow cylinder hole (inside the wide one)

    translate([ 7.5, 125, 30 ]) rotate([ 0, 90, 0 ]) cylinder(h = 40, r1 = 3, r2 = 3);

    // First hexagonal hole (Z=10)

    translate([ 32.5, 125, 10 ]) rotate([ 180, 90, 0 ]) linear_extrude(height = 5) circle(d = 8 / cos(30), $fn = 6);

    // Second hexagonal hole (Z=30)

    translate([ 32.5, 125, 30 ]) rotate([ 180, 90, 0 ]) linear_extrude(height = 5) circle(d = 8 / cos(30), $fn = 6);
}

// Round part

difference()
{

    translate([ 0, 0, -10 ]) cube([ 40, 40, 60 ], center = false);

    translate([ 5, 5, -50 ]) cube([ 30, 30, 100 ]);
}

difference()
{

    translate([ 20, 95, -10 ]) cylinder(60, 25, 25, $fn = 1000);

    translate([ 20, 95, -20 ]) cylinder(150, 16, 16, $fn = 1000);
}

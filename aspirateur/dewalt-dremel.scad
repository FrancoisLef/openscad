include <BOSL2/std.scad>
include <constants.scad>

$d_margin = 0.5;

// Small adapter
VACUUM_SM_INT = 25.5;
VACUUM_SM_EXT = 31;
VACUUM_SM_LENGTH = 31;

// Large adapter
VACUUM_LG_INT = 35;
VACUUM_LG_EXT = 42;
VACUUM_LG_LENGTH = 31;

// No adapter
VACUUM_XL_INT = 42.5;
VACUUM_XL_LENGTH = 34;

VACUUM_EXT = (VACUUM_SM_EXT + $d_margin) / 2;
DREMEL_INT = (35 - $d_margin) / 2;
DREMEL_EXT = (37 + $d_margin) / 2;

module adapter() {
  // Manchon interne
  tube(
    h=30,
    ir=VACUUM_EXT,
    or=DREMEL_INT,
    anchor=BOTTOM
  );

  // Base du manchon
  down(2) tube(
    h=2,
    ir=VACUUM_EXT,
    or=DREMEL_EXT + 2,
    anchor=BOTTOM
  );

  // Contour du manchon
  tube(
    h=9,
    ir=DREMEL_EXT,
    or=DREMEL_EXT + 2,
    anchor=BOTTOM
  );
}

adapter();

include <BOSL/constants.scad>
include <../constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

RACK_BASE_U = 0.5;

rack_panel_height = 22;
rack_panel_width = 148;
rack_panel_thickness = 3;

rack_unit_width = 111.5;
rack_unit_height = 2;
rack_support_width = 2;
rack_margin_left = (rack_panel_width / 2 - rack_unit_width / 2);

/**
 * Parametric rack panel module
 * - U: Number of rack units (U) to cover (0.5, 1, 1.5, 2)
 */
module rack_panel(U=0.5) {
  // Check that U is a valid value
  assert(U == 0.5 || U == 1 || U == 1.5 || U == 2, "Error: U must be 0.5, 1, 1.5, or 2");

  // When U is -> count is
  // 0.5 -> 1
  // 1   -> 2
  // 1.5 -> 3
  // 2   -> 4
  U_count = U / RACK_BASE_U;

  rack_mounting_hole_diameter = 3;
  rack_mounting_hole_padding = 9;

  left(rack_margin_left) difference() {
    // Front panel
    {
      cuboid(
        [
          rack_panel_width,
          rack_panel_thickness,
          // Compute the rack height based on U: 22mm is the base height for U=0.5
          rack_panel_height * U_count
        ],
        align=V_ALLPOS,
        edges=EDGE_TOP_LF+ // Top left
              EDGE_TOP_RT+ // Top right
              EDGE_BOT_LF+ // Bottom left
              EDGE_BOT_RT, // Bottom right
        fillet=rack_panel_thickness
      );
    }

    // Mounting holes
    {
      // Center vertically
      up((rack_panel_height / 2) - (rack_mounting_hole_diameter / 2)) {

        // Left padding
        right(rack_mounting_hole_padding) {

          // Copy and spread holes along the Z axis up based on U size
          zspread(
            spacing=rack_panel_height,
            // Compute the number of holes based on U: 1 is the base number for U=0.5
            n=U_count,
            sp=true // spread on a line up from starting position
          ) {

            // Copy and spread holes along the X axis
            xspread(
              spacing=rack_panel_width - rack_mounting_hole_diameter - rack_mounting_hole_padding * 2,
              n=2,
              sp=true
            ) {

              // Draw the hole
              forward(tolerance) ycyl(
                l=rack_panel_thickness + tolerance * 2,
                d=rack_mounting_hole_diameter,
                align=V_ALLPOS
              );
            }
          }
        }
      }
    }
  }
}

module rack_unit(U=0.5, length=90) {
  // Check that U is a valid value
  assert(U == 0.5 || U == 1 || U == 1.5 || U == 2, "Error: U must be 0.5, 1, 1.5, or 2");

  // When U is -> count is
  // 0.5 -> 1
  // 1   -> 2
  // 1.5 -> 3
  // 2   -> 4
  U_count = U / RACK_BASE_U;

  rack_unit_length = length;

  // Draw rack unit
  cuboid(
    [
      rack_unit_width,
      rack_unit_length,
      rack_unit_height
    ],
    align=V_ALLPOS,
    edges=EDGE_BK_LF+ // Back left
          EDGE_BK_RT, // Back right
    fillet=rack_unit_height
  );

  // Draw support
  xspread(
    spacing=rack_unit_width - rack_unit_height,
    n=2,
    sp=true
  ) {
    cuboid(
      [
        rack_support_width,
        rack_panel_thickness,
        rack_panel_height * U_count
      ],
      align=V_ALLPOS
    );

    back(rack_panel_thickness) right_triangle(
      [
        rack_support_width,
        rack_unit_length * 0.7,
        rack_panel_height * U_count
      ],
      orient=ORIENT_X,
      align=V_ALLPOS
    );
  }

  children();
}

// Example usage:
// rack_unit() {
//   difference() {
//     rack_panel();
//     forward(tolerance) cuboid(
//       [
//         rack_unit_width,
//         rack_panel_width + tolerance,
//         rack_panel_height + tolerance
//       ],
//       align=V_ALLPOS
//     );
//   }
// }


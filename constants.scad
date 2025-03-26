/**
 * Circle resolution constants
 *
 * The $fa, $fs, and $fn special variables control the number of facets used to generate an arc:
 * $fa: Minimum angle for a fragment. Default value is 12 (i.e. 30 fragments for a full circle)
 * $fs: Minimum size of a fragment. Default value is 2 (so very small circles have a smaller number of fragments)
 * $fn: Number of fragments. Default value is 0 (i.e. automatic calculation based on the circle radius and the $fa and
 * $fs values)
 */
$fa = 1;
$fs = $preview ? 1 : 0.5;

/**
 * 3D printing constants
 *
 * These constants are used to simplify the design process for 3D printing.
 */
TOLERANCE = .01;

// Vacuum-adapter family settings.
include <../_lib/print-settings.scad>

// Adapters use a slightly coarser preview mesh and need additional fit clearance.
$fs = $preview ? 1.5 : 0.5;
$tolerance = 0.1;

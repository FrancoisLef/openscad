/**
 * Shared rendering and BOSL2 fit defaults.
 *
 * Include this file from an entry model, or from a project-level config.scad
 * when a project needs to override one of these values.
 */

// Fine circular resolution: quicker previews, smoother final renders.
$fa = 1;
$fs = $preview ? 1 : 0.5;

// Default clearance used by BOSL2 hardware helpers.
$slop = 0.01;

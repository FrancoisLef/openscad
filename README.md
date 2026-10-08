# Personal OpenSCAD projects

## Installation

### Libraries

Followed [this](https://github.com/revarbat/BOSL/wiki) wiki installation guide.


## Organization

- `lib/` contains shared, responsibility-named modules. `lib/print-settings.scad`
  is the single source of truth for the common render quality and BOSL2 `$slop`
  defaults.
- Each top-level directory is a project. A project gets a `config.scad` only
  when it has real project-wide overrides or parameters; for example,
  `aspirateur/config.scad` changes the preview resolution and fit tolerance for
  the whole adapter family.
- Keep dimensions that belong to a single part next to that part. Move a value
  into a project `config.scad` only once more than one file needs it; move it
  into `lib/` only when several projects need the same rule.
- Do not introduce generic `constants.scad` files. Name the module for its
  responsibility, such as `print-settings.scad`, `fasteners.scad`, or
  `profiles.scad`.

### Adding a BOSL2 model

Use the shared defaults directly when no project-specific settings are needed:

```scad
include <BOSL2/std.scad>
include <../lib/print-settings.scad>
```

For a project with an override, include the project configuration instead:

```scad
include <BOSL2/std.scad>
include <config.scad>
```

## Projects

### Raspberry Pi 5 case

<p align="center">
  <img src="docs/img/pi5-case-full.png" />
</p>

<p align="center">
  <img src="docs/img/pi5-case-open.png" />
</p>

### Tahoma shelf

<p align="center">
  <img src="docs/img/tahoma-shelf.png" />
</p>

### Aqara Hub M2 wall mount

<p align="center">
  <img src="docs/img/aqara-hub.png" />
</p>

### Netatmo relay wall mount

<p align="center">
  <img src="docs/img/netatmo-relay.png" />
</p>

### Brother spool holder

<p align="center">
  <img src="docs/img/brother-spool-holder.png" />
</p>

### Support grille

<p align="center">
  <img src="docs/img/support-grille.png" />
</p>

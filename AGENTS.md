# OpenSCAD repository instructions

Apply these instructions before modifying OpenSCAD geometry, BOSL/BOSL2
dependencies, or repository tooling.

## Layout and dependencies

- A project lives under `src/<project>/`. A `.scad` file that contains top-level
  geometry is a renderable entry point.
- `src/lib/` holds cross-project modules named for one responsibility. It is not a
  collection of project-specific dimensions.
- `src/<project>/config.scad` exists only for values shared by that project. Keep
  dimensions used by a single part next to that part.
- Use `include` for settings and definitions that must enter the caller's
  scope. Use `use` for reusable geometry modules and functions whose top-level
  geometry must not be imported.
- New work uses BOSL2. Existing `BOSL/` models are legacy; keep their
  dependency style unchanged unless a migration is explicitly requested.
- The repository pins BOSL v1 and BOSL2 as Git submodules under `vendor/`.
  `scripts/scad` exposes that directory through `OPENSCADPATH`.

## Rendering workflow

```sh
make bootstrap
make doctor
make models
make check MODEL=src/rpi5-case/rpi5-case.scad
make export MODEL=src/rpi5-case/rpi5-case.scad FORMAT=stl
make check-all
```

- Run `make check` for every changed renderable entry point. It compiles to a
  temporary CSG file and leaves no artifact behind.
- `make check-all` checks every non-library `.scad` source and returns failure
  for unresolved imports or symbols; it still displays non-blocking OpenSCAD
  warnings and deprecations.
- Use `make export` when a mesh or PNG is needed for review. It writes to
  `build/<model-path>.<format>`; `build/` is ignored by Git.
- Report OpenSCAD warnings. Treat a successful CSG check as syntax and
  dependency validation, not proof that a final mesh is printable.

## Design rules

- Prefer parameterized modules with a small, purposeful interface. Keep
  placement, anchors, cuts, and manufacturing allowances behind that interface.
- For a new printed part, establish the printing orientation, clearance/
  tolerance assumptions, wall thickness, and fastener interfaces before
  finalizing the geometry.
- Shared render defaults live in `src/lib/print-settings.scad`. A model needing
  project-wide overrides includes its project `config.scad` instead.
- Keep intentional source images under `src/<project>/` or `docs/img/`; keep
  generated previews and exports under `build/`.

## Focused skill

For geometry design, BOSL2 composition, OpenSCAD failures, or render/export
work, read `.agents/skills/openscad-design/SKILL.md` before acting.

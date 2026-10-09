---
name: openscad-design
description: Design, modify, render, or debug OpenSCAD and BOSL2 parts in this repository, including print-fit decisions and reproducible CLI validation.
---

# OpenSCAD design

Read `AGENTS.md` first. Run `make bootstrap` once in a fresh clone, then `make doctor` before the first render. This skill covers a request to create or modify a printed
part, compose BOSL2 geometry, investigate an OpenSCAD error, or produce a
reviewable export.

## Work from a part contract

Identify the part's purpose, mating interfaces, critical dimensions, print
orientation, and output expected by the user. Inspect neighboring models before
introducing a new pattern. Keep local dimensions in the model, project-shared
values in `src/<project>/config.scad`, and cross-project rules in `src/_lib/`.

Choose a small module interface that exposes useful dimensions and options while
hiding placement, anchors, cuts, and clearance implementation. New models use
BOSL2 and include the shared `src/_lib/print-settings.scad` by relative path
(normally `<../lib/print-settings.scad>`) unless the project already has a
`config.scad`.

## Build and inspect

After changing a renderable entry point, run:

```sh
make check MODEL=path/to/model.scad
```

Use an export only when it provides useful evidence:

```sh
make export MODEL=path/to/model.scad FORMAT=stl
make export MODEL=path/to/model.scad FORMAT=png
```

Inspect generated PNGs when visual geometry, orientation, or assembly fit is
part of the request. Generated files belong under `build/` and are not committed
unless the user explicitly asks for a curated artifact. When a renderable
model is added or visually changed, run `make catalog` so the committed GitHub
preview and generated README catalog stay current.

## Fit and print review

Before declaring a part ready, check the mating dimensions, intended clearance,
wall thickness, overhang strategy, and the placement of fasteners or nut traps.
Use the repository's `$slop` default for ordinary BOSL2 helpers; keep a
part-specific fit adjustment explicit and local. A successful CSG check proves
parsing and local dependency resolution only, so state any remaining physical
assumptions.

## Legacy BOSL

When editing a model that imports `BOSL/`, preserve the existing library style.
Do not mix BOSL and BOSL2 in a model as incidental cleanup; propose a dedicated
migration when its benefits justify the geometry-risk and visual verification.

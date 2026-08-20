#!/usr/bin/env bash
# Render the site, forcing re-execution of R chunks.
#
# `quarto render` on its own is NOT safe here. The site sets
# `execute: freeze: auto`, and the freeze key is computed from the .qmd files
# only — so edits to R/course-meta.R, R/sessions.R or R/cycle-diagram.R (the
# actual sources of the dates, the schedule and the diagram) do not invalidate
# it. Quarto then silently replays stale results.
#
# There are two caches; both have to go.
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf .quarto _freeze
quarto render "$@"
echo
echo "Rendered. Commit _freeze/ along with your source change."

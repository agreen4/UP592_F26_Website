#!/usr/bin/env Rscript
# Writes one standalone SVG per phase to images/, for reuse outside the site
# (slides, handbook, orientation decks). The website generates its own diagram
# inline from R/cycle-diagram.R and does not read these files.
#
# Run from the project root:  Rscript scripts/build-cycle-diagrams.R

if (!file.exists("R/cycle-diagram.R")) {
  stop("Run this from the project root (R/cycle-diagram.R not found).")
}
source("R/cycle-diagram.R")

for (p in 1:4) {
  out <- sprintf("images/cycle-diagram-phase%d.svg", p)
  writeLines(cycle_diagram_svg(current_phase = p, animate = FALSE), out)
  cat("wrote", out, "\n")
}

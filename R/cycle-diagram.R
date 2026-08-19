# ─────────────────────────────────────────────────────────────────────────────
# Four-phase seminar cycle diagram — generator
#
# UP 592 runs a four-semester rotation. The diagram is identical across
# semesters EXCEPT for which phase is marked current, so it is generated from
# one definition rather than maintained as four hand-edited SVGs.
#
#   cycle_diagram_svg(current_phase = 1, semester = "Fall 2026")
#
# Layout is computed, not hand-placed: four cards on the compass points of a
# circle, connecting arrows struck as arcs of a larger circle. Changing card
# size or radius moves everything consistently.
# ─────────────────────────────────────────────────────────────────────────────

PHASES <- list(
  list(n = 1, line1 = "Writing Your",    line2 = "First Article",
       when = "Phase 1 &#183; Fall",   color = "#1a5fb4"),
  list(n = 2, line1 = "Writing For",     line2 = "Funding",
       when = "Phase 2 &#183; Fall",   color = "#2a7a2a"),
  list(n = 3, line1 = "Writing Your",    line2 = "Dissertation Proposal",
       when = "Phase 3 &#183; Spring", color = "#c75b2a"),
  list(n = 4, line1 = "Developing Your", line2 = "Academic Brand",
       when = "Phase 4 &#183; Spring", color = "#6b3a8a")
)

SERIF <- "'Source Serif Pro', Georgia, serif"
SANS  <- "'Source Sans Pro', system-ui, sans-serif"
NAVY  <- "#1a2a4a"

cycle_diagram_svg <- function(current_phase = 1,
                              semester = NULL,
                              animate  = TRUE) {

  stopifnot(current_phase %in% 1:4)

  cx <- 330; cy <- 310          # centre of the wheel
  card_w <- 220; card_h <- 70   # phase card
  hw <- card_w / 2; hh <- card_h / 2
  # ELLIPTICAL, not circular. The original sat the cards on a circle and hid
  # the tightness with a shaded disc behind them. With the disc gone the centre
  # title runs into the left and right cards, so the layout is stretched
  # horizontally: wider than tall, giving the title room between the cards.
  pos_rx <- 275; pos_ry <- 195                 # centre -> card centre
  arc_rx <- pos_rx + 50; arc_ry <- pos_ry + 50 # arrows struck outside the cards

  # Cards on the compass points, clockwise from top
  angles <- c(-90, 0, 90, 180)
  px <- cx + pos_rx * cos(angles * pi / 180)
  py <- cy + pos_ry * sin(angles * pi / 180)

  pt <- function(deg) {
    c(cx + arc_rx * cos(deg * pi / 180), cy + arc_ry * sin(deg * pi / 180))
  }

  # One arc per gap between adjacent cards, clockwise, arrowhead at the far end
  arcs <- vapply(seq_along(angles), function(i) {
    from <- pt(angles[i] + 25)
    to   <- pt(angles[i] + 65)
    sprintf(
      '  <path d="M %.1f %.1f A %.0f %.0f 0 0 1 %.1f %.1f" fill="none" stroke="%s" stroke-width="2.5" marker-end="url(#arrowhead)"/>',
      from[1], from[2], arc_rx, arc_ry, to[1], to[2], NAVY)
  }, character(1))

  cards <- vapply(seq_along(PHASES), function(i) {
    p <- PHASES[[i]]
    is_current <- p$n == current_phase
    small <- nchar(p$line2) > 16          # long second lines need a smaller face
    fs <- if (small) 13 else 14

    ring <- ""
    if (is_current) {
      dash <- if (animate) paste0(
        '<animate attributeName="stroke-dashoffset" from="0" to="16" ',
        'dur="2s" repeatCount="indefinite"/>') else ""
      ring <- sprintf(paste0(
        '\n    <rect x="%.0f" y="%.0f" width="%d" height="%d" rx="12" fill="none" ',
        'stroke="%s" stroke-width="3" stroke-dasharray="5,3">%s</rect>',
        '\n    <text x="0" y="%.0f" text-anchor="middle" font-family="%s" ',
        'font-size="11" font-weight="600" letter-spacing="0.5" fill="%s">CURRENT</text>'),
        -hw - 9, -hh - 9, card_w + 18, card_h + 18, p$color, dash,
        hh + 30, SANS, p$color)
    }

    sprintf(paste0(
      '  <g transform="translate(%.0f, %.0f)">\n',
      '    <rect x="%.0f" y="%.0f" width="%d" height="%d" rx="8" fill="#fff" ',
      'stroke="%s" stroke-width="2" filter="url(#shadow)"/>\n',
      '    <text x="0" y="-8" text-anchor="middle" font-family="%s" font-size="%d" ',
      'font-weight="600" fill="%s">%s</text>\n',
      '    <text x="0" y="12" text-anchor="middle" font-family="%s" font-size="%d" ',
      'font-weight="600" fill="%s">%s</text>\n',
      '    <text x="0" y="28" text-anchor="middle" font-family="%s" font-size="10" ',
      'fill="#5a5a5a">%s</text>%s\n  </g>'),
      px[i], py[i], -hw, -hh, card_w, card_h, p$color,
      SERIF, fs, p$color, p$line1,
      SERIF, fs, p$color, p$line2,
      SANS, p$when, ring)
  }, character(1))

  # viewBox is COMPUTED from the layout, not hardcoded. The hand-written
  # original clipped its left and right cards (and the current-phase ring)
  # because a 600x600 box could not hold cards centred 220px off a centre at
  # x=300 with a half-width of 110. Deriving it means moving anything above
  # cannot silently slice the drawing.
  pad     <- 14
  ring_pad <- 9
  label_drop <- 42            # CURRENT label baseline + descender below card
  min_x <- cx - pos_rx - hw - ring_pad - pad
  max_x <- cx + pos_rx + hw + ring_pad + pad
  min_y <- cy - pos_ry - hh - ring_pad - pad
  max_y <- cy + pos_ry + hh + label_drop + pad
  view_box <- sprintf("%.0f %.0f %.0f %.0f",
                      min_x, min_y, max_x - min_x, max_y - min_y)

  cur <- PHASES[[current_phase]]
  sem_line <- if (!is.null(semester)) sprintf(
    '\n  <text x="%d" y="%d" text-anchor="middle" font-family="%s" font-size="12" font-weight="600" fill="%s">%s</text>',
    cx, cy + 47, SANS, cur$color, semester) else ""

  desc <- sprintf(
    "Four-phase doctoral seminar cycle: %s. Phase %d, %s, is the current semester%s.",
    paste(vapply(PHASES, function(p)
      sprintf("Phase %d %s %s", p$n, p$line1, p$line2), character(1)),
      collapse = "; "),
    cur$n, paste(cur$line1, cur$line2),
    if (!is.null(semester)) paste0(" (", semester, ")") else "")

  # NOTE: no blank lines in the output. Pandoc terminates a raw HTML block at
  # the first blank line, so a prettily-spaced SVG renders as an empty box with
  # its <text> content dumped into the page as markdown. Collapsed below.
  svg <- paste0(
'<svg xmlns="http://www.w3.org/2000/svg" viewBox="', view_box, '" width="100%" height="auto" role="img" aria-labelledby="cycle-title cycle-desc">
  <title id="cycle-title">Doctoral Seminar Workshop Sequence &#8212; four-phase cycle</title>
  <desc id="cycle-desc">', desc, '</desc>
  <defs>
    <filter id="shadow" x="-10%" y="-10%" width="120%" height="120%">
      <feDropShadow dx="0" dy="3" stdDeviation="4" flood-color="#000" flood-opacity="0.1"/>
    </filter>
    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="', NAVY, '"/>
    </marker>
  </defs>

  <text x="', cx, '" y="', cy - 25, '" text-anchor="middle" font-family="', SERIF, '" font-size="18" font-weight="700" fill="', NAVY, '">Doctoral Seminar</text>
  <text x="', cx, '" y="', cy, '" text-anchor="middle" font-family="', SERIF, '" font-size="18" font-weight="700" fill="', NAVY, '">Workshop Sequence</text>
  <text x="', cx, '" y="', cy + 25, '" text-anchor="middle" font-family="', SANS, '" font-size="12" fill="#5a5a5a">4-Phase Cycle</text>', sem_line, '

', paste(arcs, collapse = "\n"), '

', paste(cards, collapse = "\n"), '
</svg>
')
  gsub("\n[ \t]*\n+", "\n", svg)
}

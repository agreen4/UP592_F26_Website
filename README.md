# UP 592: Doctoral Urban Planning Seminar Website

## Overview

This is a Quarto-based website for the UP 592 Doctoral Urban Planning Seminar. It uses a modernized academic design with a four-phase cycle structure.

## Project Structure

```
up592-website/
├── _quarto.yml           # Site configuration
├── index.qmd             # Homepage
├── syllabus.qmd          # Syllabus and policies
├── schedule.qmd          # Week-by-week schedules
├── resources.qmd         # Links, tools, and templates
├── styles.css            # Custom CSS styling
├── images/
│   └── cycle-diagram.svg # Four-phase cycle diagram
└── _site/                # Generated output (created by quarto render)
```

## Prerequisites

- [Quarto](https://quarto.org/docs/get-started/) installed locally
- A Netlify account (or similar static hosting)

## Local Development

1. Navigate to the project directory:
   ```bash
   cd up592-website
   ```

2. Render the site:
   ```bash
   quarto render
   ```

3. Preview the site locally:
   ```bash
   quarto preview
   ```

## Deployment

### Option 1: Netlify Drop (Drag & Drop)

1. Run `quarto render` to generate the `_site` folder
2. Go to [Netlify Drop](https://app.netlify.com/drop)
3. Drag and drop the `_site` folder
4. Your site is live!

### Option 2: Netlify with Git (this repo's setup)

`netlify.toml` + `package.json` install Quarto on Netlify via
`@quarto/netlify-plugin-quarto`. Connect the repo at
<https://app.netlify.com/start> and pick it — build command and publish
directory come from `_quarto.yml` (`output-dir: _site`), so nothing needs
setting by hand.

**⚠ This site executes R code** (`schedule.qmd`, `index.qmd`, `syllabus.qmd`
source files in `R/`). Netlify's build image has no R. Builds succeed because
`_quarto.yml` sets `execute: freeze: auto` and `_freeze/` is committed —
Quarto replays cached results rather than running R.

**So: after editing any `.qmd`, run `quarto render` locally and commit the
updated `_freeze/` with your change.** Pushing a `.qmd` edit without a fresh
freeze makes Netlify try to execute R, and the build fails.

### Option 3: GitHub Pages

1. Run `quarto render`
2. Use the `quarto publish gh-pages` command

## Customization

### Updating Content

Most things are **derived**, so edit the source of truth rather than the page:

| To change | Edit |
|---|---|
| Meeting day, time, location; semester start dates | `R/course-meta.R` |
| What happens each week (topics, session types, leads) | `R/sessions.R` |
| Which phase is current on the homepage diagram | `current_phase` in `index.qmd` |
| The cycle diagram itself | `R/cycle-diagram.R` |
| Prose, resources, policies | `index.qmd`, `syllabus.qmd`, `resources.qmd` |

Session **dates are computed** as `start + 7 * (week - 1)` from the two start
dates in `R/course-meta.R` — moving the seminar to a different day is a
one-line change, not 30 edits. The meeting day shown on the site is read back
off the start date, so a start date that is not the stated day will contradict
itself visibly rather than silently.

Homepage "at a glance" counts are computed from `R/sessions.R`, so adding or
removing a session cannot leave a stale count behind.

Standalone per-phase cycle diagrams for slides and handouts:

```bash
Rscript scripts/build-cycle-diagrams.R
```

After editing, run `quarto render` and commit `_freeze/` (see the Netlify note
above).

### Design Changes

Edit `styles.css` to modify:
- Colors (CSS variables at the top)
- Typography
- Spacing
- Table styling
- Responsive behavior

### Adding Pages

1. Create a new `.qmd` file
2. Add it to `_quarto.yml` under `website.navbar.left`
3. Run `quarto render`

## Design Notes

- **Color palette:** Deep navy primary, warm terracotta accent, warm gray backgrounds
- **Typography:** Source Sans Pro (body) + Source Serif Pro (headings)
- **Layout:** Responsive, mobile-first, with sidebar navigation on desktop
- **Accessibility:** WCAG-compliant color contrast, semantic HTML, keyboard-navigable

## Contact

For questions about the site, contact the course facilitator.

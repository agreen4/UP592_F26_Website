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

### Option 2: Netlify with Git

1. Push this folder to a GitHub repository
2. Connect the repo to Netlify
3. Set build command: `quarto render`
4. Set publish directory: `_site`

### Option 3: GitHub Pages

1. Run `quarto render`
2. Use the `quarto publish gh-pages` command

## Customization

### Updating Content

All content is written in Markdown (`.qmd` files). Edit the files directly:

- **Schedule changes:** Edit `schedule.qmd`
- **Syllabus updates:** Edit `syllabus.qmd`
- **Resources:** Edit `resources.qmd`
- **Homepage:** Edit `index.qmd`

After editing, run `quarto render` to regenerate the site.

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

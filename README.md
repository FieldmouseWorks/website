# website

Source for [fieldmouseworks.com](https://fieldmouseworks.com), the
[Fieldmouse Works](https://github.com/FieldmouseWorks) landing page.

Static HTML + CSS, no build step.

- `index.html` / `style.css` — the page
- `privacy.html` — the privacy policy, served as `/privacy`
- `assets/` — mark, favicons, Open Graph image (from the logo kit)

## Check it

`nix flake check` validates every page and stylesheet (W3C Nu validator) and
checks every local link, asset and `#fragment` offline (lychee). CI runs the
same on every PR. To look at it, `python3 -m http.server` in this folder.

## Deploy

Push to `main`. The Fieldmouse Works host checks this repository every five
minutes and publishes the newest `main` as fieldmouseworks.com, served by nginx.
Everything in the repository except this README and dotfiles is public on the
site.

GitHub Pages is off. This repository was `fieldmouseworks.github.io` until
2026-10-16, when it was renamed so that Pages could be turned off.

## License

No license yet: all rights reserved until a `LICENSE` file is added.

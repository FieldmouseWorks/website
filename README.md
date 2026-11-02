# website

The source of [fieldmouseworks.com](https://fieldmouseworks.com), the home page
of [Fieldmouse Works](https://github.com/FieldmouseWorks). Fieldmouse Works
builds open-source software for systems that are expensive, restrictive or
hard to leave, and the page says what each of its projects is, where it
stands and where to find it.

It's static HTML and CSS, with no build step.

- `index.html` and `style.css`: the page
- `privacy.html`: the privacy policy, served as `/privacy`
- `assets/`: the mark, favicons and Open Graph image, from the logo kit

## Look at it and check it

Serve the folder with `python3 -m http.server` and open
<http://localhost:8000>. `nix flake check` validates every page and stylesheet
(W3C Nu validator) and checks every local link, asset and `#fragment` offline
(lychee); CI runs the same on every PR.

## Deploy

Merge to `main`. The Fieldmouse Works host publishes `main` as
fieldmouseworks.com within seconds of each push to it, served by nginx.
Everything in the repository except this README and dotfiles is public on the
site.

GitHub Pages is off. This repository was `fieldmouseworks.github.io` until
2026-10-16, when it was renamed so that Pages could be turned off.

## License

The code (HTML structure, CSS, build files) is MIT; see [LICENSE](LICENSE).
The written content, the images in `assets/` and the Fieldmouse Works name and
logo aren't covered: all rights reserved.

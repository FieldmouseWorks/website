# Working on the website

The source of [fieldmouseworks.com](https://fieldmouseworks.com): static HTML
and CSS, no build step. `main` is what the site serves.

<!-- house:rules v1 begin. Copied from FieldmouseWorks/burrow house/rules.md, verbatim. Change it there, not here: burrow's house sync rewrites everything between these markers. -->
## House rules

These hold in every repo. This file's own sections add to them and win where
they say something more specific.

- Fix the whole cause. No workarounds, shims, fallbacks or half-migrations:
  when you replace something, delete the old path in the same change.
- One fact, one home. Each rule or fact lives in one place; link to it instead
  of restating it.
- Before you edit, say what done looks like and how it will be checked. Simple
  work gets a short plan, not a ceremony.
- Report only the checks you actually ran, and what they said. Skipped,
  unavailable or "should pass" is never a pass. Keep local and CI results
  apart.
- A new check comes with proof that it fails on the bug it's for.
- Touching a file over about 1,000 lines? Split it in that change.
- The code is the memory. When something goes wrong, make the code, a type, a
  test or a check stop it happening again; a new rule in AGENTS.md is the last
  resort. Say in the PR which one you did.
- Keep going on work you were asked to do. Don't stop to ask again for what's
  already been asked for.
- Never commit what the repo keeps private: secrets, tokens, personal data, and
  anything listed under this file's "Private" section.
- `Closes #N` only when the issue is fully done; otherwise `Refs #N`.
- Tracked files never name a model. Which model does what is the machine's
  business, and model names go stale in weeks.

### Commits

Subjects are `area: plain sentence`, where the area is the module, directory or
tool the change is about: `autoland: merge only the head that was checked`.
Lowercase after the colon, no trailing period, no `feat:`/`fix:` prefixes. The
body, when there is one, says why.
<!-- house:rules end -->

## The site

- `index.html`, `privacy.html` and `style.css` are the pages; `assets/` holds
  the mark, favicons and Open Graph image from the logo kit.
- The Fieldmouse Works host (remi, `modules/web.nix` in FieldmouseWorks/remi)
  publishes `main` every five minutes: it copies everything but `README.md`
  and dotfiles, and nginx serves `/privacy` from `privacy.html`. A merge is a
  deploy, and every tracked file outside those two exclusions is public.
- Pages other than `index.html` link root-relative (`/style.css`,
  `/#projects`), so they work from their extensionless URL.

## Build and test

There's nothing to build. `nix flake check` is the gate, the same locally and
in CI: the W3C Nu validator over every page and stylesheet, and lychee,
offline, over every local link, asset and `#fragment`. `nix develop` has both
tools. To look at it, serve the folder (`python3 -m http.server`) and open
`/privacy.html` rather than `/privacy`: only nginx does the extensionless
fallback.

## Pull requests

Open PRs as drafts and leave them to the steward: it asks Codex for a review,
and once Codex finds nothing on your head, every review thread is resolved and
CI is green, it marks the PR ready and merges it. Fix or answer every finding:
push the fix and reply with the commit, or reply with why it's wrong, then
resolve the thread. Don't merge or mark ready yourself.

## Code Review Rules

For reviewers, Codex included. Flag as P1:

- a change that makes a check pass without fixing the thing it checks
- tests or checks weakened, skipped or deleted to get green
- secrets, tokens or personal data in the diff or the logs it adds
- behavior changed beyond what the PR says it does
- a tracked file that mustn't be public: everything but `README.md` and
  dotfiles is published on the site as soon as it merges
- a broken page, asset or link on the live site: a removed or renamed file
  something still points to, or a page that only works from one URL
- third-party scripts, trackers or analytics added to a page, or a change to
  what `privacy.html` promises without the matching change to the site

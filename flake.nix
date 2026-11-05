{
  description = "fieldmouseworks.com, the Fieldmouse Works website";

  # Pinned by commit, so Renovate moves it with the workflows' pins on burrow
  # (burrow's templates/project/flake.nix).
  inputs.burrow.url = "git+https://github.com/FieldmouseWorks/burrow?ref=main&rev=46cab2ed869c60b415ee61aeff9026cecaf3a942";

  # `nix develop` for the tools, `nix flake check` for the gate (see burrow's
  # lib/project.nix). The site is static HTML and CSS, so the gate is the
  # site's own: every page valid, every local link and fragment found.
  outputs =
    { self, burrow }:
    burrow.lib.project {
      inherit self;
      packages = pkgs: [
        pkgs.lychee
        pkgs.validator-nu
      ];
      checks = pkgs: {
        # The W3C Nu validator, over every .html and .css file.
        html-valid = pkgs.runCommand "html-valid" { nativeBuildInputs = [ pkgs.validator-nu ]; } ''
          cd ${self}
          vnu --errors-only --also-check-css --skip-non-html .
          touch $out
        '';
        # Local links, assets and #fragments, resolved the way nginx serves
        # them (modules/web.nix in remi): / is the repo root, /privacy is
        # privacy.html and a directory is its index.html. Offline: external
        # links aren't checked, but lychee won't start without CA certificates.
        links = pkgs.runCommand "links" { nativeBuildInputs = [ pkgs.lychee ]; } ''
          export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
          cd ${self}
          lychee --offline --no-progress --include-fragments \
            --root-dir "$PWD" --fallback-extensions html --index-files index.html \
            ./*.html style.css
          touch $out
        '';
      };
    };
}

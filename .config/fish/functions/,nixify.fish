function nixify
  if not test -e ./.envrc
    echo "use nix" > .envrc
    direnv allow
  end
  if not test -e default.nix; and not test -e shell.nix
    echo "with import <nixpkgs> {};
stdenv.mkDerivation {
  name = \"env\";
  buildInputs = [];
}" > default.nix
  vim default.nix
  end
end

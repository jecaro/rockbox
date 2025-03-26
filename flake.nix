# $ nix develop
# $ mkdir build
# $ cd build
# $ ../tools/configure # choose 50 sansa-e200
# $ make
# $ ./rockboxui
{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      staticSDL2 = pkgs.SDL2.overrideAttrs (old: {
        dontDisableStatic = 1;
      });
    in
    {
      devShell.x86_64-linux =
        pkgs.mkShell {
          buildInputs = [
            pkgs.autoconf
            pkgs.ccls
            pkgs.gcc
            pkgs.gnumake
            pkgs.patch
            pkgs.perl
            pkgs.zip
            pkgs.gawk
            pkgs.bison
            pkgs.flex
            pkgs.automake
            pkgs.libtool
            pkgs.curl
            pkgs.texinfo
            pkgs.gmp
            staticSDL2
            pkgs.xorg.libX11
            pkgs.xorg.libXrandr
            pkgs.xorg.libXext
            pkgs.xorg.libXcursor
            pkgs.xorg.libXi
            pkgs.xorg.libXfixes
            pkgs.xorg.libXScrnSaver
          ];

          shellHook = ''
            export ROCKBOXDEV_ROOT=/home/jc/development/rockbox/rockbox-dev;
            export PATH=$ROCKBOXDEV_ROOT/bin:$PATH;
            export LD_LIBRARY_PATH=${pkgs.pipewire}/lib;
          '';
        };
    };
}

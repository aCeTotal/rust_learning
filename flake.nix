{
  description = "Rust learning :)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };
      rust = pkgs.rust-bin.stable.latest.default.override {
        extensions = [ "rust-src" "rust-analyzer" ];
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          rust
          pkgs.cargo-watch
          pkgs.wayland
          pkgs.libxkbcommon
          pkgs.vulkan-loader
        ];

        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.wayland
          pkgs.libxkbcommon
          pkgs.vulkan-loader
        ];

        shellHook = ''
          echo "Rust $(rustc --version | cut -d' ' -f2)"
        '';
      };
    };
}

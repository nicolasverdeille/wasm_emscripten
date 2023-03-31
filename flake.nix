{
  description = "Hackathon 2023";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        rust = pkgs.rust-bin.stable."1.68.0".minimal.override {
          extensions = [ "rustfmt" "clippy" "rust-src" "rust-docs" ];
          targets = [ "wasm32-unknown-emscripten" ];
        };
      in
      with pkgs;
      {
        devShells.default = mkShell.override { stdenv = llvmPackages_14.stdenv; } {
          buildInputs = [
            cmake
            docker-compose
            emscripten
            glibc_multi
            python3
            rust
          ];

          EM_CACHE = "/tmp/.emscripten_cache";
          LIBCLANG_PATH = "${llvmPackages_14.libclang.lib}/lib";

          shellHook = ''
            mkdir -p /tmp/.emscripten_cache
            alias cb="cargo build --target wasm32-unknown-emscripten"
            alias serve="python -m http.server"
          '';
        };
      }
    );
}

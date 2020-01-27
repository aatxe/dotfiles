# Any platform-independent additional setup.
# Mostly development stuff with its own platform-independent installers.

# Install Rust.
curl https://sh.rustup.rs -sSf | sh

# Install important OCaml dependencies.
opam instal ppx_deriving merlin

# Install Coq with opam.
opam repo add coq-released https://coq.inria.fr/opam/released
opam install coq

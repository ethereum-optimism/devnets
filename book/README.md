# book

This directory contains tooling to generate the [devnets website](https://devnets.optimism.io) using a combination 
of `mdbook` and some custom Python tooling. The Python tooling iterates over the devnet manifests, then outputs 
Markdown files in the `src` directory. These are then used to generate the website using `mdbook`.

Since most of them are generated, the `src` directory's contents are excluded through `.gitignore.` 

## Usage

You will first need to install `uv` and `just`. Then:

1. Generate the devnet docs by running `just generate`.
2. Run `just serve` to start the local server.
3. For prod, run `just build` to generate the static site.

## CI

CI will regenerate the book on every push to `main`.
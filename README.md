# Mint UI

[![CI](https://github.com/mint-lang/mint-ui/actions/workflows/ci.yml/badge.svg)](https://github.com/mint-lang/mint-ui/actions/workflows/ci.yml)
[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.svg)](https://gitter.im/mint-lang/Lobby)
[![Discord](https://img.shields.io/discord/698214718241767445)](https://discord.gg/NXFUJs2)

A beautiful, fully featured, reliable UI component library for [Mint](https://www.mint-lang.com).

* 60+ ready to use, hand crafted components.
* Themable with CSS variables.
* Fully responsive.
* Data driven.

## Get started

To use Mint UI you need to install [Mint](https://www.mint-lang.com/install) first.

Create a new Mint application with:

```console
mint init my-app
```

add `mint-ui` to the `mint.json` file as a dependency:

```json
"dependencies": {
  "mint-ui": {
    "repository": "https://github.com/mint-lang/mint-ui",
    "constraint": "1.0.0 <= v < 2.0.0"
  }
}
```

then install dependencies:

```console
$ mint install
Mint - Installing dependencies
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚙ Constructing dependency tree...
  ✔ Cloned mint-ui(https://github.com/mint-lang/mint-ui)
  ✔ Cloned mint-color(https://github.com/mint-lang/mint-color)

⚙ Resolving dependency tree...
  ◈ mint-ui ➔ 1.0.0
  ◈ mint-color ➔ 0.4.0

⚙ Copying packages...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
All done in 2.387s!"
```

## Documentation

Head to [**ui.mint-lang.com**](https://ui.mint-lang.com) to learn the in and outs of Mint UI!

## License

Be aware of that Mint UI has a special license and requires obtaining a company license in some cases. Read the [LICENSE](LICENSE.md) documentation for more information.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) to learn about contributing to this project.

<div align="center">

# asdf-ttn-lw-cli [![Build](https://github.com/juusujanar/asdf-ttn-lw-cli/actions/workflows/build.yml/badge.svg)](https://github.com/juusujanar/asdf-ttn-lw-cli/actions/workflows/build.yml) [![Lint](https://github.com/juusujanar/asdf-ttn-lw-cli/actions/workflows/lint.yml/badge.svg)](https://github.com/juusujanar/asdf-ttn-lw-cli/actions/workflows/lint.yml)


[ttn-lw-cli](https://github.com/TheThingsNetwork/lorawan-stack) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add ttn-lw-cli
# or
asdf plugin add ttn-lw-cli https://github.com/juusujanar/asdf-ttn-lw-cli.git
```

ttn-lw-cli:

```shell
# Show all installable versions
asdf list-all ttn-lw-cli

# Install specific version
asdf install ttn-lw-cli latest

# Set a version globally (on your ~/.tool-versions file)
asdf global ttn-lw-cli latest

# Now ttn-lw-cli commands are available
ttn-lw-cli version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/juusujanar/asdf-ttn-lw-cli/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Janar Juusu](https://github.com/juusujanar/)

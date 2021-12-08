# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test ttn-lw-cli https://github.com/juusujanar/asdf-ttn-lw-cli.git "ttn-lw-cli version"
```

Tests are automatically run in GitHub Actions on push and PR.

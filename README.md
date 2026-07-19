# Homebrew Tap for Upyr

This tap installs [Upyr](https://upyr.org/), a private English-Ukrainian
keyboard-layout fixer.

```sh
brew tap dmytro-yemelianov/upyr
brew install upyr
```

Start the background service:

```sh
brew services start upyr
```

Run the CLI directly:

```sh
upyr convert ghbdsn
upyr settings
```

The formula builds Upyr from source. It does not install an Apple-notarized
`.app` bundle; macOS users still need to grant Accessibility permission when
the background process prompts for it.

# Ando Homebrew Tap

Install the Ando macOS desktop app with Homebrew:

```bash
brew tap Ando-Corporation/tap
brew install --cask ando
```

Update an existing Homebrew install:

```bash
brew update
brew upgrade --cask ando
```

This tap installs the same signed and notarized macOS app published by ToDesktop.
Direct-download installs continue to update through the in-app updater.

## Install Source Marker

The cask writes an install-source marker outside the signed app bundle at:

```text
~/Library/Application Support/Ando/install-source.json
```

Schema:

```json
{
  "source": "homebrew-cask",
  "cask": "ando",
  "version": "1.0.17,260514nv30o5to8",
  "installedAt": "2026-05-15T00:00:00Z"
}
```

The marker is written from the cask `postflight` block. Homebrew runs that block
after cask installs, including the install phase of `brew upgrade --cask ando`.
The cask does not write into `Ando.app`; `brew zap` removes the marker with the
rest of Ando's Application Support directory.

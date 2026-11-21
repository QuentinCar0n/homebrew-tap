# QuentinCar0n Homebrew tap

This is a Homebrew tap (a third-party cask repository) that installs macOS apps by Quentin Caron with `brew`. It currently holds one cask, `multiclaude`, for [MultiClaude](https://github.com/QuentinCar0n/multiclaude), a menu bar app that runs several Claude desktop accounts side by side. The casks live here instead of in the official `homebrew/cask` repository because the apps are ad hoc signed and not notarized by Apple.

```bash
brew install --cask quentincar0n/tap/multiclaude
```

## At a glance

| | |
| --- | --- |
| Tap name | `quentincar0n/tap` |
| Repository | [QuentinCar0n/homebrew-tap](https://github.com/QuentinCar0n/homebrew-tap) |
| Casks | 1 (`multiclaude`) |
| Platform | macOS |
| Install | `brew install --cask quentincar0n/tap/<cask>` |

## Casks

| Cask | App | Version | Requires | What it is |
| --- | --- | --- | --- | --- |
| `multiclaude` | [MultiClaude](https://github.com/QuentinCar0n/multiclaude) | 1.11 | macOS 15 Sequoia or later | Menu bar app to run several Claude desktop accounts side by side |

Details per cask, read from [`Casks/`](Casks):

- **`multiclaude`** ([`Casks/multiclaude.rb`](Casks/multiclaude.rb)). Downloads `MultiClaude-<version>.zip` from the [MultiClaude releases](https://github.com/QuentinCar0n/multiclaude/releases), installs `MultiClaude.app` and links the `multiclaude` command line tool from `MultiClaude.app/Contents/Helpers/multiclaude` onto your `PATH`. MultiClaude opens the Claude desktop app, which must be installed in `/Applications` ([download Claude](https://claude.ai/download)).

## Install

Tap once, then install any cask by its short name:

```bash
brew tap quentincar0n/tap
brew install --cask multiclaude
```

Or in one line, without a separate tap step:

```bash
brew install --cask quentincar0n/tap/multiclaude
```

## Update

```bash
brew update
brew upgrade --cask multiclaude
```

Each cask has a `livecheck` block that follows the app's latest GitHub release, so `brew livecheck quentincar0n/tap/multiclaude` shows whether the tap is behind the newest release.

## Uninstall

```bash
brew uninstall --cask multiclaude          # quits the app, then removes it
brew uninstall --cask --zap multiclaude    # also removes ~/Library/Preferences/me.somalabs.multiclaude.plist
brew untap quentincar0n/tap                # removes the tap itself
```

## Why a personal tap

The apps in this tap are ad hoc signed and not notarized by Apple. The official `homebrew/cask` repository only takes apps that pass macOS Gatekeeper, so these casks are published here instead.

Because the apps aren't notarized, macOS would block their first launch. Each cask handles that with a `postflight` step that removes the quarantine attribute from the installed app:

```ruby
run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MultiClaude.app"]
```

Only install from this tap if you trust the app's source. MultiClaude's source is public at [QuentinCar0n/multiclaude](https://github.com/QuentinCar0n/multiclaude).

## FAQ

**How do I install MultiClaude with Homebrew?**
Run `brew install --cask quentincar0n/tap/multiclaude`. It installs `MultiClaude.app` in your Applications folder and the `multiclaude` command on your `PATH`.

**What does `brew tap quentincar0n/tap` do?**
It adds this repository (`QuentinCar0n/homebrew-tap`) to Homebrew as a source of casks. Homebrew drops the `homebrew-` prefix from the repository name, so the tap is called `quentincar0n/tap`.

**Why isn't MultiClaude in the official Homebrew cask repository?**
It's ad hoc signed and not notarized by Apple, and `homebrew/cask` only takes apps that pass Gatekeeper. A personal tap has no such rule.

**macOS says the app is damaged or can't be opened. What do I do?**
That's Gatekeeper reacting to the quarantine flag on an app that isn't notarized. The cask's `postflight` step already removes it on install. If you still see the message (for example after copying the app by hand), run `xattr -dr com.apple.quarantine /Applications/MultiClaude.app`, or right-click the app and choose Open.

**Which macOS version do I need?**
The `multiclaude` cask declares `depends_on macos: :sequoia`, so macOS 15 or later.

**How do I update an app installed from this tap?**
Run `brew update` then `brew upgrade --cask multiclaude`.

**How do I remove MultiClaude and its settings?**
`brew uninstall --cask --zap multiclaude` quits the app, removes it and deletes its preferences file. Your Claude account data folders are not part of the cask and stay where they are.

**Does the cask install the `multiclaude` command line tool?**
Yes. The cask links `MultiClaude.app/Contents/Helpers/multiclaude` as a binary, so `multiclaude` works in any terminal after install.

**Is Cocaine in this tap?**
No. Cocaine, the menu bar keep-awake app, is distributed as a zip from [QuentinCar0n/cocaine-releases](https://github.com/QuentinCar0n/cocaine-releases) and updates itself.

## Documentation

- [`Casks/multiclaude.rb`](Casks/multiclaude.rb): the MultiClaude cask
- [MultiClaude README](https://github.com/QuentinCar0n/multiclaude#readme): features, command line tool, FAQ
- [llms.txt](llms.txt): a short index of this repository for language models

## Related projects

- [MultiClaude](https://github.com/QuentinCar0n/multiclaude): menu bar app to run several Claude desktop accounts on one Mac
- [Cocaine releases](https://github.com/QuentinCar0n/cocaine-releases): release builds of Cocaine, a menu bar keep-awake app for macOS

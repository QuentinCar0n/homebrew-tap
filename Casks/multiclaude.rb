cask "multiclaude" do
  version "1.3.2"
  sha256 "8ea0a9da2045b0223c2c9a6f8f3393a8d8cb2101bc721e4358dda720a23fe76b"

  url "https://github.com/QuentinCar0n/multiclaude/releases/download/v#{version}/MultiClaude-#{version}.zip"
  name "MultiClaude"
  desc "Menu bar app to run several Claude desktop accounts side by side"
  homepage "https://github.com/QuentinCar0n/multiclaude"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "MultiClaude.app"

  # The app is ad hoc signed and not notarized, so Gatekeeper would block the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MultiClaude.app"]
  end

  uninstall quit: "me.somalabs.multiclaude"

  zap trash: "~/Library/Preferences/me.somalabs.multiclaude.plist"

  caveats <<~EOS
    MultiClaude opens the Claude desktop app, which must be in /Applications:
      https://claude.ai/download
  EOS
end

cask "multiclaude" do
  version "1.0"
  sha256 "f10ed16b5f019bf0dafb3e6ffa0b29cefbad230832beae62ebf0a08a4e58b860"

  url "https://github.com/QuentinCar0n/multiclaude/releases/download/v#{version}/MultiClaude-#{version}.zip"
  name "MultiClaude"
  desc "Menu bar app to run several Claude desktop accounts on one Mac"
  homepage "https://github.com/QuentinCar0n/multiclaude"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"

  app "MultiClaude.app"

  # The app is ad hoc signed and not notarized, so Gatekeeper would block the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MultiClaude.app"]
  end

  uninstall quit: "me.somalabs.multiclaude"

  zap trash: "~/Library/Preferences/me.somalabs.multiclaude.plist"

  caveats <<~EOS
    MultiClaude opens the Claude desktop app, which must be in /Applications:
      https://claude.ai/download
  EOS
end

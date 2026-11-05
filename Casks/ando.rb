cask "ando" do
  arch arm: "arm64", intel: "x64"

  version "1.0.91"
  sha256 arm:   "eedb2a035c9173fb4eddd031ce28b8fe3c1603c7e9bac52fde819248937fb65f",
         intel: "628c9631fee4b730d73e7520b18d8ee67fbc8b84c4fc1ef26e3693c76eeb5292"

  url "https://updates.ando.so/desktop/production/Ando-#{version}-#{arch}-mac.dmg"
  name "Ando"
  desc "AI-native team workspace"
  homepage "https://ando.so/"

  livecheck do
    url "https://updates.ando.so/desktop/production/latest-mac.yml"
    strategy :electron_builder
  end

  auto_updates true
  depends_on macos: :ventura

  app "Ando.app"

  postflight_steps do
    mkdir_p "Library/Application Support/Ando", base: :home
    write_file "Library/Application Support/Ando/install-source.json", <<~JSON, base: :home
      {
        "source": "homebrew-cask",
        "cask": "ando",
        "version": "#{version}"
      }
    JSON
  end

  uninstall quit: "com.todesktop.251226pzrooli"

  zap trash: [
    "~/Library/Application Support/Ando",
    "~/Library/Caches/com.ando.app",
    "~/Library/Caches/com.todesktop.251226pzrooli",
    "~/Library/HTTPStorages/com.ando.app",
    "~/Library/HTTPStorages/com.todesktop.251226pzrooli",
    "~/Library/Logs/Ando",
    "~/Library/Preferences/com.ando.app.plist",
    "~/Library/Preferences/com.todesktop.251226pzrooli.plist",
    "~/Library/Saved Application State/com.ando.app.savedState",
    "~/Library/Saved Application State/com.todesktop.251226pzrooli.savedState",
  ]
end

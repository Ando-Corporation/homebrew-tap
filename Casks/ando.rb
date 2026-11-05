cask "ando" do
  arch arm: "arm64", intel: "x64"

  version "1.0.92"
  sha256 arm:   "31afdf0a15786d9489be45d3b938f388cdf712658544e710a0ad480c7c691088",
         intel: "49049941f856d9d27892ab172132d0d04437ac468baa48043c3927faee4b3b42"

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

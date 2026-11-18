cask "ando" do
  arch arm: "arm64", intel: "x64"

  version "1.0.131"
  sha256 arm:   "66afc4f071cb7d359e8477c32a6acc31775e091ebc87bae4234236e6c5ee3405",
         intel: "439aa52b3639ec0b331cea56eac8a420fab57951b89d887f7961f1037c325430"

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

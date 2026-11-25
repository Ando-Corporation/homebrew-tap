cask "ando" do
  arch arm: "arm64", intel: "x64"

  version "1.0.154"
  sha256 arm:   "0bb2509b7e5e6698977476a130b177cccd8c3d6c1fefdb0ec507d229c63a35d2",
         intel: "5a671ed54e6853a0bc991c48f807551a6589df8a41760118fd928a59d6e0eae2"

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

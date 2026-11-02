cask "ando" do
  arch arm: "arm64", intel: "x64"

  version "1.0.82"
  sha256 arm:   "88151d1efa9582dd740406914953355dadf73e277756d84494aefd2fd607804a",
         intel: "0260b87e0df2e1ac956b9c81e31de998af24b193411a458e4d1f31b32bfdf79d"

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

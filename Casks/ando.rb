cask "ando" do
  todesktop_app_id = "251226pzrooli"

  arch arm: "arm64", intel: "x64"

  version "1.0.17,260514nv30o5to8"
  sha256 arm:   "b5a032877387f141c4b97275f2a233761de5c95ba7c8b2c86f73e7d9fb50b198",
         intel: "56773f835ff1546c205f5a6077c2c02636e224c33ac5539b002b4e1f6895aba5"

  url "https://download.todesktop.com/#{todesktop_app_id}/Ando%20#{version.csv.first}%20-%20Build%20#{version.csv.second}-#{arch}.dmg",
      verified: "download.todesktop.com/#{todesktop_app_id}/"
  name "Ando"
  desc "AI-native team workspace"
  homepage "https://ando.so/"

  livecheck do
    url "https://download.todesktop.com/#{todesktop_app_id}/latest-mac.yml"
    strategy :electron_builder do |yaml|
      match = yaml["files"]&.filter_map do |file|
        file["url"]&.match(/Build ([^-]+)-(?:arm64|x64)\.dmg/i)
      end&.first

      "#{yaml["version"]},#{match[1]}" if yaml["version"] && match
    end
  end

  depends_on macos: :big_sur

  app "Ando.app"

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

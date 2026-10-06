cask "ando" do
  todesktop_app_id = "251226pzrooli"

  arch arm: "arm64", intel: "x64"

  version "1.0.48,261005m61chb53i"
  sha256 arm:   "b038d8723b1257b8d7efbaec43d9f2ef91e6a9fa79a9cf4492fd2e43613a3f24",
         intel: "2a6eaafb45ab7a01a49a1cae2b59414816b8dbe334ee6237003fc3b75adfbc6e"

  url "https://download.todesktop.com/#{todesktop_app_id}/Ando%20#{version.csv.first}%20-%20Build%20#{version.csv.second}-#{arch}.dmg"
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

  depends_on macos: :ventura

  app "Ando.app"

  postflight_steps do
    mkdir_p "~/Library/Application Support/Ando"
    write_file "~/Library/Application Support/Ando/install-source.json", <<~JSON
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

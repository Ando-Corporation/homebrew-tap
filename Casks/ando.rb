cask "ando" do
  todesktop_app_id = "251226pzrooli"

  arch arm: "arm64", intel: "x64"

  version "1.0.19,260519mn9el4utn"
  sha256 arm:   "d2ae79fa9204d24c783794ec1facb5ffbbdfb45e9145c3ac7009c5fb87965092",
         intel: "be579a764772a5d3410e6295585a24445dfbb26af43330c5435f85f1738897bf"

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

  depends_on macos: :monterey

  app "Ando.app"

  postflight_steps do
    mkdir_p "~/Library/Application Support/Ando"
    run "/bin/sh",
        args:        ["-c", <<~SH, "--", "{{version}}"],
          installed_at=$(/bin/date -u +%Y-%m-%dT%H:%M:%SZ)
          printf '{"source":"homebrew-cask","cask":"ando","version":"%s","installedAt":"%s"}\n' "$1" "$installed_at"
        SH
        stdout_path: "~/Library/Application Support/Ando/install-source.json"
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

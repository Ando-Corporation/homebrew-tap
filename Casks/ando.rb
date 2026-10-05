cask "ando" do
  todesktop_app_id = "251226pzrooli"

  arch arm: "arm64", intel: "x64"

  version "1.0.40,260916xjydek6jc"
  sha256 arm:   "95af84753bcc139077e6a99ca8495c9475a6912806302ccb929d6ee5a9b91bd6",
         intel: "3f70f2ce44b2252f0083d8e53ceec5aa382c4983d567eb0e15d2814222288a10"

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

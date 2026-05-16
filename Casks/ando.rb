cask "ando" do
  todesktop_app_id = "251226pzrooli"
  write_install_source_marker = lambda do
    marker_dir = Pathname.new("~/Library/Application Support/Ando").expand_path
    installed_at = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
    marker_dir.mkpath
    (marker_dir/"install-source.json").write <<~JSON
      {
        "source": "homebrew-cask",
        "cask": "ando",
        "version": "#{version}",
        "installedAt": "#{installed_at}"
      }
    JSON
  end

  arch arm: "arm64", intel: "x64"

  version "1.0.18,2605168y6m0ftnh"
  sha256 arm:   "0c6dbd64756e976820133065042f7e6da8c027d1d6fede293b6ab53091d363cd",
         intel: "09de3268fa9172e7694ced0bf024a8eab6ba46801bb92abcf0a261a9aa1ea0dd"

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

  postflight do
    write_install_source_marker.call
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

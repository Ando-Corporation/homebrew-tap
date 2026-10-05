# frozen_string_literal: true

require "cask/cask_loader"
require "tmpdir"
require "time"

cask = Cask::CaskLoader.load(File.read(File.expand_path("../Casks/ando.rb", __dir__)))
artifact = cask.artifacts.find { |item| item.is_a?(Cask::Artifact::PostflightSteps) }
raise "Missing postflight steps" unless artifact

# Exercise the JSON-serialised steps without touching the user's Ando profile.
Dir.mktmpdir("ando-marker-", __dir__) do |directory|
  marker_directory = File.join(directory, "Library/Application Support/Ando")
  steps = JSON.parse(JSON.generate(artifact.steps).gsub("~/Library/Application Support/Ando", marker_directory))
  marker_path = File.join(marker_directory, "install-source.json")
  runner = Homebrew::InstallSteps::Runner.new(context: cask)

  ["fresh install", "upgrade"].each do |phase|
    if phase == "upgrade"
      File.write(marker_path, JSON.generate(source: "old", cask: "ando", version: "0.0.0",
                                            installedAt: "2000-01-01T00:00:00Z"))
    end
    started_at = Time.now.utc.to_i
    runner.run(steps)
    marker = JSON.parse(File.read(marker_path))
    raise "Wrong source after #{phase}" if marker.fetch("source") != "homebrew-cask"
    raise "Wrong cask after #{phase}" if marker.fetch("cask") != "ando"
    raise "Wrong version after #{phase}" if marker.fetch("version") != cask.version.to_s

    installed_at = Time.iso8601(marker.fetch("installedAt"))
    raise "Stale timestamp after #{phase}" unless installed_at.to_i.between?(started_at, Time.now.utc.to_i)
    raise "Timestamp must use UTC" unless marker.fetch("installedAt").end_with?("Z")

    puts "Install marker: #{phase} passed"
  end
end

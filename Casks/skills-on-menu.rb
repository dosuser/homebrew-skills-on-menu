cask "skills-on-menu" do
  version "1.1.0"
  sha256 "cca6f0bc06de356daa6fc57a5ff2f3c08706560a95b9e0fe4a220a72cbb771c5"

  url "https://github.com/dosuser/skills-on-menu/releases/download/v#{version}/SkillsOnMenu-#{version}.zip"
  name "SkillsOnMenu"
  desc "Launch Claude Code skills and MCP workflows from the macOS menu bar"
  homepage "https://github.com/dosuser/skills-on-menu"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "SkillsOnMenu.app"

  # ad-hoc 서명 빌드(Apple 공증 없음)라 다운로드된 앱은 Gatekeeper가 막는다.
  # 최초 실행 전에 quarantine 속성을 제거해 정상적으로 열리게 한다.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SkillsOnMenu.app"]
  end

  zap trash: [
    "~/.config/skillsonmenu",
    "~/.config/skilldock",
    "~/Library/Preferences/com.dosuser.skillsonmenu.plist",
    "~/Library/Preferences/com.dosuser.skilldock.plist",
  ]
end

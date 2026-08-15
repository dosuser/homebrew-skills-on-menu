cask "skilldock" do
  version "1.0.0"
  sha256 "3eacb1e153480e4a5c2091634306379cbfabada0b351d5baec68d17bd2b84a1c"

  url "https://github.com/dosuser/skilldock/releases/download/v#{version}/SkillDock-#{version}.zip"
  name "SkillDock"
  desc "맥 메뉴바에서 Claude Code 스킬과 MCP 서버를 버튼 하나로 실행하는 런처"
  homepage "https://github.com/dosuser/skilldock"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "SkillDock.app"

  # ad-hoc 서명 빌드(Apple 공증 없음)라 다운로드된 앱은 Gatekeeper가 막는다.
  # 최초 실행 전에 quarantine 속성을 제거해 정상적으로 열리게 한다.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SkillDock.app"]
  end

  zap trash: [
    "~/.config/skilldock",
    "~/Library/Preferences/com.dosuser.skilldock.plist",
  ]
end

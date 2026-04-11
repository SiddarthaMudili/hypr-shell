import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: appTray

    implicitHeight: 35
    implicitWidth:  trayRow.implicitWidth + (trayRow.count > 0 ? 8 : 0)

    // Deduplicated list of running app classes from hyprctl clients -j
    property var activeApps: []

    Process {
        id: clientsPoller
        command: ["hyprctl", "clients", "-j"]
        running: false

        property string buffer: ""

        stdout: SplitParser {
            onRead: data => clientsPoller.buffer += data
        }

        onRunningChanged: {
            if (!running && buffer !== "") {
                try {
                    const clients = JSON.parse(buffer)
                    const hidden  = { "quickshell":1, "kitty":1, "alacritty":1, "foot":1, "wezterm":1, "org.wezfurlong.wezterm":1 }
                    let seen = {}
                    let apps = []
                    for (let i = 0; i < clients.length; i++) {
                        const cls = (clients[i].class || "").trim()
                        if (!cls || hidden[cls.toLowerCase()] || seen[cls]) continue
                        seen[cls] = true
                        apps.push(cls)
                    }
                    appTray.activeApps = apps
                } catch (e) {}
                buffer = ""
            } else if (running) {
                buffer = ""
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: clientsPoller.running = true
    }

    function icon(cls) {
        const map = {
            "firefox":             "󰈹",
            "zen":                 "◎",
            "chromium":            "󰊯",
            "google-chrome":       "󰊯",
            "brave-browser":       "󰇣",
            "qutebrowser":         "󰇜",
            "slack":               "󰒱",
            "discord":             "󰙯",
            "steam":               "󰓅",
            "notion-app-enhanced": "󰠮",
            "notion-app":          "󰠮",
            "spotify":             "󰓇",
            "code":                "󰨞",
            "code-oss":            "󰨞",
            "vscodium":            "󰨞",
            "neovide":             "",
            "kitty":               "",
            "alacritty":           "",
            "foot":                "",
            "wezterm":             "",
            "thunar":              "󰉋",
            "nautilus":            "󰉋",
            "telegram-desktop":    "󰔁",
            "signal":              "󱅤",
            "obsidian":            "󰎐",
            "gimp":                "󰃤",
            "inkscape":            "",
            "vlc":                 "󰕼",
            "mpv":                 "",
            "thunderbird":         "󰊫",
            "element":             "󰭕",
            "zoom":                "󰜖",
            "teams-for-linux":     "󰭻",
            "bitwarden":           "󰌋",
            "1password":           "󰌋",
            "figma-linux":         "󰈸",
            "postman":             "󰫧",
            "insomnia":            "󰫧",
            "headlamp":            "󱃾",
            "lutris":              "󰺵",
            "heroic":              "󰺵",
            "virtualbox":          "󰕙",
            "virt-manager":        "󰕙",
        }
        const lower = cls.toLowerCase()
        for (const key of Object.keys(map)) {
            if (lower === key || lower.startsWith(key)) return map[key]
        }
        return "󰣆"
    }

    Row {
        id: trayRow
        anchors.centerIn: parent
        spacing: 2

        property int count: appTray.activeApps.length

        Repeater {
            model: appTray.activeApps

            delegate: MouseArea {
                id: appBtn

                required property string modelData
                required property int    index

                readonly property string appClass: modelData

                width: 30; height: 30
                anchors.verticalCenter: parent.verticalCenter
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                opacity: 0
                Component.onCompleted: opacity = 1
                Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }

                Rectangle {
                    anchors.fill: parent
                    radius: 6
                    color: appBtn.pressed
                        ? Qt.rgba(ThemeManager.accentBlue.r, ThemeManager.accentBlue.g, ThemeManager.accentBlue.b, 0.25)
                        : appBtn.containsMouse
                            ? Qt.rgba(1, 1, 1, 0.10)
                            : "transparent"
                    Behavior on color { ColorAnimation { duration: 150 } }
                }

                Text {
                    anchors.centerIn: parent
                    text: appTray.icon(appBtn.appClass)
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 16
                    color: ThemeManager.fgPrimary
                }

                onClicked: Quickshell.execDetached([
                    "hyprctl", "dispatch", "focuswindow", "class:" + appClass
                ])
            }
        }
    }
}

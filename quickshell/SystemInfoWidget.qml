import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick.Effects

Rectangle {
    id: root

    width: 800
    height: 600
    color: Qt.rgba(ThemeManager.bgBase.r, ThemeManager.bgBase.g, ThemeManager.bgBase.b, 0.92)
    radius: 16
    border.width: 1
    border.color: Qt.rgba(ThemeManager.accentBlue.r, ThemeManager.accentBlue.g, ThemeManager.accentBlue.b, 0.35)
    antialiasing: true
    
    property bool isVisible: false
    property bool enableBlur: false
    property int currentTab: 0
    
    signal requestClose()
    
    focus: true
    
    Keys.onEscapePressed: {
        root.requestClose()
    }
    
    // Load blur setting
    onIsVisibleChanged: {
        if (isVisible) {
            blurSettingsLoader.running = true
        }
    }
    
    Process {
        id: blurSettingsLoader
        running: false
        command: ["cat", Quickshell.env("HOME") + "/.config/quickshell/settings.json"]
        
        property string buffer: ""
        
        stdout: SplitParser {
            onRead: data => {
                blurSettingsLoader.buffer += data
            }
        }
        
        onRunningChanged: {
            if (!running && buffer !== "") {
                try {
                    const settings = JSON.parse(buffer)
                    if (settings.general && settings.general.enableBlur !== undefined) {
                        root.enableBlur = settings.general.enableBlur
                    }
                } catch (e) {}
                buffer = ""
            } else if (running) {
                buffer = ""
            }
        }
    }
    
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16

        // ── Tab Bar
        Rectangle {
            width: parent.width
            height: 50
            color: Qt.rgba(1, 1, 1, 0.07)
            radius: 10
            border.width: 1
            border.color: Qt.rgba(1, 1, 1, 0.10)

            Row {
                anchors.centerIn: parent
                spacing: 8

                // Calendar Tab
                Rectangle {
                    width: 110
                    height: 38
                    radius: 8
                    color: root.currentTab === 0 ? Qt.rgba(ThemeManager.accentBlue.r, ThemeManager.accentBlue.g, ThemeManager.accentBlue.b, 0.30) : "transparent"
                    border.width: root.currentTab === 0 ? 1 : 0
                    border.color: Qt.rgba(ThemeManager.accentBlue.r, ThemeManager.accentBlue.g, ThemeManager.accentBlue.b, 0.55)

                    Behavior on color { ColorAnimation { duration: 150 } }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.currentTab = 0
                    }

                    Row {
                        anchors.centerIn: parent
                        spacing: 8

                        Text {
                            text: "📅"
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "Calendar"
                            font.family: "Sen"
                            font.pixelSize: 14
                            font.weight: Font.Medium
                            color: ThemeManager.fgPrimary
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                // Weather Tab
                Rectangle {
                    width: 110
                    height: 38
                    radius: 8
                    color: root.currentTab === 1 ? Qt.rgba(ThemeManager.accentBlue.r, ThemeManager.accentBlue.g, ThemeManager.accentBlue.b, 0.30) : "transparent"
                    border.width: root.currentTab === 1 ? 1 : 0
                    border.color: Qt.rgba(ThemeManager.accentBlue.r, ThemeManager.accentBlue.g, ThemeManager.accentBlue.b, 0.55)

                    Behavior on color { ColorAnimation { duration: 150 } }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.currentTab = 1
                    }

                    Row {
                        anchors.centerIn: parent
                        spacing: 8

                        Text {
                            text: "⛅"
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "Weather"
                            font.family: "Sen"
                            font.pixelSize: 14
                            font.weight: Font.Medium
                            color: ThemeManager.fgPrimary
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                // System Tab
                Rectangle {
                    width: 110
                    height: 38
                    radius: 8
                    color: root.currentTab === 2 ? Qt.rgba(ThemeManager.accentBlue.r, ThemeManager.accentBlue.g, ThemeManager.accentBlue.b, 0.30) : "transparent"
                    border.width: root.currentTab === 2 ? 1 : 0
                    border.color: Qt.rgba(ThemeManager.accentBlue.r, ThemeManager.accentBlue.g, ThemeManager.accentBlue.b, 0.55)

                    Behavior on color { ColorAnimation { duration: 150 } }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.currentTab = 2
                    }

                    Row {
                        anchors.centerIn: parent
                        spacing: 8

                        Text {
                            text: "💻"
                            font.pixelSize: 18
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "System"
                            font.family: "Sen"
                            font.pixelSize: 14
                            font.weight: Font.Medium
                            color: ThemeManager.fgPrimary
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                // Music Tab
                Rectangle {
                    width: 110
                    height: 38
                    radius: 8
                    color: root.currentTab === 3 ? Qt.rgba(ThemeManager.accentPurple.r, ThemeManager.accentPurple.g, ThemeManager.accentPurple.b, 0.30) : "transparent"
                    border.width: root.currentTab === 3 ? 1 : 0
                    border.color: Qt.rgba(ThemeManager.accentPurple.r, ThemeManager.accentPurple.g, ThemeManager.accentPurple.b, 0.55)

                    Behavior on color { ColorAnimation { duration: 150 } }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.currentTab = 3
                    }

                    Row {
                        anchors.centerIn: parent
                        spacing: 8

                        Text {
                            text: "󰎄"
                            font.family: "Symbols Nerd Font"
                            font.pixelSize: 16
                            color: root.currentTab === 3 ? ThemeManager.accentPurple : ThemeManager.fgPrimary
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "Music"
                            font.family: "Sen"
                            font.pixelSize: 14
                            font.weight: Font.Medium
                            color: ThemeManager.fgPrimary
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
        
        // Tab Content
        Rectangle {
            width: parent.width
            height: parent.height - 66
            color: "transparent"
            
            // Calendar Tab Content
            CalendarTab {
                id: calendarTab
                anchors.fill: parent
                visible: root.currentTab === 0
                active: root.isVisible && root.currentTab === 0
            }
            
            // Weather Tab Content
            WeatherTab {
                id: weatherTab
                anchors.fill: parent
                visible: root.currentTab === 1
                active: root.isVisible && root.currentTab === 1
            }
            
            // System Tab Content
            SystemTab {
                id: systemTab
                anchors.fill: parent
                visible: root.currentTab === 2
                active: root.isVisible && root.currentTab === 2
            }

            // Music Tab Content — driven by playerctl (reliable, no Quickshell MPRIS quirks)
            Item {
                id: musicTab
                anchors.fill: parent
                visible: root.currentTab === 3

                // Polled track state
                property string trackTitle:  ""
                property string trackArtist: ""
                property string trackAlbum:  ""
                property string artUrl:      ""
                property bool   isPlaying:   false
                property bool   hasPlayer:   false
                property string _trackId:    ""  // title|artist key to detect real track changes

                Process {
                    id: playerctlPoller
                    command: ["playerctl", "metadata", "--format",
                              "{{status}}|{{xesam:title}}|{{xesam:artist}}|{{xesam:album}}|{{mpris:artUrl}}|{{xesam:url}}"]
                    running: false

                    property string buffer: ""
                    stdout: SplitParser {
                        onRead: data => playerctlPoller.buffer += data
                    }
                    onRunningChanged: {
                        if (!running) {
                            const raw = buffer.trim()
                            buffer = ""
                            if (raw === "" || raw.startsWith("No players")) {
                                musicTab.hasPlayer   = false
                                musicTab.isPlaying   = false
                                musicTab.trackTitle  = ""
                                musicTab.trackArtist = ""
                                musicTab.trackAlbum  = ""
                                musicTab.artUrl      = ""
                                musicTab._trackId    = ""
                            } else {
                                const parts    = raw.split("|")
                                const title    = (parts[1] || "").trim()
                                const artist   = (parts[2] || "").trim()
                                const newId    = title + "|" + artist
                                const freshArt = (parts[4] || "").trim()
                                const pageUrl  = (parts[5] || "").trim()

                                musicTab.hasPlayer   = true
                                musicTab.isPlaying   = (parts[0] || "").trim() === "Playing"
                                musicTab.trackTitle  = title
                                musicTab.trackArtist = artist
                                musicTab.trackAlbum  = (parts[3] || "").trim()

                                let art = ""
                                if (freshArt !== "") {
                                    // MPRIS artUrl available — normalize Google image size to 512px
                                    art = freshArt.replace(/=w\d+-h\d+[^&\s]*/g, "=w512-h512-l90-rj")
                                } else if (pageUrl !== "") {
                                    // Fallback: extract YouTube/YTM video ID and use thumbnail API
                                    // Handles: youtube.com/watch?v=ID and music.youtube.com/watch?v=ID
                                    const match = pageUrl.match(/[?&]v=([\w-]{11})/)
                                    if (match) {
                                        art = "https://img.youtube.com/vi/" + match[1] + "/maxresdefault.jpg"
                                    }
                                }

                                if (art !== "") {
                                    musicTab.artUrl   = art
                                    musicTab._trackId = newId
                                } else if (newId !== musicTab._trackId) {
                                    musicTab.artUrl   = ""
                                    musicTab._trackId = newId
                                }
                                // Same track, no art this poll — keep whatever is currently shown
                            }
                        } else {
                            buffer = ""
                        }
                    }
                }

                Timer {
                    interval: 2000; running: true; repeat: true; triggeredOnStart: true
                    onTriggered: playerctlPoller.running = true
                }

                // Nothing playing state
                Column {
                    anchors.centerIn: parent
                    spacing: 16
                    visible: !musicTab.hasPlayer

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "󰝛"
                        font.family: "Symbols Nerd Font"
                        font.pixelSize: 64
                        color: Qt.rgba(ThemeManager.fgTertiary.r, ThemeManager.fgTertiary.g, ThemeManager.fgTertiary.b, 0.3)
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Nothing playing"
                        font.family: "Sen"; font.pixelSize: 15
                        color: Qt.rgba(ThemeManager.fgTertiary.r, ThemeManager.fgTertiary.g, ThemeManager.fgTertiary.b, 0.5)
                    }
                }

                // Player UI — full-height rich layout
                Column {
                    anchors.centerIn: parent
                    spacing: 18
                    visible: musicTab.hasPlayer
                    width: parent.width

                    // ── Album art (full-width wrapper so Column centering works)
                    Item {
                        width: parent.width
                        height: 160

                        Item {
                            id: artContainer
                            width: 160; height: 160
                            anchors.centerIn: parent

                            // Gradient placeholder + fallback icon (always visible under the image)
                            Rectangle {
                                anchors.fill: parent
                                radius: 16
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: Qt.rgba(ThemeManager.accentPurple.r, ThemeManager.accentPurple.g, ThemeManager.accentPurple.b, 0.38) }
                                    GradientStop { position: 1.0; color: Qt.rgba(ThemeManager.bgBase.r, ThemeManager.bgBase.g, ThemeManager.bgBase.b, 0.85) }
                                }

                                Text {
                                    id: artIcon
                                    anchors.centerIn: parent
                                    text: "󰎄"
                                    font.family: "Symbols Nerd Font"
                                    font.pixelSize: 68
                                    color: Qt.rgba(ThemeManager.accentPurple.r, ThemeManager.accentPurple.g, ThemeManager.accentPurple.b, 0.88)
                                    visible: musicTab.artUrl === ""

                                    SequentialAnimation on scale {
                                        id: breathAnim
                                        running: musicTab.isPlaying && musicTab.artUrl === ""
                                        loops: Animation.Infinite
                                        onRunningChanged: if (!running) breathReset.start()
                                        NumberAnimation { to: 1.09; duration: 900; easing.type: Easing.InOutSine }
                                        NumberAnimation { to: 1.00; duration: 900; easing.type: Easing.InOutSine }
                                    }
                                    NumberAnimation {
                                        id: breathReset
                                        target: artIcon; property: "scale"; to: 1.0; duration: 300
                                    }
                                }
                            }

                            // Shared rounded mask for both crossfade layers
                            Rectangle {
                                id: artRoundMask
                                anchors.fill: parent
                                radius: 16
                                color: "white"
                                visible: false
                                layer.enabled: true
                            }

                            // Crossfade image A (off-screen source for MultiEffect A)
                            Image {
                                id: imgA
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectCrop
                                smooth: true
                                mipmap: true
                                sourceSize { width: 512; height: 512 }
                                asynchronous: true
                                visible: false
                                // maxresdefault not always available — fall back to hqdefault
                                onStatusChanged: {
                                    if (status === Image.Error && source.toString().includes("maxresdefault"))
                                        source = source.toString().replace("maxresdefault", "hqdefault")
                                }
                            }

                            // Crossfade image B (off-screen source for MultiEffect B)
                            Image {
                                id: imgB
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectCrop
                                smooth: true
                                mipmap: true
                                sourceSize { width: 512; height: 512 }
                                asynchronous: true
                                visible: false
                                onStatusChanged: {
                                    if (status === Image.Error && source.toString().includes("maxresdefault"))
                                        source = source.toString().replace("maxresdefault", "hqdefault")
                                }
                            }

                            // MultiEffect A — visible when showA && imgA is ready
                            MultiEffect {
                                anchors.fill: parent
                                source: imgA
                                maskEnabled: true
                                maskSource: artRoundMask
                                maskThresholdMin: 0.5
                                maskSpreadAtMin: 1.0
                                opacity: artManager.showA && imgA.status === Image.Ready ? 1.0 : 0.0
                                Behavior on opacity { NumberAnimation { duration: 300 } }
                            }

                            // MultiEffect B — visible when !showA && imgB is ready
                            MultiEffect {
                                anchors.fill: parent
                                source: imgB
                                maskEnabled: true
                                maskSource: artRoundMask
                                maskThresholdMin: 0.5
                                maskSpreadAtMin: 1.0
                                opacity: !artManager.showA && imgB.status === Image.Ready ? 1.0 : 0.0
                                Behavior on opacity { NumberAnimation { duration: 300 } }
                            }

                            // Crossfade manager: loads into the inactive slot, swaps only when ready
                            QtObject {
                                id: artManager
                                property bool showA: true

                                function switchTo(url) {
                                    if (url === "") { imgA.source = ""; imgB.source = ""; return }
                                    if (showA) imgB.source = url
                                    else       imgA.source = url
                                }
                            }

                            Connections {
                                target: musicTab
                                function onArtUrlChanged() { artManager.switchTo(musicTab.artUrl) }
                            }
                            Connections {
                                target: imgA
                                function onStatusChanged() {
                                    if (imgA.status === Image.Ready && !artManager.showA)
                                        artManager.showA = true
                                }
                            }
                            Connections {
                                target: imgB
                                function onStatusChanged() {
                                    if (imgB.status === Image.Ready && artManager.showA)
                                        artManager.showA = false
                                }
                            }

                            // Border drawn on top (transparent fill — just the outline)
                            Rectangle {
                                anchors.fill: parent
                                radius: 16
                                color: "transparent"
                                border.width: 2
                                border.color: Qt.rgba(
                                    ThemeManager.accentPurple.r,
                                    ThemeManager.accentPurple.g,
                                    ThemeManager.accentPurple.b,
                                    musicTab.isPlaying ? 0.70 : 0.25
                                )
                                Behavior on border.color { ColorAnimation { duration: 600 } }
                            }
                        }
                    }

                    // ── Track info
                    Column {
                        width: parent.width * 0.78
                        anchors.horizontalCenter: undefined
                        x: (parent.width - width) / 2
                        spacing: 5

                        Text {
                            width: parent.width
                            text: musicTab.trackTitle || "Unknown track"
                            font.family: "Sen"; font.pixelSize: 21; font.weight: Font.Bold
                            color: ThemeManager.fgPrimary
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                        }
                        Text {
                            width: parent.width
                            text: musicTab.trackArtist || "Unknown artist"
                            font.family: "Sen"; font.pixelSize: 14
                            color: ThemeManager.fgSecondary
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                        }
                        Text {
                            width: parent.width
                            text: musicTab.trackAlbum
                            font.family: "Sen"; font.pixelSize: 11
                            color: Qt.rgba(ThemeManager.fgTertiary.r, ThemeManager.fgTertiary.g, ThemeManager.fgTertiary.b, 0.55)
                            horizontalAlignment: Text.AlignHCenter
                            elide: Text.ElideRight
                            visible: musicTab.trackAlbum !== ""
                        }
                    }

                    // ── Equalizer bars
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 4
                        height: 46

                        Repeater {
                            model: 18

                            Item {
                                property int barMaxH: [14, 30, 20, 42, 16, 38, 26, 44, 18, 34, 28, 40, 12, 36, 22, 42, 15, 28][index]
                                property int barDur:  [270, 320, 255, 345, 295, 265, 335, 280, 305, 260, 330, 285, 315, 270, 290, 310, 300, 325][index]

                                width: 6; height: 46

                                Rectangle {
                                    id: eqBar
                                    width: parent.width
                                    height: 3
                                    radius: 3
                                    anchors.bottom: parent.bottom
                                    color: Qt.rgba(
                                        ThemeManager.accentPurple.r,
                                        ThemeManager.accentPurple.g,
                                        ThemeManager.accentPurple.b,
                                        0.50 + (index % 4) * 0.12
                                    )

                                    SequentialAnimation {
                                        id: eqAnim
                                        running: musicTab.isPlaying
                                        loops: Animation.Infinite
                                        onRunningChanged: if (!running) eqReset.start()

                                        NumberAnimation {
                                            target: eqBar; property: "height"
                                            to: eqBar.parent.barMaxH
                                            duration: eqBar.parent.barDur
                                            easing.type: Easing.InOutSine
                                        }
                                        NumberAnimation {
                                            target: eqBar; property: "height"
                                            to: 3
                                            duration: eqBar.parent.barDur
                                            easing.type: Easing.InOutSine
                                        }
                                    }

                                    NumberAnimation {
                                        id: eqReset
                                        target: eqBar; property: "height"
                                        to: 3; duration: 250; easing.type: Easing.OutCubic
                                    }
                                }
                            }
                        }
                    }

                    // ── Controls
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 14

                        Repeater {
                            model: [
                                { icon: "󰒮", action: "prev", size: 20, w: 46 },
                                { icon: musicTab.isPlaying ? "󰏤" : "󰐊", action: "play", size: 28, w: 58 },
                                { icon: "󰒭", action: "next", size: 20, w: 46 }
                            ]

                            MouseArea {
                                required property var modelData
                                width: modelData.w; height: modelData.w
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true

                                Rectangle {
                                    anchors.fill: parent; radius: width / 2
                                    color: parent.containsMouse
                                        ? Qt.rgba(ThemeManager.accentPurple.r, ThemeManager.accentPurple.g, ThemeManager.accentPurple.b,
                                                  modelData.action === "play" ? 0.42 : 0.22)
                                        : modelData.action === "play"
                                        ? Qt.rgba(ThemeManager.accentPurple.r, ThemeManager.accentPurple.g, ThemeManager.accentPurple.b, 0.22)
                                        : Qt.rgba(1, 1, 1, 0.07)
                                    border.width: 1
                                    border.color: modelData.action === "play"
                                        ? Qt.rgba(ThemeManager.accentPurple.r, ThemeManager.accentPurple.g, ThemeManager.accentPurple.b, 0.55)
                                        : Qt.rgba(1, 1, 1, 0.12)
                                    Behavior on color { ColorAnimation { duration: 150 } }
                                }
                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.icon
                                    font.family: "Symbols Nerd Font"; font.pixelSize: modelData.size
                                    color: modelData.action === "play" ? ThemeManager.accentPurple : ThemeManager.fgPrimary
                                }
                                onClicked: {
                                    const cmd = modelData.action === "prev" ? "previous"
                                              : modelData.action === "next" ? "next" : "play-pause"
                                    Quickshell.execDetached(["playerctl", cmd])
                                    Qt.callLater(() => playerctlPoller.running = true)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Top specular highlight
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 120
        radius: 16
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 0.07) }
            GradientStop { position: 1.0; color: Qt.rgba(1, 1, 1, 0.0) }
        }
        z: 10
    }

    // Bottom fade
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 80
        radius: 16
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(0, 0, 0, 0.0) }
            GradientStop { position: 1.0; color: Qt.rgba(0, 0, 0, 0.12) }
        }
        z: 10
    }
}

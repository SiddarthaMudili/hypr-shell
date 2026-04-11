import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

RowLayout {
    id: workspaceBar
    spacing: 4

    property int activeId: {
        if (Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace)
            return Hyprland.focusedMonitor.activeWorkspace.id
        for (let i = 0; i < Hyprland.workspaces.length; i++) {
            if (Hyprland.workspaces[i].focused) return Hyprland.workspaces[i].id
        }
        return 1
    }

    // windowCounts: { wsId: windowCount } — polled from hyprctl so it's
    // always up-to-date regardless of toplevels reactivity issues.
    property var windowCounts: ({})

    Process {
        id: wsPoller
        command: ["hyprctl", "workspaces", "-j"]
        running: false

        property string buffer: ""

        stdout: SplitParser {
            onRead: data => wsPoller.buffer += data
        }

        onRunningChanged: {
            if (!running && buffer !== "") {
                try {
                    const list = JSON.parse(buffer)
                    let counts = {}
                    for (let i = 0; i < list.length; i++)
                        counts[list[i].id] = list[i].windows
                    workspaceBar.windowCounts = counts
                } catch (e) {}
                buffer = ""
            } else if (running) {
                buffer = ""
            }
        }
    }

    // Re-poll whenever the active workspace changes or every second as fallback
    onActiveIdChanged: wsPoller.running = true

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: wsPoller.running = true
    }

    function findWorkspace(wsId) {
        for (let i = 0; i < Hyprland.workspaces.length; i++) {
            if (Hyprland.workspaces[i].id === wsId) return Hyprland.workspaces[i]
        }
        return null
    }

    // Sliding window of exactly 5 IDs centred on activeId, clamped to [1, 10].
    // At the low end (1-3) snaps to 1-5; at the high end (8-10) snaps to 6-10.
    property var visibleIds: {
        const clampedId = Math.max(1, Math.min(10, activeId))
        const end   = Math.min(10, Math.max(clampedId + 2, 5))
        const start = Math.max(1,  end - 4)
        let ids = []
        for (let i = start; i <= end; i++) ids.push(i)
        return ids
    }

    Repeater {
        model: workspaceBar.visibleIds

        MouseArea {
            id: wsBtn

            required property int modelData

            property int  workspaceId: modelData
            property var  hyprWs:      workspaceBar.findWorkspace(workspaceId)
            property bool isActive:    workspaceId === workspaceBar.activeId
            property bool hasWindows:  (workspaceBar.windowCounts[workspaceId] || 0) > 0
            property bool isUrgent:    hyprWs !== null && hyprWs.urgent

            width: 40; height: 32
            hoverEnabled: true; cursorShape: Qt.PointingHandCursor; z: 10

            opacity: 0
            Component.onCompleted: opacity = 1
            Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }

            Rectangle {
                id: wsRect
                anchors.centerIn: parent
                width: 35; height: parent.height - 10; radius: 6

                color: {
                    if (wsBtn.isActive)      return Qt.rgba(ThemeManager.accentBlue.r, ThemeManager.accentBlue.g, ThemeManager.accentBlue.b, 0.30)
                    if (wsBtn.containsMouse) return Qt.rgba(1, 1, 1, 0.10)
                    return "transparent"
                }
                border.width: wsBtn.isActive || wsBtn.containsMouse ? 1 : 0
                border.color: wsBtn.isActive
                    ? Qt.rgba(ThemeManager.accentBlue.r, ThemeManager.accentBlue.g, ThemeManager.accentBlue.b, 0.55)
                    : Qt.rgba(1, 1, 1, 0.18)

                Behavior on color        { ColorAnimation  { duration: 150 } }
                Behavior on border.width { NumberAnimation { duration: 150 } }
            }

            Text {
                anchors.centerIn: wsRect
                text: wsBtn.workspaceId.toString()
                font.family: "Sen"; font.pixelSize: 13; font.bold: wsBtn.isActive
                textFormat: Text.PlainText
                color: {
                    if (wsBtn.isUrgent)                     return ThemeManager.accentRed
                    if (wsBtn.isActive || wsBtn.hasWindows) return ThemeManager.fgPrimary
                    return ThemeManager.fgTertiary
                }
                Behavior on color { ColorAnimation { duration: 200 } }
            }

            // Indicator dot — right side of the box, vertically centred
            Rectangle {
                anchors.right:         wsRect.right
                anchors.rightMargin:   4
                anchors.verticalCenter: wsRect.verticalCenter
                width: 4; height: 4; radius: 2
                visible: wsBtn.hasWindows
                color: wsBtn.isUrgent ? ThemeManager.accentRed
                     : wsBtn.isActive ? ThemeManager.accentBlue
                     : Qt.rgba(ThemeManager.fgPrimary.r, ThemeManager.fgPrimary.g, ThemeManager.fgPrimary.b, 0.45)

                Behavior on color { ColorAnimation { duration: 200 } }
            }

            onClicked: Quickshell.execDetached(["hyprctl", "dispatch", "workspace", workspaceId.toString()])
        }
    }
}

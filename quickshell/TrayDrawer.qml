import QtQuick
import Quickshell

Item {
    id: trayDrawer

    signal toggleClipboard()
    signal toggleControlCenter()

    height: 35
    width: contentRow.width

    Row {
        id: contentRow
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0

        //ClipboardManager {
        //    onToggleClipboard: trayDrawer.toggleClipboard()
        //}
        Updates {}
        SystemTray {
            onToggleControlCenter: trayDrawer.toggleControlCenter()
        }
    }
}

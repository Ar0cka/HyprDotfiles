import QtQuick
import Quickshell
import Quickshell.Widgets

PanelWindow {
    id: topBar

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 32
    exclusiveZone: 32
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        opacity: 0.96
        radius: 0
    }

    // Three regions reproduce Waybar's modules-left / center / right.
    Row {
        id: leftModules
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        spacing: 12

        Workspaces {}
        Spotify {}
    }

    Row {
        anchors.centerIn: parent
        spacing: 12

        Clock {}
        ControlSound {}
    }

    Row {
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        spacing: 12

        Notification {}
        Tray {}
    }
}

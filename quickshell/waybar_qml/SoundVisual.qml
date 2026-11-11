import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    property string bars: " "

    implicitWidth: visualText.implicitWidth + 18
    implicitHeight: visualText.implicitHeight + 4

    // Mirrors the Waybar CAVA pipeline. Requires ~/.config/cava/config_waybar.
    Process {
        id: cavaProcess
        command: ["bash", "-lc", "cava -p \"$HOME/.config/cava/config_waybar\" | sed -u 's/0/ /g; s/1/ /g; s/2/▂/g; s/3/▃/g; s/4/▄/g; s/5/▅/g; s/6/▆/g; s/7/▇/g; s/8/█/g'"]
        stdout: SplitParser {
            onRead: data => root.bars = data.trim()
        }
    }

    Component.onCompleted: cavaProcess.running = true

    Rectangle {
        implicitWidth: visualText.implicitWidth
        implicitHeight: visualText.implicitHeight

        anchors.fill: parent

        border.color: Theme.darkPrimaryContainer
        border.width: 3

        radius: 8

        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Theme.darkPrimary
            }
            GradientStop {
                position: 1.0
                color: Theme.darkSecondary
            }
        }
        Text {
            id: visualText
            color: Theme.lightOnSurface
            anchors.centerIn: parent
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13
            text: root.bars
        }
    }
}

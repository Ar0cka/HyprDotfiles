import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

WrapperRectangle {
    id: root

    implicitWidth: workspaceRow.implicitWidth + 16
    implicitHeight: 28

    radius: 8
    border.width: 2
    border.color: "transparent"

    // Градиент для рамки (внешний)
    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: Theme.darkPrimary
        }
        GradientStop {
            position: 1.0
            color: Theme.lightTertiaryContainer
        }
    }

    // Внутренний контент (фон)
    Rectangle {
        implicitWidth: workspaceRow.implicitWidth + 12
        implicitHeight: 24
        radius: 6

        // Фон контейнера (внутренний градиент)
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Theme.lightPrimary
            }
            GradientStop {
                position: 1.0
                color: Theme.darkTertiaryContainer
            }
        }

        Row {
            id: workspaceRow
            anchors.centerIn: parent
            spacing: 4

            Repeater {
                model: Hyprland.workspaces

                delegate: Rectangle {
                    required property var modelData
                    property bool active: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === modelData.id

                    implicitWidth: Math.max(workspaceLabel.implicitWidth + 10, 20)
                    implicitHeight: 18
                    radius: 4

                    // Фон активного воркспейса — сплошной цвет для контраста
                    color: active ? Theme.darkPrimaryContainer : "transparent"

                    Text {
                        id: workspaceLabel
                        anchors.centerIn: parent
                        text: modelData.name
                        color: Theme.darkPrimary
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 12
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + modelData.id)
                        onWheel: wheel => {}
                    }
                }
            }
        }
    }
}

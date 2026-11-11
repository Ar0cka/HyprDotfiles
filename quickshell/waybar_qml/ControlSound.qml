import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Widgets

WrapperRectangle {
    id: root

    property PwNode sink: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [root.sink]
    }

    implicitWidth: soundText.implicitWidth + 16
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

    Process {
        id: pavucontrol
        command: ["pavucontrol"]
    }

    // Внутренний контент (фон)
    Rectangle {
        implicitWidth: soundText.implicitWidth + 12
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

        Text {
            id: soundText
            anchors.centerIn: parent
            color: Theme.darkPrimary
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13

            text: {
                if (!root.sink?.ready || !root.sink.audio)
                    return "--% ";
                if (root.sink.audio.muted)
                    return "muted ";
                return Math.round((root.sink.audio.volume - 0.5) * 200) + "% ";
            }
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            onClicked: pavucontrol.running = true

            onWheel: wheel => {
                if (!root.sink?.ready || !root.sink.audio)
                    return;

                const delta = wheel.angleDelta.y > 0 ? 0.01 : -0.01;
                root.sink.audio.volume = Math.max(0.5, Math.min(1, root.sink.audio.volume + delta));
            }
        }
    }
}

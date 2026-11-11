import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

WrapperRectangle {
    id: root

    property string track: ""
    property bool spotifyAvailable: false

    implicitWidth: label.implicitWidth + 16
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
        id: metadataProcess
        command: ["bash", "-lc", "playerctl -p spotify metadata --format '{{ artist }} - {{ title }}' 2>/dev/null"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.track = text.trim();
                root.spotifyAvailable = root.track.length > 0;
            }
        }
        onExited: (code, status) => {
            if (code !== 0) {
                root.track = "";
                root.spotifyAvailable = false;
            }
        }
    }

    Process {
        id: playPauseProcess
        command: ["playerctl", "-p", "spotify", "play-pause"]
    }
    Process {
        id: nextProcess
        command: ["playerctl", "-p", "spotify", "next"]
    }
    Process {
        id: previousProcess
        command: ["playerctl", "-p", "spotify", "previous"]
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: metadataProcess.running = true
    }

    // Внутренний контент (фон)
    Rectangle {
        implicitWidth: label.implicitWidth + 12
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
            id: label
            color: Theme.darkPrimary
            anchors.centerIn: parent
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13
            text: root.spotifyAvailable ? " " + root.track : ""
            elide: Text.ElideRight
            maximumLineCount: 1
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            onClicked: playPauseProcess.running = true
            onWheel: wheel => {
                if (wheel.angleDelta.y > 0)
                    nextProcess.running = true;
                else if (wheel.angleDelta.y < 0)
                    previousProcess.running = true;
            }
        }
    }
}

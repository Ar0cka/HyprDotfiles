import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

WrapperRectangle {
    id: root

    implicitWidth: statusText.implicitWidth + 16
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

    property int exitCode: 0

    Process {
        id: dunstProcess
        command: ["dunstctl", "is-paused"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                var output = this.text.trim().toLowerCase();
                if (output === "true") {
                    statusText.text = "Notification Pause ⏸️";
                    statusText.color = Theme.darkPrimary;
                } else if (output === "false") {
                    statusText.text = "Notification Active 🟢";
                    statusText.color = Theme.darkPrimary;
                } else {
                    statusText.text = output || "unknown";
                    statusText.color = "gray";
                    root.exitCode = 1;
                }
            }
        }

        onRunningChanged: {
            if (!running && root.exitCode != 0) {
                statusText.text = "dunstctl error: 1";
                statusText.color = Theme.darkErrorContainer;
            }
        }
    }

    Timer {
        id: poll
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            if (!dunstProcess.running)
                dunstProcess.running = true;
        }
    }

    // Внутренний контент (фон)
    Rectangle {
        implicitWidth: statusText.implicitWidth + 12
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
            id: statusText
            anchors.centerIn: parent
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 12
            font.bold: true
            color: Theme.darkOnSurface
            // Начальный текст, пока процесс не завершился
            text: "Loading..."
        }
    }

    Component.onCompleted: dunstProcess.running = true
}

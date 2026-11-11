import QtQuick
import Quickshell.Widgets

WrapperRectangle {
    id: root

    // Размеры задаются от внутреннего контента + отступы рамки
    implicitWidth: clockText.implicitWidth + 16
    implicitHeight: 28

    radius: 8
    // Толщина вашей градиентной рамки
    border.width: 2
    border.color: "transparent" // Цвет не важен, важна толщина для отступов

    // Градиент для рамки
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
        // Указываем только implicit-размеры, обертка сама сделает отступы
        implicitWidth: clockText.implicitWidth + 12
        implicitHeight: 24

        radius: 6 // Чуть меньше радиуса обертки
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
            id: clockText
            color: Theme.darkPrimary
            anchors.centerIn: parent
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13
            text: Qt.formatTime(new Date(), "h:mm ap")

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clockText.text = Qt.formatTime(new Date(), "h:mm ap")
            }
        }
    }
}

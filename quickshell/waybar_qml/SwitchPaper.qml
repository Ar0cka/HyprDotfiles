import QtQuick
import Quickshell
import Quickshell.Io

Item {
    implicitWidth: paperText.implicitWidth
    implicitHeight: paperText.implicitHeight

    Process {
        id: wallpaperProcess
        command: ["/home/arocka/Scripts/waybar_button_script.sh"]
    }

    Text {
        id: paperText
        text: "🎨"
        color: "#e6dff2"
        font.pixelSize: 13
    }

    MouseArea {
        anchors.fill: parent
        onClicked: wallpaperProcess.running = true
    }
}

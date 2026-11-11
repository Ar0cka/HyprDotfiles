pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io
import Qt5Compat.GraphicalEffects

Item {
    id: wallpaper_button

    required property string preview_path
    required property string path_to_folder

    property string change_wallpaper_script_path: "/home/arocka/Scripts/set_wallpaper.sh"

    implicitHeight: 200
    implicitWidth: 400

    // Состояния взаимодействия
    property bool hovered: mouse_area.containsMouse
    property bool pressed: mouse_area.pressed

    scale: pressed ? 0.96 : hovered ? 1.03 : 1.0

    Behavior on scale {
        NumberAnimation {
            duration: 140
            easing.type: Easing.OutCubic
        }
    }

    Process {
        id: set_wallpaper

        command: ["bash", "-c", `setsid "${wallpaper_button.change_wallpaper_script_path}" "${wallpaper_button.path_to_folder}" >> "$HOME/.cache/set_wallpaper.log" 2>&1 &`]

        running: false

        stdout: SplitParser {
            onRead: data => {
                console.log("[set_wallpaper][stdout]", data);
            }
        }

        stderr: SplitParser {
            onRead: data => {
                console.log("[set_wallpaper][stderr]", data);
            }
        }

        onExited: (exitCode, exitStatus) => {
            console.log("[set_wallpaper] Process exited:", "code =", exitCode, "status =", exitStatus);
        }
    }

    Rectangle {
        id: image_frame

        anchors.fill: parent

        radius: 10
        color: Theme.darkSurfaceContainerLow

        border.width: wallpaper_button.hovered ? 3 : 2
        border.color: wallpaper_button.hovered ? Theme.darkOnPrimaryContainer : Theme.darkOnPrimary

        Behavior on border.color {
            ColorAnimation {
                duration: 140
            }
        }

        Image {
            id: preview_image

            anchors.fill: parent
            anchors.margins: 3

            source: wallpaper_button.preview_path

            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            cache: true

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: preview_image.width
                    height: preview_image.height
                    radius: 7
                }
            }
        }

        // Затемнение изображения при наведении
        Rectangle {
            anchors.fill: preview_image

            radius: 7
            color: "black"

            opacity: wallpaper_button.hovered ? 0.35 : 0.0

            Behavior on opacity {
                NumberAnimation {
                    duration: 160
                }
            }
        }

        // Индикатор наведения
        Rectangle {
            anchors.fill: parent

            radius: 8
            color: "transparent"

            border.width: 2
            border.color: Theme.accent

            opacity: wallpaper_button.hovered ? 1.0 : 0.0

            Behavior on opacity {
                NumberAnimation {
                    duration: 140
                }
            }
        }

        MouseArea {
            id: mouse_area

            anchors.fill: parent

            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                set_wallpaper.running = true;
            }
        }
    }
}

pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
    id: picker

    visible: false

    implicitHeight: 650
    implicitWidth: 1300

    color: "transparent"

    property string wallpaper_json_file_path: "/home/arocka/.config/quickshell/wallpaper_parser/wallpapers.json"
    property string python_parser_path: "/home/arocka/.config/quickshell/wallpaper_parser/wallpaper_path_parser.py"

    Process {
        id: wallpaper_parser

        command: ["python3", picker.python_parser_path]
        running: false

        onRunningChanged: {
            if (!running) {
                wallpaper_file_data.reload();
            }
        }
    }

    onVisibleChanged: {
        if (visible) {
            wallpaper_parser.running = true;
        }
    }

    FileView {
        id: wallpaper_file_data

        path: picker.wallpaper_json_file_path
        watchChanges: true

        property var raw_wallpaper: []

        onLoaded: {
            try {
                raw_wallpaper = JSON.parse(text());
                console.log("Loaded wallpapers:", raw_wallpaper.length);
            } catch (error) {
                console.error("Failed to parse wallpapers.json:", error);
                raw_wallpaper = [];
            }
        }

        onFileChanged: reload()
    }

    Rectangle {
        anchors.fill: parent

        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Theme.darkPrimaryContainer
            }
            GradientStop {
                position: 0.5
                color: Theme.darkSecondary
            }
            GradientStop {
                position: 1.0

                color: Theme.darkSurface
            }
        }
        border.color: Theme.darkPrimary
        border.width: 2

        radius: 8
    }

    ScrollView {
        id: wallpaper_scroll

        anchors.fill: parent
        anchors.margins: 12

        clip: true

        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.vertical.visible: false
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        contentHeight: grid.implicitHeight + 20

        Item {
            height: wallpaper_scroll.implicitHeight + 20
            width: wallpaper_scroll.availableWidth

            GridLayout {
                id: grid
                width: parent.width - 20

                x: 10
                y: 10

                columns: 3
                rowSpacing: 25
                columnSpacing: 25

                Repeater {
                    model: wallpaper_file_data.raw_wallpaper

                    delegate: ImageButton {
                        required property var modelData

                        preview_path: modelData.wallpaper_preview ?? ""
                        path_to_folder: modelData.wallpaper_dir_path ?? ""
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "picker"
        function toogle(): void {
            picker.visible = !picker.visible;
        }
    }
}

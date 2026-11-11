import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

WrapperRectangle {
    id: root

    implicitWidth: trayRow.implicitWidth + 16
    implicitHeight: 28

    radius: 8
    border.width: 2
    border.color: "transparent"

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

    Rectangle {
        anchors.centerIn: parent
        implicitWidth: trayRow.implicitWidth + 12
        implicitHeight: 24
        radius: 6

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
            id: trayRow
            anchors.centerIn: parent
            spacing: 4

            Repeater {
                model: SystemTray.items

                delegate: Item {
                    id: delegateItem
                    required property var modelData

                    implicitWidth: 20
                    implicitHeight: 20

                    IconImage {
                        anchors.centerIn: parent
                        implicitSize: 20
                        source: delegateItem.modelData.icon
                        mipmap: true
                        visible: delegateItem.modelData.icon !== ""
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton

                        onClicked: event => {
                            if (event.button === Qt.LeftButton) {
                                delegateItem.modelData.activate();
                            } else if (delegateItem.modelData.hasMenu) {
                                let win = root.QsWindow.window;
                                if (!win)
                                    return;
                                // Ключевой момент: преобразовать локальные координаты делегата в координаты окна
                                let pos = win.contentItem.mapFromItem(delegateItem, 0, delegateItem.height);
                                delegateItem.modelData.display(win, pos.x, pos.y);
                            }
                        }
                    }
                }
            }
        }
    }
}

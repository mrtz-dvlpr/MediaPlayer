import QtQuick
import QtQuick.Controls

Slider {
    id: control

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: control.availableWidth
        height: implicitHeight
        radius: 2

        color: mainColor
        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: subColor
            radius: 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2

        implicitWidth: 10
        implicitHeight: implicitWidth
        radius: 13

        border.width: control.pressed ? width / 2 : 1
        border.color: control.valueChanged ? subColor : control.background.color

        Behavior on border.width {
            SmoothedAnimation {}
        }

        color: control.background.color

        ToolTip {
            id: tooltip

            padding: 5

            opacity: 0.8
            visible: control.pressed

            parent: control.handle

            text: "X " + control.value
            font.pixelSize: parent.width

            delay: 100
            timeout: 0

            background: Rectangle {
                radius: 3
                border.width: 1
                opacity: 0.8
                color: subColor2
            }
        }
    }
}

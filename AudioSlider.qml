import QtQuick
import QtQuick.Controls

Slider {
    id: control
    property color test: "#" + (audioSlider.value * 255 / 100).toString(16).toUpperCase(
                             ) + ((100 - audioSlider.value) * 255 / 100).toString(16).toUpperCase(
                             ) + ((100 - audioSlider.value) * 255 / 100).toString(16).toUpperCase()
    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: control.availableWidth
        height: implicitHeight
        radius: 2

        color: "#566573"
        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            // color: buttonColor
            color: test
            radius: 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2

        implicitWidth: 20
        implicitHeight: 20
        radius: 13

        border.width: control.pressed ? width / 2 : 1
        // border.color: control.hovered ? buttonColor : control.background.color
        border.color: control.pressed ? test : control.background.color

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

            text: control.value.toFixed((control.stepSize + '.').split(
                                            '.')[1].length)
            font.pixelSize: parent.width / 2

            delay: 100
            timeout: 0

            background: Rectangle {
                radius: 3
                border.width: 1
                opacity: 0.5
                color: "white"
            }
        }
    }
}

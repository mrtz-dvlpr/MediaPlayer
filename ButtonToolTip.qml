import QtQuick
import QtQuick.Controls

Item {

    id: root
    property string text

    property Button button

    property int toolTipPixelSize: 8

    property int toolTipDelay: 600

    property int toolTipTimeout: 1500

    ToolTip {

        padding: 5

        opacity: 0.8

        visible: button.hovered

        text: root.text

        parent: button

        font.pixelSize: toolTipPixelSize

        delay: toolTipDelay

        timeout: toolTipTimeout

        background: Rectangle {
            radius: 3
            border.width: 1
            opacity: 0.3
            color: "white"
        }
    }
}

import QtQuick
import QtQuick.Controls

Rectangle {

    id: root

    signal mouseAreaClicked

    signal dropAreaDropped

    property string dropAreaDropUlr

    Rectangle {

        id: pathBox

        width: root.width / 3
        height: root.height / 3

        anchors.centerIn: parent

        color: root.color
        radius: 5
        border.color: subColor

        MouseArea {
            anchors.fill: parent
            // onClicked:pathButtonClicked()
            onClicked: mouseAreaClicked()
        }

        Column {
            spacing: 20
            anchors.centerIn: parent
            Image {

                anchors.horizontalCenter: parent.horizontalCenter
                id: button
                width: pathBox.width / 5.5
                height: pathBox.height / 3
                source: "qrc:/icons/Pulsar/icons8-open-view-in-new-tab-96 (1).png"
                // source: "qrc:/icons/Pulsar/icons8-video-file-96.png"
            }
            Text {

                // anchors.centerIn: parent
                // width: parent.width
                id: name
                text: "<font color=\"#ABB2B9\">click </font><font color=\"#FA5252\">here</font> <font color=\"#ABB2B9\">to select video file or drop here </font>"
            }
        }
    }
    DropArea {

        id: dropArea
        anchors.fill: root

        onEntered: {
            root.color = "#ABB2B9"
            pathBox.color = "#ABB2B9"
            pathBox.border.color = mainColor
            drag.accept(Qt.LinkAction)
        }

        onDropped: {

            root.color = mainColor
            pathBox.color = mainColor
            pathBox.border.color = subColor

            var str = ""
            for (var i in drop.urls) {
                var url = drop.urls[i]
                str += Qt.resolvedUrl(url)
            }

            var fileExtension = str.split('.').pop().toLowerCase()

            var supportedExtensions = ['mp4', 'avi', 'mov', 'mkv', 'mpeg', 'mpg', '3gp', '3g2', 'dv']
            if (supportedExtensions.indexOf(fileExtension) !== -1) {

                dropAreaDropUlr = str
                dropAreaDropped()
            } else {
                console.log("Unsupported file type.")
            }
        }

        onExited: {
            root.color = mainColor
            pathBox.color = mainColor
            pathBox.border.color = subColor
        }
    }
}

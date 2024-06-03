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
            spacing: 8
            anchors.centerIn: parent
            Image {

                anchors.horizontalCenter: parent.horizontalCenter

                id: button
                width: pathBox.width / 5.5
                height: pathBox.height / 3
                source: "qrc:/icons/svgviewer-output.svg"
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                id: name
                text: qsTr("file path")
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

import QtQuick
import QtQuick.Controls

Rectangle {

    id: main

    signal mouseAreaClicked

    signal dropAreaDropped

    property string dropAreaDropUlr

    Rectangle {

        id: pathBox

        width: main.width / 3
        height: main.height / 3

        anchors.centerIn: parent

        color: main.color
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
        anchors.fill: main

        onEntered: {
            main.color = "#ABB2B9"
            pathBox.color = "#ABB2B9"
            pathBox.border.color = mainColor
            drag.accept(Qt.LinkAction)
        }

        onDropped: {

            main.color = mainColor
            pathBox.color = mainColor
            pathBox.border.color = subColor

            var str = ""
            for (var i in drop.urls) {
                var url = drop.urls[i]
                str += Qt.resolvedUrl(url)
            }
            console.log(str)

            dropAreaDropUlr = str

            dropAreaDropped()
        }

        onExited: {
            main.color = mainColor
            pathBox.color = mainColor
            pathBox.border.color = subColor
        }
    }
}

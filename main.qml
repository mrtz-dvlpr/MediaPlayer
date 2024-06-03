import QtQuick
import QtQuick.Window
import QtMultimedia
import QtQuick.Controls

Window {
    width: 940
    height: 680
    visible: true
    title: qsTr("Hello World")

    MainScreen {
        anchors.fill: parent
    }
}

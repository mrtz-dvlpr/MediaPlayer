import QtQuick
import QtQuick.Window
import QtMultimedia
import QtQuick.Controls

Window {

    id: window

    property int screenWidth : 940
    property int screenHeight : 680

    width: screenWidth
    height: screenHeight

    minimumWidth: 880
    minimumHeight: 600

    visible: true

    title: qsTr("MR Player")

    MainScreen {
        anchors.fill: parent
    }
}

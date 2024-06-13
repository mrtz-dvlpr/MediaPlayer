import QtQuick
import QtQuick.Window
import QtMultimedia
import QtQuick.Controls

Window {
    id: window
    title: qsTr("MR Player")
    width: windowWidth
    height: windowHeight
    minimumWidth: 880
    minimumHeight: 600
    visible: true

    property int windowWidth: 940
    property int windowHeight: 680

    MainScreen {
        anchors.fill: parent
    }


}

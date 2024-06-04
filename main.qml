import QtQuick
import QtQuick.Window
import QtMultimedia
import QtQuick.Controls

Window {

    width: 940
    height: 680

    minimumWidth: 880
    minimumHeight: 600

    visible: true

    title: qsTr("MR Player")

    MainScreen {
        anchors.fill: parent
    }
}

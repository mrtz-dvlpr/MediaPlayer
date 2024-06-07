import QtQuick
import QtQuick.Window
import QtMultimedia
import QtQuick.Controls

Window {

    id: window

    title: qsTr("MR Player")

    property int windowWidth:  940
    property int windowHeight:  680

    property bool isFullScreen: false

    function toggleFullScreen() {
        if (isFullScreen) {
            showNormal()
            isFullScreen = false
            windowWidth: 940
            windowHeight: 680
        } else {
            showFullScreen()
            isFullScreen = true
            windowWidth: Screen.Width
            windowHeight: Screen.Height
        }
    }

    width:  windowWidth
    height: windowHeight


    minimumWidth: 880
    minimumHeight: 600

    visible: true

    MainScreen {
        anchors.fill: parent
    }
}

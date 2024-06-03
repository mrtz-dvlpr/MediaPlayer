import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Item {

    id: mainParent

    // property color mainColor: "#2E4053"
    // property color mainColor: "#E3FCFF"
    // property color mainColor: "#B2FFF8"
    // property color mainColor: "#C3F9FF"
    // property color mainColor: "#FFDBB2"
    // property color mainColor: "#F6F6F6"
    // property color mainColor: "#DAE1DF"
    // property color mainColor: "#6A9699"
    // property color mainColor: "#548981"
    // property color mainColor: "#34495E"
    // property color mainColor: "#398CFD"
    // property color mainColor: "#212F3D"
    // property color mainColor: "#494D4C"
    property color mainColor: "#1C2833"

    // property color subColor: "#33BEF0"
    // property color subColro: "#398CFD"
    // property color subColor: "white"
    // property color subColor: "#E74C3C"
    // property color subColor: "#E74C3C"
    property color subColor: "#FA5252"

    property color buttonColor: "#FFFFFF"

    anchors.fill: parent

    property double heightLength: 13 / 15
    property double mediaHeight: parent.height * heightLength
    property double controlHeight: parent.height - mediaHeight

    function pushPage(screen, path) {

        media.mediaPlayerSourcePath = path
        media.audioVolume = playbackControl.audioSliderValue

        playbackControl.setVideoSliderEnable = true

        // playbackControl.setVideoSliderTo = media.getDuration
        view.push(screen)
    }

    function popPage() {

        media.stop()
        media.mediaPlayerSourcePath = ""

        playbackControl.setVideoSliderEnable = false

        // playbackControl.setVideoSliderTo = 0
        view.pop()
    }

    Media {

        color: mainColor

        id: media

        MouseArea {
            width: parent.width / 3
            height: parent.height
            anchors.centerIn: parent

            onDoubleClicked: {
                if (!media.getPlaying)
                    media.play()
                else
                    media.pause()
            }
        }

        MouseArea {
            width: parent.width / 3
            height: parent.height
            anchors.left: parent.left
            anchors.top: parent.top
            onDoubleClicked: {
                media.setPosition = (media.getPosition - 5000)
            }
        }

        MouseArea {
            width: parent.width / 3
            height: parent.height
            anchors.right: parent.right
            anchors.top: parent.top
            onDoubleClicked: {
                media.setPosition = (media.getPosition + 5000)
            }
        }

        onPlayOrPause: {
            if (media.getHasVideo) {
                if (media.getPlaying) {
                    playbackControl.playtAndPauseButtonIconPath
                            = "qrc:/icons/Pulsar/icons8-pause-button-96.png"
                } else {
                    playbackControl.playtAndPauseButtonIconPath
                            = "qrc:/icons/Pulsar/icons8-circled-play-96.png"
                }
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Select a Video File"
        onAccepted: {
            pushPage(media, selectedFile)
        }
        nameFilters: ["Video Files (*.mov *.mp4 *.m4v *.mpeg *.mpg *.3gp *.3g2 *.avi *.dv)", "All Files (*)"]
    }

    PathScreen {

        id: pathScreen
        color: mainColor

        onMouseAreaClicked: fileDialog.open()

        onDropAreaDropped: {
            pushPage(media, dropAreaDropUlr)
        }
    }

    StackView {

        id: view

        anchors.top: parent.top

        width: parent.width
        height: mediaHeight

        initialItem: pathScreen
    }

    PlaybackControl {

        id: playbackControl

        width: parent.width
        height: controlHeight

        anchors.top: view.bottom

        color: mainParent.mainColor

        onPlayAndPauseButtonClicked: {

            if (media.getHasVideo) {
                if (media.getPlaying) {
                    media.pause()
                } else {
                    media.play()
                }
            }
        }

        setVideoSliderTo: media.getHasVideo ? media.getDuration : 0

        onStopButtonClicked: media.stop()

        onEjectButtonClicked: {
            popPage()
        }

        onVideoSliderMoved: {
            media.setPosition = getVideoSliderValue
        }

        setVideoSliderValue: media.getPosition

        onAudioSliderMoved: {
            media.audioVolume = getAudioSliderValue
        }
    }
} // color: "#2E4053"// color: "#34495E"// color: "#E74C3C"// color: "#E74C3C"// color: "#34495E"// color: "#D6DBDF"

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Item {

    id: mainRoot

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

    property color subColor2: "#ABB2B9"

    property color buttonColor: "#FFFFFF"

    anchors.fill: parent

    property double heightLength: 13 / 15

    property double mediaHeight: parent.height * heightLength

    property double controlHeight: parent.height - mediaHeight

    property string fileName

    property string filePath

    function getFileName(fileUrl) {
        return fileUrl.split('/').pop().split('.')[0]
    }

    function getFilePath(input) {
        return input.substring(7, input.lastIndexOf('/'))
    }

    function millisToMinutesAndSeconds(millis) {

        var minutes = Math.floor(millis / 60000)
        var seconds = ((millis % 60000) / 1000).toFixed(0)
        return minutes + ":" + (seconds < 10 ? '0' : '') + seconds
    }

    function pushPage(screen, path) {

        media.mediaplayerSourceUrl = path
        media.audioVolume = playbackControl.getAudioSliderValue

        playbackControl.setVideoSliderEnable = true

        fileName = getFileName(media.mediaplayerSourceUrl)

        view.push(screen)
    }

    function popPage() {

        media.stop()
        media.mediaplayerSourceUrl = ""

        fileName = ""
        playbackControl.setVideoSliderEnable = false

        view.pop()
    }

    Media {

        color: mainColor

        id: media

        // Button {
        //     anchors.centerIn: parent
        //     text: "Capture Frame"
        //     onClicked: {
        //         videoOutput.grabToImage(function (result) {
        //             result.saveToFile(
        //                         "file:///home/morteza/Desktop/capturedFrame.png")
        //         })
        //         console.log("capture")
        //     }
        // }
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

        color: mainRoot.mainColor

        // Button {
        //     anchors.centerIn: parent
        //     text: "Capture Frame"
        //     onClicked: {
        //         if (media.test.grabToImage(function (result) {
        //             // var path = Qt.resolvedUrl("capturedFrame.png")
        //             result.saveToFile("/home/morteza/Desktop/capturedFrame.png")
        //         })) {
        //             console.log("Capture attempt made")
        //         }
        //     }
        // }
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

        // onAudioSliderValueChanged: {
        //     media.audioVolume = getAudioSliderValue
        // }
        audioMuteButtonSource: media.setMuted ? "qrc:/icons/Pulsar/icons8-mute-96.png" : "qrc:/icons/Pulsar/icons8-voice-96.png"

        onMuteButtonClicked: {
            media.setMuted = !media.setMuted
        }

        onScreenshotButtonClicked: {
            if (media.getHasVideo) {
                var dialogMessage = ""
                var color = ""
                if (media.videoOutput.grabToImage(function (result) {
                    var captureNameAndDirectory = media.mediaplayerSourceUrl
                            + "_" + millisToMinutesAndSeconds(
                                getVideoSliderValue) + ".png"
                    result.saveToFile(captureNameAndDirectory)
                })) {

                    var screenshotOutputName = fileName + "_" + millisToMinutesAndSeconds(
                                getVideoSliderValue) + ".png"

                    var screenshotOutputPath = getFilePath(
                                media.mediaplayerSourceUrl)

                    dialogMessage = "the " + screenshotOutputName + " file saved in \" "
                            + screenshotOutputPath + " \" directory"
                    color = "#ABEBC6"
                } else {
                    dialogMessage = "Failed to capture screenshot"
                    color = subColor
                }
                openScreenshotDialog(dialogMessage, color)
            }
        }

        // MessageDialog {
        //     id: message
        //     text: "hello"
        // }
    }
} // color: "#2E4053"// color: "#34495E"// color: "#E74C3C"// color: "#E74C3C"// color: "#34495E"// color: "#D6DBDF"

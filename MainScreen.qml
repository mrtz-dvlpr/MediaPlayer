import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Rectangle {

    id: mainRoot

    anchors.fill: parent

    color: mainColor

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

    property double heightLength: 13 / 15

    property double mediaWidth: parent.width

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

        mediaPlayer.mediaPlayerSourceUrl = path
        mediaPlayer.audioVolume = playbackControl.getAudioSliderValue

        playbackControl.setVideoSliderEnable = true

        fileName = getFileName(mediaPlayer.mediaPlayerSourceUrl)

        if (playbackControl.screenshotPath == "") {
            playbackControl.screenshotPath = getFilePath(
                        mediaPlayer.mediaPlayerSourceUrl)
        }
        view.push(screen)
    }

    function popPage() {

        mediaPlayer.stop()
        mediaPlayer.mediaPlayerSourceUrl = ""

        fileName = ""

        playbackControl.setVideoSliderEnable = false

        view.pop()
    }

    Media {

        color: mainColor

        id: mediaPlayer

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
        // MouseArea {
        //     width: parent.width / 3
        //     height: parent.height
        //     anchors.centerIn: parent

        //     onDoubleClicked: {
        //         if (!mediaPlayer.getPlaying)
        //             mediaPlayer.play()
        //         else
        //             mediaPlayer.pause()
        //     }
        // }

        // MouseArea {
        //     width: parent.width / 3
        //     height: parent.height
        //     anchors.left: parent.left
        //     anchors.top: parent.top
        //     onDoubleClicked: {
        //         mediaPlayer.setPosition = (mediaPlayer.getPosition - 5000)
        //     }
        // }

        // MouseArea {
        //     width: parent.width / 3
        //     height: parent.height
        //     anchors.right: parent.right
        //     anchors.top: parent.top
        //     onDoubleClicked: {
        //         mediaPlayer.setPosition = (mediaPlayer.getPosition + 5000)
        //     }
        // }
        onPlayOrPause: {
            if (mediaPlayer.getHasVideo) {
                if (mediaPlayer.getPlaying) {
                    playbackControl.playtAndPauseButtonIconPath
                            = "qrc:/icons/Pulsar/icons8-pause-button-96 (1).png"
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
            pushPage(mediaPlayer, selectedFile)
        }
        nameFilters: ["Video Files (*.mov *.mp4 *.m4v
*.mpeg *.mpg *.3gp *.3g2 *.avi *.dv)", "All Files (*)"]
    }

    PathScreen {

        id: pathScreen
        color: mainColor

        onMouseAreaClicked: fileDialog.open()

        onDropAreaDropped: {
            pushPage(mediaPlayer, dropAreaDropUlr)
        }
    }

    StackView {

        id: view

        anchors.top: parent.top

        width: mediaWidth
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

            console.log("214")
            if (mediaPlayer.getHasVideo) {
                if (mediaPlayer.getPlaying) {
                    mediaPlayer.pause()
                } else {
                    mediaPlayer.play()
                }
            }
        }

        setVideoSliderTo: mediaPlayer.getHasVideo ? mediaPlayer.getDuration : 0

        onStopButtonClicked: mediaPlayer.stop()

        onEjectButtonClicked: {
            popPage()
        }

        onVideoSliderMoved: {
            mediaPlayer.setPosition = getVideoSliderValue
        }

        setVideoSliderValue: mediaPlayer.getPosition

        onAudioSliderMoved: {
            mediaPlayer.audioVolume = getAudioSliderValue
        }

        audioMuteButtonSource: mediaPlayer.setMuted ? "qrc:/icons/Pulsar/icons8-mute-96.png" : "qrc:/icons/Pulsar/icons8-voice-96.png"

        onMuteButtonClicked: {
            mediaPlayer.setMuted = !mediaPlayer.setMuted
        }

        onScreenshotButtonClicked: {

            if (mediaPlayer.getHasVideo) {

                var screenshotName = ""
                var messageColor
                var messageDialog

                mediaPlayer.videoOutput.grabToImage(function (result) {

                    screenshotName = fileName + "_" + millisToMinutesAndSeconds(
                                getVideoSliderValue) + ".png"
                    var captureNameAndDirectory = "file://" + screenshotPath + "/" + screenshotName

                    if (result.saveToFile(captureNameAndDirectory)) {
                        messageDialog = "the \"" + screenshotName + "\" file saved in \" "
                                + screenshotPath + " \" directory"
                        messageColor = "#ABEBC6"
                        openScreenshotDialog(messageDialog, messageColor)
                    } else {
                        messageDialog = "Failed to capture screenshot"
                        messageColor = subColor
                        openScreenshotDialog(messageDialog, messageColor)
                    }
                })
            }
        }

        onToggleFullScreenButtonClicked: {
            var fullScreenVisibility = 5
            visibility == fullScreenVisibility ? showNormal() : showFullScreen()

            toggleFullScreenButtonImageSource = visibility
                    === 5 ? "qrc:/icons/Pulsar/icons8-resize-96(1).png" : "qrc:/icons/Pulsar/icons8-resize-96.png"
        }

        onReplayButtonClicked: {
            mediaPlayer.setPosition = (mediaPlayer.getPosition - 30000)
        }

        onForwardButtonClicked: {
            mediaPlayer.setPosition = (mediaPlayer.getPosition + 30000)
        }

        onSettingDialogAccepted: {
            console.log(getRateControlSliderValue)
            mediaPlayer.mediaPlayerPlaybackRate = getRateControlSliderValue

            if (textPathInputTextFieldDialog !== "") {
                screenshotPath = textPathInputTextFieldDialog
            } else {
                screenshotPath = getFilePath(mediaPlayer.mediaPlayerSourceUrl)
            }
        }

        onRotateLeftButtonClicked: {
            mediaPlayer.rotationDegrees -= 90
        }

        onRotateRightButtonClicked: {
            mediaPlayer.rotationDegrees += 90
        }

        onX2ButtonClicked: {
            mediaPlayer.mediaPlayerPlaybackRate = mediaPlayer.mediaPlayerPlaybackRate === 2 ? 1 : 2
            x2ButtonImageSource = mediaPlayer.getMediaPlayerPlaybackRate
                    === 2 ? "qrc:/icons/Pulsar/icons8-x2-96(1).png" : "qrc:/icons/Pulsar/icons8-x2-96.png"
        }
        onZoomOutButtonClicked: {
            if (mediaPlayer.testX > 1 && mediaPlayer.testY > 1) {
                mediaPlayer.testX -= 1
                mediaPlayer.testY -= 1
            } else {
                mediaPlayer.testX = 1
                mediaPlayer.testY = 1
            }
        }
        onZoomInButtonClicked: {
            mediaPlayer.testX += 1
            mediaPlayer.testY += 1
        }

        onOrginalScreenSizeButtonClicked: {
            mediaPlayer.testX = 1
            mediaPlayer.testY = 1
        }

        Component.onCompleted: {
            x2ButtonImageSource = mediaPlayer.getMediaPlayerPlaybackRate
                    === 2 ? "qrc:/icons/Pulsar/icons8-x2-96(1).png" : "qrc:/icons/Pulsar/icons8-x2-96.png"
        }
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Rectangle {

    id: mainRoot

    anchors.fill: parent

    color: mainColor

    property color mainColor: "#1C2833"

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

    Action {
        shortcut: "Esc"
        onTriggered: {
            mediaPlayer.testX = 1
            mediaPlayer.testY = 1
        }
    }

    Action {
        shortcut: "Up"
        onTriggered: {
            if (playbackControl.getAudioSliderValue < 0.96) {

                playbackControl.setAudioSliderValue += 5
            }
        }
    }

    Action {
        shortcut: "Down"
        onTriggered: {
            if (playbackControl.getAudioSliderValue > 0.04) {
                playbackControl.setAudioSliderValue -= 5
            }
        }
    }

    Action {
        shortcut: "Left"
        onTriggered: {
            mediaPlayer.setPosition = (mediaPlayer.getPosition - 1000)
        }
    }

    Action {
        shortcut: "Right"
        onTriggered: {
            mediaPlayer.setPosition = (mediaPlayer.getPosition + 1000)
        }
    }

    Action {
        shortcut: "Space"
        onTriggered: {
            playbackControl.playAndPauseButtonClicked()
        }
    }

    Action {
        shortcut: "Ctrl+S"
        onTriggered: {
            playbackControl.screenshotButtonClicked()
        }
    }

    Action {
        shortcut: "Ctrl+O"
        onTriggered: {
            if (!mediaPlayer.getHasVideo)
                fileDialog.open()
        }
    }

    Action {
        shortcut: "Backspace"
        onTriggered: {
            playbackControl.ejectButtonClicked()
        }
    }

    Action {
        shortcut: "Ctrl+Shift+Esc"
        onTriggered: {
            window.close()
        }
    }

    Action {
        shortcut: "Return"
        onTriggered: {
            playbackControl.toggleFullScreenButtonClicked()
        }
    }

    Media {

        color: mainColor

        id: mediaPlayer

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
        nameFilters: ["Video Files (*.mov *.mp4 *.m4v *.mpeg *.mpg *.3gp *.3g2 *.avi *.dv)", "All Files (*)"]
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

        onPlayAndPauseButtonClicked: {
            mediaPlayer.getHasVideo
                    && mediaPlayer.getPlaying ? mediaPlayer.pause(
                                                    ) : mediaPlayer.play()
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

        onAudioSliderValueChanged: {
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
        }

        setRateControlSliderValue: mediaPlayer.mediaPlayerPlaybackRate

        x2ButtonImageSource: mediaPlayer.getMediaPlayerPlaybackRate
                             === 2 ? "qrc:/icons/Pulsar/icons8-x2-96(1).png" : "qrc:/icons/Pulsar/icons8-x2-96.png"

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
    }
}

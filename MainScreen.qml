import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtMultimedia
import QtQml

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

        mediaPlayer.setMediaPlayerSourceUrl = path
        playbackControl.controlButtonEnable = true

        mediaPlayer.audioVolume = playbackControl.getSoundSliderValue

        playbackControl.setMediaSliderEnable = true

        fileName = getFileName(mediaPlayer.setMediaPlayerSourceUrl)

        if (playbackControl.screenshotPath == "") {
            playbackControl.screenshotPath = getFilePath(
                        mediaPlayer.setMediaPlayerSourceUrl)
        }

        view.push(screen)
    }

    function popPage() {

        mediaPlayer.stop()
        mediaPlayer.setMediaPlayerSourceUrl = ""

        fileName = ""

        playbackControl.setMediaSliderEnable = false

        view.pop()
    }

    Action {
        shortcut: "Return"
        onTriggered: {
            playbackControl.toggleFullScreenButtonClicked()
        }
    }

    Action {
        shortcut: "Backspace"
        onTriggered: {
            playbackControl.backToPathScreenButtonClicked()
        }
    }

    Action {
        shortcut: "Esc"
        onTriggered: {
            mediaPlayer.verticalScale = 1
            mediaPlayer.horizontalScale = 1
        }
    }

    Action {
        shortcut: "Up"
        onTriggered: {
            if (playbackControl.getSoundSliderValue < 0.96) {

                playbackControl.setSoundSliderValue += 5
            }
        }
    }

    Action {
        shortcut: "Down"
        onTriggered: {
            if (playbackControl.getSoundSliderValue > 0.04) {
                playbackControl.setSoundSliderValue -= 5
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
        shortcut: "Ctrl+Esc"
        onTriggered: {
            window.close()
        }
    }

    Action {
        shortcut: "Ctrl+R"
        onTriggered: {
            playbackControl.repeatButtonClicked()
        }
    }

    Action {
        shortcut: "Ctrl+2"
        onTriggered: {
            playbackControl.x2ButtonClicked()
        }
    }

    Action {
        shortcut: "Ctrl+M"
        onTriggered: {
            playbackControl.muteButtonClicked()
        }
    }

    Media {
        color: mainColor
        id: mediaPlayer
    }

    FileDialog {
        id: fileDialog
        title: "Select a Video File"
        onAccepted: {
            pushPage(mediaPlayer, selectedFile)
        }
        nameFilters: ["Video Files (*.mov *.mp4 *.m4v *.mpeg *.mpg *.3gp *.3g2 *.avi *.dv
*.wav *.mp3 *.aac *.flac)", "All Files (*)"]
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
            (mediaPlayer.getHasVideo || mediaPlayer.getHasAudio)
                    && mediaPlayer.getPlaying ? mediaPlayer.pause(
                                                    ) : mediaPlayer.play()
        }

        setMediaSliderTo: /* mediaPlayer.getHasVideo ? */ mediaPlayer.getDuration /*: 0*/

        onStopButtonClicked: mediaPlayer.stop()

        playtAndPauseButtonIconPath: (mediaPlayer.getHasVideo
                                      || mediaPlayer.getHasAudio)
                                     && mediaPlayer.getPlaying ? "qrc:/icons/Pulsar/icons8-pause-button-96 (1).png" : "qrc:/icons/Pulsar/icons8-circled-play-96.png"

        repeatButtonSource: mediaPlayer.getMediaPlayerLoops
                            === 1 ? "qrc:/icons/Pulsar/icons8-repeat-96 (3).png" : "qrc:/icons/Pulsar/icons8-repeat-96 (2).png"

        setMediaSliderValue: mediaPlayer.getPosition

        soundMuteButtonSource: mediaPlayer.setMuted ? "qrc:/icons/Pulsar/icons8-mute-96.png" : "qrc:/icons/Pulsar/icons8-voice-96.png"

        setRateControlSliderValue: mediaPlayer.mediaPlayerPlaybackRate

        x2ButtonImageSource: mediaPlayer.getMediaPlayerPlaybackRate
                             === 2 ? "qrc:/icons/Pulsar/icons8-x2-96(1).png" : "qrc:/icons/Pulsar/icons8-x2-96.png"

        onBackToPathScreenButtonClicked: {
            popPage()
        }

        onVideoSliderMoved: {
            mediaPlayer.setPosition = getMediaSliderValue
        }

        onSoundSliderValueChanged: {
            mediaPlayer.audioVolume = getSoundSliderValue
        }

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
                                getMediaSliderValue)
                    var captureNameAndDirectory = "file://" + screenshotPath + "/" + screenshotName

                    if (result.saveToFile(captureNameAndDirectory + ".png")) {
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
        }

        onSkipBackButtonClicked: {
            if (mediaPlayer.getPosition > 30000) {

                mediaPlayer.setPosition = (mediaPlayer.getPosition - 30000)
            }
        }

        onSkipForwardButtonClicked: {

            if (mediaPlayer.getDuration - mediaPlayer.getPosition > 30000) {

                mediaPlayer.setPosition = (mediaPlayer.getPosition + 30000)
            }
        }

        onSettingDialogAccepted: {
            mediaPlayer.mediaPlayerPlaybackRate = getRateControlSliderValue

            screenshotPath = textPathInputTextFieldDialog
                    !== "" ? textPathInputTextFieldDialog : getFilePath(
                                 mediaPlayer.setMediaPlayerSourceUrl)
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

        onZoomOutButtonClicked: {
            if (mediaPlayer.getHasVideo && mediaPlayer.verticalScale > 1
                    && mediaPlayer.horizontalScale > 1) {
                mediaPlayer.verticalScale -= 1
                mediaPlayer.horizontalScale -= 1
            } else {
                mediaPlayer.verticalScale = 1
                mediaPlayer.horizontalScale = 1
            }
        }
        onZoomInButtonClicked: {
            if (mediaPlayer.getHasVideo) {
                mediaPlayer.verticalScale += 1
                mediaPlayer.horizontalScale += 1
            }
        }

        onOrginalScaleButtonClicked: {
            if (mediaPlayer.getHasVideo) {

                mediaPlayer.verticalScale = 1
                mediaPlayer.horizontalScale = 1
            }
        }

        onRepeatButtonClicked: {
            mediaPlayer.setMediaPlayerLoops = mediaPlayer.getMediaPlayerLoops
                    !== 1 ? 1 : MediaPlayer.Infinite
        }
    }
}

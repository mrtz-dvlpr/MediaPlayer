import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Window

Rectangle {

    id: root

    property string playtAndPauseButtonIconPath: "qrc:/icons/Pulsar/icons8-circled-play-96.png"

    property int buttonSize: 50

    property real setMediaSliderTo

    property real setMediaSliderValue

    property bool setMediaSliderEnable

    property real getAudioSliderValue: soundSlider.value / soundSlider.to

    property real getMediaSliderValue: mediaSlider.value

    property bool setLowerSoundAudioButtomEnable

    property bool setAudioSliderEnable

    property bool setHigherSoundAudioButtomEnable

    property string audioMuteButtonSource: "qrc:/icons/Pulsar/icons8-voice-96.png"

    property string screenshotPath

    property real getRateControlSliderValue: rateControlSlider.value

    property string textPathInputTextFieldDialog: pathInputTextField.text

    property string toggleFullScreenButtonImageSource: "qrc:/icons/Pulsar/icons8-resize-96.png"

    property string x2ButtonImageSource

    property real setAudioSliderValue: 50

    property real setRateControlSliderValue

    property string repeatButtonSource

    signal playAndPauseButtonClicked

    signal stopButtonClicked

    signal videoSliderMoved

    signal ejectButtonClicked

    signal muteButtonClicked

    signal audioSliderValueChanged

    signal screenshotButtonClicked

    signal toggleFullScreenButtonClicked

    signal replayButtonClicked

    signal forwardButtonClicked

    signal settingDialogAccepted

    signal rotateLeftButtonClicked

    signal rotateRightButtonClicked

    signal x2ButtonClicked

    signal zoomOutButtonClicked

    signal zoomInButtonClicked

    signal orginalScreenSizeButtonClicked

    signal repeatButtonClicked

    function openScreenshotDialog(inputMessage, messageColor) {
        dialogLabel.text = qsTr(inputMessage)
        dialogBackground.color = messageColor
        screenshotMessage.open()
    }

    Column {

        anchors.fill: parent
        spacing: 6

        Item {

            id: videoSliderItem

            width: parent.width

            Row {

                x: 10
                id: videoSliderRow

                spacing: 10

                width: parent.width

                Text {

                    id: positionTimeText

                    text: qsTr(millisToMinutesAndSeconds(setMediaSliderValue))

                    color: subColor
                }

                MediaSlider {

                    id: mediaSlider
                    width: videoSliderRow.width - positionTimeText.width
                           - toggleFullScreen.width - x2Button.width - 50

                    from: 0.0
                    value: setMediaSliderValue
                    to: setMediaSliderTo

                    onMoved: {
                        videoSliderMoved()
                    }

                    enabled: setMediaSliderEnable
                }

                Text {

                    id: toggleFullScreen

                    text: qsTr(millisToMinutesAndSeconds(setMediaSliderTo))

                    color: subColor
                }

                Button {
                    id: x2Button

                    width: buttonSize * 3 / 9
                    height: width

                    ButtonToolTip {
                        button: x2Button
                        text: "X2 rate ( Ctrl+2 )"
                    }

                    background: Image {

                        source: x2ButtonImageSource
                    }

                    onClicked: x2ButtonClicked()
                }
            }
        }

        Item {
            id: leftItems

            width: parent.width
            height: parent.height

            Row {

                id: audioControlRow

                x: parent.width / 30

                anchors.verticalCenter: parent.verticalCenter

                spacing: 4

                Button {
                    id: repeatButtom
                    width: buttonSize * 3 / 5
                    height: width

                    ButtonToolTip {
                        button: parent
                        text: "repeat ( Ctrl+R )"
                    }

                    background: Image {
                        source: repeatButtonSource
                    }
                    onClicked: {
                        repeatButtonClicked()
                    }
                }

                Button {
                    id: muteButtom
                    width: buttonSize * 3 / 5
                    height: width

                    ButtonToolTip {
                        button: parent
                        text: "mute ( Ctrl+M )"
                    }

                    background: Image {
                        source: audioMuteButtonSource
                    }
                    onClicked: {
                        muteButtonClicked()
                    }
                }

                SoundSlider {
                    id: soundSlider

                    stepSize: 5

                    width: leftItems.width / 10
                    anchors.verticalCenter: parent.verticalCenter

                    from: 0
                    value: setAudioSliderValue
                    to: 100

                    onValueChanged: {
                        audioSliderValueChanged()
                    }
                }
            }

            Row {
                id: controlRow
                anchors.centerIn: parent

                Button {

                    id: rewindButton

                    width: buttonSize * 8 / 10
                    height: width

                    ButtonToolTip {
                        button: parent
                        text: "rewind 30 s ( Left )"
                    }

                    anchors.bottom: parent.bottom

                    background: Image {
                        source: rewindButton.pressed ? "qrc:/icons/Pulsar/icons8-rewind-button-round-96.png" : "qrc:/icons/Pulsar/icons8-rewind-button-round-96 (3).png"
                    }

                    onClicked: replayButtonClicked()
                }

                Button {
                    id: eject

                    width: buttonSize
                    height: width

                    ButtonToolTip {
                        button: parent
                        text: "go path screen ( BackSpace )"
                    }

                    background: Image {
                        source: eject.pressed ? "qrc:/icons/Pulsar/icons8-insert-button-96 (2).png" : "qrc:/icons/Pulsar/icons8-insert-button-96 (1).png"
                    }
                    onClicked: ejectButtonClicked()
                }

                Button {
                    id: playAndPauseButton

                    width: buttonSize
                    height: width

                    ButtonToolTip {
                        button: parent
                        text: "play / pause ( Space )"
                    }

                    background: Image {

                        id: playAndPauseButtonImage
                        source: root.playtAndPauseButtonIconPath
                    }

                    onClicked: {
                        playAndPauseButtonClicked()
                    }
                }
                Button {
                    id: stop

                    width: buttonSize
                    height: width

                    ButtonToolTip {
                        button: parent
                        text: "stop"
                    }

                    background: Image {

                        source: stop.pressed ? "qrc:/icons/Pulsar/icons8-stop-circled-96 (1).png" : "qrc:/icons/Pulsar/icons8-stop-circled-96.png"
                    }
                    onClicked: {

                        stopButtonClicked()
                    }
                }

                Button {

                    id: fastForwardButton

                    width: buttonSize * 8 / 10
                    height: width

                    ButtonToolTip {
                        button: parent
                        text: "fast forward 30 s ( Right )"
                    }

                    anchors.bottom: parent.bottom
                    background: Image {
                        source: fastForwardButton.pressed ? "qrc:/icons/Pulsar/icons8-rewind-button-round-96 (2).png" : "qrc:/icons/Pulsar/icons8-rewind-button-round-96 (1).png"
                    }
                    onClicked: forwardButtonClicked()
                }
            }

            Row {

                id: toolboxRow

                x: parent.width - width - 15

                anchors.verticalCenter: parent.verticalCenter

                spacing: 10

                Button {
                    id: settingButton

                    width: buttonSize * 4 / 5
                    height: width
                    ButtonToolTip {
                        button: parent
                        text: "setting"
                    }
                    background: Image {
                        source: settingDialog.opened ? "qrc:/icons/Pulsar/icons8-settings-96.png" : "qrc:/icons/Pulsar/icons8-settings-96(1).png"
                    }

                    onClicked: {
                        settingDialog.open()
                    }

                    Dialog {
                        id: settingDialog

                        x: (parent.width - width) / 2
                        y: (parent.height - height) / 2
                        parent: Overlay.overlay

                        focus: true
                        modal: true

                        standardButtons: Dialog.Ok | Dialog.Cancel

                        onAccepted: settingDialogAccepted()

                        onRejected: {
                            close()
                        }

                        ColumnLayout {
                            spacing: 15
                            anchors.fill: parent
                            Label {
                                elide: Label.ElideRight
                                text: qsTr("Rotate :")
                                Layout.fillWidth: true
                            }

                            Row {

                                spacing: 50

                                Button {
                                    id: rotateLeftButton
                                    width: buttonSize
                                    height: width
                                    ButtonToolTip {
                                        button: parent
                                        text: "rotate 90 deg left"
                                    }
                                    background: Image {
                                        source: "qrc:/icons/Pulsar/icons8-rotate-left-96 (1).png"
                                    }
                                    onClicked: rotateLeftButtonClicked()
                                }
                                Button {
                                    id: rotateRightButton
                                    width: buttonSize
                                    height: width
                                    ButtonToolTip {
                                        button: parent
                                        text: "rotate 90 deg right"
                                    }
                                    background: Image {
                                        source: "qrc:/icons/Pulsar/icons8-rotate-right-96 (1).png"
                                    }
                                    onClicked: rotateRightButtonClicked()
                                }
                            }
                            Label {
                                elide: Label.ElideRight
                                text: qsTr("Speed :")
                                Layout.fillWidth: true
                            }

                            Row {

                                Layout.fillWidth: true
                                spacing: 10

                                RateControlSlider {
                                    id: rateControlSlider

                                    width: parent.width - 50

                                    anchors.bottom: parent.bottom

                                    snapMode: Slider.SnapAlways

                                    from: 0.25
                                    value: setRateControlSliderValue
                                    to: 2

                                    stepSize: 0.25
                                }

                                Text {

                                    id: rateSizeText

                                    width: 40

                                    text: qsTr("X " + rateControlSlider.value)
                                }
                            }

                            Rectangle {
                                Layout.fillHeight: true

                                color: mainColor
                            }

                            Label {
                                elide: Label.ElideRight
                                text: qsTr("Enter desired path to save the screenshot :")
                                Layout.fillWidth: true
                            }
                            TextField {
                                id: pathInputTextField

                                placeholderText: qsTr("/home/...")

                                Layout.fillWidth: true
                            }
                        }
                    }
                }

                Button {

                    id: screenshotButton

                    width: buttonSize * 3 / 4
                    height: width
                    ButtonToolTip {
                        button: parent
                        text: "screenshot ( Ctrl+S )"
                    }

                    background: Image {
                        id: image
                        source: screenshotButton.pressed ? "qrc:/icons/Pulsar/icons8-screenshot-96.png" : "qrc:/icons/Pulsar/icons8-screenshot-96(1).png"
                    }

                    property bool playing: false

                    onClicked: {
                        screenshotButtonClicked()
                        screenshotButton.playing = true
                        screenshotDialogTimer.start()
                    }

                    Dialog {

                        id: screenshotMessage

                        x: -toolboxRow.x + (mainRoot.width - width) / 2
                        y: -(mainRoot.height) / 6

                        opacity: 0.5

                        background: Rectangle {
                            id: dialogBackground
                            radius: 10
                        }

                        Label {
                            id: dialogLabel
                        }

                        Timer {
                            id: screenshotDialogTimer

                            repeat: false

                            running: screenshotButton.playing

                            interval: 2000

                            onTriggered: {
                                screenshotMessage.close()
                                screenshotButton.playing = false
                                image.source = ""
                            }
                        }
                    }
                }
                Button {
                    id: toggleFullScreenButton

                    ButtonToolTip {
                        button: parent
                        text: "full screen ( Enter )"
                    }

                    width: buttonSize * 3 / 4
                    height: width

                    background: Image {
                        source: toggleFullScreenButtonImageSource
                    }

                    onClicked: toggleFullScreenButtonClicked()
                }

                Button {
                    id: zoomInButton

                    width: buttonSize * 3.5 / 4
                    height: width
                    ButtonToolTip {
                        button: parent
                        text: "zoom in"
                    }
                    background: Image {
                        source: zoomInButton.pressed ? "qrc:/icons/Pulsar/icons8-zoom-in-96.png" : "qrc:/icons/Pulsar/icons8-zoom-in-96(1).png"
                    }

                    onClicked: zoomInButtonClicked()
                }

                Button {
                    id: orginalScreenSizeButton

                    width: buttonSize * 3 / 4
                    height: width

                    ButtonToolTip {
                        button: parent
                        text: "first size screen ( Esc )"
                    }

                    background: Image {
                        source: orginalScreenSizeButton.pressed ? "qrc:/icons/Pulsar/icons8-original-size-96.png" : "qrc:/icons/Pulsar/icons8-original-size-96(1).png"
                    }

                    onClicked: orginalScreenSizeButtonClicked()
                }

                Button {
                    id: zoomOutButton

                    width: buttonSize * 3 / 4.5
                    height: width
                    ButtonToolTip {
                        button: parent
                        text: "zoom out"
                    }
                    background: Image {
                        source: zoomOutButton.pressed ? "qrc:/icons/Pulsar/icons8-zoom-out-96(1).png" : "qrc:/icons/Pulsar/icons8-zoom-out-96.png"
                    }

                    onClicked: zoomOutButtonClicked()
                }
            }
        }
    }
}

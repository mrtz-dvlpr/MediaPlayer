import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Window

Rectangle {

    id: root

    property string playtAndPauseButtonIconPath: "qrc:/icons/Pulsar/icons8-circled-play-96.png"

    property int buttonSize: 50

    property real setVideoSliderTo

    property real setVideoSliderValue

    property bool setVideoSliderEnable

    property real getAudioSliderValue: audioSlider.value / audioSlider.to

    property real getVideoSliderValue: videoSlider.value

    property bool setLowerSoundAudioButtomEnable

    property bool setAudioSliderEnable

    property bool setHigherSoundAudioButtomEnable

    property string audioMuteButtonSource: "qrc:/icons/Pulsar/icons8-voice-96.png"

    property string screenshotPath

    property real getRateControlSliderValue: rateControlSlider.value

    property string textPathInputTextFieldDialog: pathInputTextField.text

    signal playAndPauseButtonClicked

    signal stopButtonClicked

    signal videoSliderMoved

    signal ejectButtonClicked

    signal muteButtonClicked

    signal audioSliderMoved

    signal screenshotButtonClicked

    signal toggleFullScreenButtonClicked

    signal replayButtonClicked

    signal forwardButtonClicked

    signal settingDialogAccepted

    signal rotateLeftButtonClicked

    signal rotateRightButtonClicked

    function openScreenshotDialog(inputMessage, messageColor) {
        dialogLabel.text = qsTr(inputMessage)
        dialogBackground.color = messageColor
        screenshotMessage.open()
    }

    // function millisToMinutesAndSeconds(millis) {

    //     var minutes = Math.floor(millis / 60000)
    //     var seconds = ((millis % 60000) / 1000).toFixed(0)
    //     return minutes + ":" + (seconds < 10 ? '0' : '') + seconds
    // }
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

                    text: qsTr(millisToMinutesAndSeconds(setVideoSliderValue))

                    color: subColor
                }

                VideoSlider {

                    id: videoSlider
                    width: videoSliderRow.width - positionTimeText.width
                           - toggleFullScreen.width - maximumSizeScreenButton.width - 50

                    from: 0.0
                    value: setVideoSliderValue
                    to: setVideoSliderTo

                    onMoved: {
                        console.log(videoSliderRow.width)
                        videoSliderMoved()
                    }

                    enabled: setVideoSliderEnable
                }

                Text {

                    id: toggleFullScreen

                    text: qsTr(millisToMinutesAndSeconds(setVideoSliderTo))

                    color: subColor
                }
                Button {
                    id: maximumSizeScreenButton

                    width: buttonSize / 3
                    height: width

                    background: Image {
                        source: "qrc:/icons/Pulsar/icons8-full-page-view-96.png"
                    }

                    onClicked: toggleFullScreenButtonClicked()
                }
            }
        }

        Item {
            id: mainItem

            width: parent.width
            height: parent.height

            Row {

                x: parent.width / 30

                anchors.verticalCenter: parent.verticalCenter

                spacing: 4

                Button {
                    id: muteButtom
                    width: buttonSize * 3 / 5
                    height: width

                    background: Image {
                        source: audioMuteButtonSource
                    }
                    onClicked: {
                        muteButtonClicked()
                    }
                }

                // Button {
                //     width: buttonSize * 3 / 5
                //     height: width
                //     background: Image {
                //         source: "qrc:/icons/Pulsar/icons8-low-volume-96.png"
                //     }

                //     onClicked: {
                //         if (audioSlider.value > 4)
                //             audioSlider.value -= 5
                //     }
                // }
                AudioSlider {
                    id: audioSlider

                    stepSize: 5

                    width: mainItem.width / 10
                    anchors.verticalCenter: parent.verticalCenter

                    from: 0
                    value: 50
                    to: 100

                    onMoved: {
                        audioSliderMoved()
                        console.log(variableColor)
                    }
                    // onValueChanged: {
                    //     audioSliderValueChanged()
                    // }
                }

                // Button {
                //     width: buttonSize * 3 / 5
                //     height: width
                //     background: Image {
                //         source: "qrc:/icons/Pulsar/icons8-audio-96.png"
                //     }
                //     onClicked: {
                //         if (audioSlider.value < 96) {
                //             audioSlider.value += 5
                //         }
                //     }
                // }
            }

            Row {
                anchors.centerIn: parent

                Button {

                    id: repleyButton

                    width: buttonSize * 8 / 10
                    height: width

                    anchors.bottom: parent.bottom

                    background: Image {
                        source: "qrc:/icons/Pulsar/icons8-replay-30-96.png"
                    }

                    onClicked: replayButtonClicked()
                }

                Button {
                    id: eject

                    width: buttonSize
                    height: width

                    background: Image {
                        source: "qrc:/icons/Pulsar/icons8-insert-button-96 (1).png"
                    }
                    onClicked: ejectButtonClicked()
                }

                Button {
                    id: playAndPauseButton

                    width: buttonSize
                    height: width

                    background: Image {

                        id: playAndPauseButtonImage
                        source: root.playtAndPauseButtonIconPath
                    }

                    onClicked: {
                        playAndPauseButtonClicked()
                        console.log("260")
                    }
                }
                Button {
                    id: stop

                    width: buttonSize
                    height: width

                    background: Image {

                        source: "qrc:/icons/Pulsar/icons8-stop-circled-96.png"
                    }
                    onClicked: {

                        stopButtonClicked()
                    }
                }

                Button {

                    id: forwardButton

                    width: buttonSize * 8 / 10
                    height: width

                    anchors.bottom: parent.bottom
                    background: Image {
                        source: "qrc:/icons/Pulsar/icons8-forward-30-96.png"
                    }
                    onClicked: forwardButtonClicked()
                }
            }

            Row {

                id: rightItem

                x: parent.width * 8 / 9

                anchors.verticalCenter: parent.verticalCenter

                spacing: 10

                Button {
                    id: settingButton

                    width: buttonSize * 3 / 5
                    height: width

                    background: Image {
                        source: "qrc:/icons/Pulsar/icons8-open-end-wrench-96.png"
                    }

                    onClicked: settingDialog.open()

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
                                    background: Image {
                                        source: "qrc:/icons/Pulsar/icons8-rotate-left-96 (1).png"
                                    }
                                    onClicked: rotateLeftButtonClicked()
                                }
                                Button {
                                    id: rotateRightButton
                                    width: buttonSize
                                    height: width
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
                                    value: 1
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

                    background: Image {
                        source: "qrc:/icons/Pulsar/icons8-video-stabilization-96.png"
                    }

                    property bool playing: false

                    onClicked: {
                        screenshotButtonClicked()
                        screenshotButton.playing = true
                        screenshotDialogTimer.start()
                    }

                    Dialog {

                        id: screenshotMessage

                        x: -rightItem.x + (mainRoot.width - width) / 2
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
                                console.log("361")
                                screenshotButton.playing = false
                            }
                        }
                    }
                }
            }
        }
    }
}

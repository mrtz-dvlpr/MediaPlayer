import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

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

    signal playAndPauseButtonClicked

    signal stopButtonClicked

    signal videoSliderMoved

    signal ejectButtonClicked

    signal muteButtonClicked

    signal audioSliderMoved

    signal screenshotButtonClicked

    function openScreenshotDialog(name, path) {
        screenshotLabel.text = qsTr(
                    "the " + name + " file saved in \" " + path + " \" directory")
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
                           - durationTiemText.width - 40

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

                    id: durationTiemText

                    text: qsTr(millisToMinutesAndSeconds(setVideoSliderTo))

                    color: subColor
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
                        console.log(test)
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

                // anchors.centerIn: parent
                Button {
                    id: eject

                    width: buttonSize
                    height: width

                    // opacity: 0.3
                    background: Image {
                        source: "qrc:/icons/Pulsar/icons8-eject-96 (1).png"
                    }
                    onClicked: ejectButtonClicked()
                }

                Button {
                    id: playAndPauseButton

                    width: buttonSize
                    height: width

                    // opacity: 0.3
                    background: Image {

                        id: playAndPauseButtonImage
                        source: root.playtAndPauseButtonIconPath
                    }

                    onClicked: playAndPauseButtonClicked()
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
            }
            Item {

                id: rightItem

                anchors.verticalCenter: parent.verticalCenter

                x: parent.width * 9 / 10

                Button {

                    id: screenshotButton

                    anchors.centerIn: parent

                    width: buttonSize * 3 / 4
                    height: width

                    background: Image {
                        source: "qrc:/icons/Pulsar/icons8-take-screenshot-96.png"
                    }

                    onClicked: {
                        screenshotButtonClicked()
                        screenshotMessageTimer.start()
                    }

                    Dialog {

                        id: screenshotMessage

                        x: -rightItem.x + mainRoot.width / 2 - width / 2
                        y: -(mainRoot.height) / 6

                        opacity: 0.5

                        background: Rectangle {
                            color: subColor2
                            radius: 10
                        }

                        Label {
                            id: screenshotLabel
                        }

                        Timer {
                            id: screenshotMessageTimer

                            running: true
                            repeat: false

                            interval: 2000

                            onTriggered: {
                                screenshotMessage.close()
                                console.log("282")
                            }
                        }
                    }
                }
            }
        }
    }
}

import QtQuick
import QtQuick.Controls

Rectangle {

    function millisToMinutesAndSeconds(millis) {
        var minutes = Math.floor(millis / 60000)
        var seconds = ((millis % 60000) / 1000).toFixed(0)
        return minutes + ":" + (seconds < 10 ? '0' : '') + seconds
    }

    id: main

    property string playtAndPauseButtonIconPath: "qrc:/icons/Pulsar/icons8-circled-play-96.png"

    property int buttonSize: 50

    property int videoSliderTo

    property real videoSliderValue

    property int videoSliderFrom

    property bool videoSliderEnable

    property real audioSliderValue: audioSlider.value/audioSlider.to

    signal playAndPauseButtonClicked

    signal stopButtonClicked

    signal videoSliderMoved

    signal ejectButtonClicked

    signal audioSliderMoved

    function getAudioSliderValue() {
        return audioSlider.value
    }

    function getSliderValue() {
        return videoSlider.value
    }

    Column {

        anchors.fill: parent
        spacing: 6

        VideoSlider {

            id: videoSlider

            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            from: videoSliderFrom

            value: videoSliderValue
            to: videoSliderTo
            onMoved: videoSliderMoved()
            enabled: videoSliderEnable
        }
        Item {
            id: mainItem
            width: parent.width
            height: parent.height * 4 / 5

            Row {
                x: parent.width / 30
                anchors.verticalCenter: parent.verticalCenter
                spacing: 4
                Button {
                    width: buttonSize * 3 / 5
                    height: width
                    background: Image {
                        source: "qrc:/icons/Pulsar/icons8-sound-speaker-96.png"
                    }
                }
                AudioSlider {
                    id: audioSlider

                    width: mainItem.width / 10
                    anchors.verticalCenter: parent.verticalCenter

                    from: 0
                    value: 50
                    to: 100

                    onMoved: audioSliderMoved()
                }
                Button {
                    width: buttonSize * 3 / 5
                    height: width
                    background: Image {
                        source: "qrc:/icons/Pulsar/icons8-audio-96 (1).png"
                    }
                }
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
                        source: main.playtAndPauseButtonIconPath
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
        }
    }
}

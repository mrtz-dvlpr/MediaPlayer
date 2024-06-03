import QtQuick
import QtQuick.Controls

Rectangle {

    id: root

    property string playtAndPauseButtonIconPath: "qrc:/icons/Pulsar/icons8-circled-play-96.png"

    property int buttonSize: 50

    property real setVideoSliderTo

    property real setVideoSliderValue

    property bool setVideoSliderEnable

    property real audioSliderValue: audioSlider.value / audioSlider.to

    property real getAudioSliderValue: audioSlider.value / audioSlider.to

    property real getVideoSliderValue: videoSlider.value

    signal playAndPauseButtonClicked

    signal stopButtonClicked

    signal videoSliderMoved

    signal ejectButtonClicked

    signal audioSliderMoved

    function millisToMinutesAndSeconds(millis) {
        var minutes = Math.floor(millis / 60000)
        var seconds = ((millis % 60000) / 1000).toFixed(0)
        return minutes + ":" + (seconds < 10 ? '0' : '') + seconds
    }

    Column {

        anchors.fill: parent
        spacing: 6

        Item {

            id: videoSliderItem

            width: parent.width

            Row {

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
                           - durationTiemText.width - 20

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
        }
    }
}

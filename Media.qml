import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs

Rectangle {

    id: root

    Column {

        visible: mediaPlayer.hasVideo ? false : true
        spacing: 20
        anchors.centerIn: parent

        Image {
            source: "qrc:/icons/Pulsar/icons8-audio-file-96.png"
            width: parent.width
            height: width
        }

        Text {

            id: text
            color: subColor2
            text: qsTr("Audio file")

            x: (parent.width - width) / 2
        }
    }

    property string mediaPlayerSourceUrl

    property real audioVolume

    property bool seekable: mediaPlayer.seekable

    property bool setMuted: false

    property real setPosition

    property real getPosition: mediaPlayer.position

    property real getDuration: mediaPlayer.duration

    property bool getHasVideo: mediaPlayer.hasVideo

    property bool getHasAudio: mediaPlayer.hasAudio

    property bool getPlaying: mediaPlayer.playing

    property int rotationDegrees

    property real mediaPlayerPlaybackRate: 1

    property real getMediaPlayerPlaybackRate: mediaPlayer.playbackRate

    property VideoOutput videoOutput: videoOutput

    property real testX: 1

    property real testY: 1

    property int setMediaPlayerLoops

    property int getMediaPlayerLoops: mediaPlayer.loops

    property real currentScale: 1.0

    signal mediaPlayerPositionChanged

    function play() {
        mediaPlayer.play()
    }

    function stop() {
        mediaPlayer.stop()
    }

    function pause() {
        mediaPlayer.pause()
    }

    rotation: rotationDegrees

    MediaPlayer {

        id: mediaPlayer

        source: mediaPlayerSourceUrl

        position: root.setPosition

        autoPlay: true

        audioOutput: audioOutput

        videoOutput: videoOutput

        onPositionChanged: mediaPlayerPositionChanged()

        playbackRate: mediaPlayerPlaybackRate

        loops: setMediaPlayerLoops
    }

    AudioOutput {
        id: audioOutput
        volume: audioVolume
        muted: root.setMuted
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent

        scale: currentScale

        transform: [
            Scale {
                id: zoomScale

                origin.x: mouseArea.mouseX
                origin.y: mouseArea.mouseY

                xScale: testX
                yScale: testY
            }
        ]

        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }

        focus: true
    }
}

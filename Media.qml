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
            source: mediaPlayer.metaData.coverArtUrlLarg ? mediaPlayer.metaData.coverArtUrlLarg : "qrc:/icons/Pulsar/icons8-audio-file-96.png"
            width: root.width / 10
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {

            id: text
            color: subColor2
            // text: qsTr("Audio file")
            text: qsTr(fileName)
            // x: (parent.width - width) / 2
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    property string setMediaPlayerSourceUrl

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

    property real verticalScale: 1

    property real horizontalScale: 1

    property int setMediaPlayerLoops

    property int getMediaPlayerLoops: mediaPlayer.loops

    property real currentScale: 1.0

    property bool setHasVideo

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

        source: setMediaPlayerSourceUrl

        position: root.setPosition

        autoPlay: false

        audioOutput: audioOutput

        videoOutput: videoOutput

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

                xScale: verticalScale
                yScale: horizontalScale
            }
        ]

        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }

        focus: true
    }
}

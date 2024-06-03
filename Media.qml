import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs

Rectangle {

    id: root

    property string mediaPlayerSourcePath

    property real audioVolume

    signal playOrPause

    signal mediaPlayerPositionChanged

    property bool seekable: mediaplayer.seekable

    property real getPosition: mediaplayer.position

    property real setPosition

    property real getDuration: mediaplayer.duration

    property bool getHasVideo: mediaplayer.hasVideo

    property bool getPlaying: mediaplayer.playing

    function play() {
        mediaplayer.play()
    }

    function stop() {
        mediaplayer.stop()
    }

    function pause() {
        mediaplayer.pause()
    }

    MediaPlayer {

        id: mediaplayer

        source: mediaPlayerSourcePath

        position: root.setPosition

        audioOutput: AudioOutput {

            volume: audioVolume
        }

        videoOutput: videoOutput

        onPlaybackStateChanged: {
            playOrPause()
        }

        onPositionChanged: mediaPlayerPositionChanged()
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
}

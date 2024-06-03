import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs

Rectangle {

    id: root

    property string mediaPlayerSourcePath

    property int audioVolume

    signal playOrPause

    signal mediaPlayerPositionChanged

    function getSeekable() {
        return mediaplayer.seekable
    }

    function getPosition() {
        return mediaplayer.position
    }

    function getDuration() {
        return mediaplayer.duration
    }

    function getHasVideo() {
        return mediaplayer.hasVideo
    }

    function getPlaying() {
        return mediaplayer.playing
    }

    function play() {
        mediaplayer.play()
    }

    function stop() {
        mediaplayer.stop()
    }

    function pause() {
        mediaplayer.pause()
    }

    property real position
    MediaPlayer {

        id: mediaplayer

        source: mediaPlayerSourcePath

        position: root.position

        audioOutput: AudioOutput {

            // device: mediaDevices
            volume: audioVolume

            // onDeviceChanged: {
            //     console.log("Output device changed " + device)
            // }
            // Component.onCompleted: {
            //     console.log(mediaDevices.audioOutputs)
            // }
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

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

    property bool setMuted: false

    property real setPosition

    property real getPosition: mediaplayer.position

    property real getDuration: mediaplayer.duration

    property bool getHasVideo: mediaplayer.hasVideo

    property bool getPlaying: mediaplayer.playing


    property VideoOutput test:videoOutput

    function play() {
        mediaplayer.play()
        console.log(audioOutput.muted)
        console.log(setMuted)
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
            id: audioOutput
            volume: audioVolume
            muted: root.setMuted
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

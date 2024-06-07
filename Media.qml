import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs

Rectangle {

    id: root

    property string mediaPlayerSourceUrl

    property real audioVolume

    signal playOrPause

    signal mediaPlayerPositionChanged

    property bool seekable: mediaPlayer.seekable

    property bool setMuted: false

    property real setPosition

    property real getPosition: mediaPlayer.position

    property real getDuration: mediaPlayer.duration

    property bool getHasVideo: mediaPlayer.hasVideo

    property bool getPlaying: mediaPlayer.playing

    property real mediaPlayerPlaybackRate: 1

    function play() {
        mediaPlayer.play()
        console.log(audioOutput.muted)
        console.log(setMuted)
    }

    function stop() {
        mediaPlayer.stop()
    }

    function pause() {
        mediaPlayer.pause()
    }

    MediaPlayer {

        id: mediaPlayer

        source: mediaPlayerSourceUrl

        position: root.setPosition

        audioOutput: AudioOutput {
            id: audioOutput
            volume: audioVolume
            muted: root.setMuted
        }

        videoOutput: videoOutput

        onPlaybackStateChanged: {
            playOrPause()
            // if (!metaData.isEmpty()) {
            //     // [14,10,13,15,27,12,26,2,16,17]
            //     if (metaData) {
            //         for (var key of metaData.keys()) {
            //             if (metaData.stringValue(key)) {

            //                 console.log(metaData.metaDataKeyToString(
            //                                 key) + " : " + metaData.stringValue(
            //                                 key))
            //                 // elements.append(
            //                 //             { name: metadata.metaDataKeyToString(key)
            //                 //             , value: metadata.stringValue(key)
            //                 //             })
            //             }
            //         }
            //     }
            // }
        }

        onPositionChanged: mediaPlayerPositionChanged()

        playbackRate: mediaPlayerPlaybackRate
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
}

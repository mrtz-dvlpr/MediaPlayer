import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs

Rectangle {

    id: root

    property string mediaplayerSourceUrl

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

    property VideoOutput videoOutput: videoOutput

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

        source: mediaplayerSourceUrl

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
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
}

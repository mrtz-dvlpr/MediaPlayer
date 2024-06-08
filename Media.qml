import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs

Rectangle {

    id: root

    property string mediaPlayerSourceUrl

    property real audioVolume

    property bool seekable: mediaPlayer.seekable

    property bool setMuted: false

    property real setPosition

    property real getPosition: mediaPlayer.position

    property real getDuration: mediaPlayer.duration

    property bool getHasVideo: mediaPlayer.hasVideo

    property bool getPlaying: mediaPlayer.playing

    property int rotationDegrees

    property real mediaPlayerPlaybackRate: 1

    property VideoOutput videoOutput: videoOutput

    signal playOrPause

    signal mediaPlayerPositionChanged

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

    rotation: rotationDegrees

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

    property real minScale: 1.0
    property real maxScale: 5.0
    property real currentScale: 1.0

    VideoOutput {
        id: videoOutput
        anchors.fill: parent

        scale: currentScale

        transform: [
            Scale {
                id: zoomScale
            }
            // ,
            // Translate {
            //     id: zoomTranslate
            // }
        ]

        focus: true

        property real zoomSize: 1

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons

            onWheel: {
                videoOutput.zoomSize += wheel.angleDelta.y
                        > 0 ? (videoOutput.zoomSize
                               < 2 ? 0.1 : 0) : (videoOutput.zoomSize > -2 ? -0.1 : 0)
            }

            onDoubleClicked: {

                if (zoomScale.xScale + videoOutput.zoomSize > 1
                        || zoomScale.yScale + videoOutput.zoomSize > 1) {

                    zoomScale.origin.x = mouse.x
                    zoomScale.origin.y = mouse.y
                    zoomScale.xScale += videoOutput.zoomSize
                    zoomScale.yScale += videoOutput.zoomSize
                } else {
                    zoomScale.xScale = 1
                    zoomScale.yScale = 1
                }
            }
        }

        Keys.onEscapePressed: {
            zoomScale.yScale = 1
        }
    }
} // MouseArea {//     anchors.fill: parent//     onWheel: {//         var mouseX = mouse.x//         var mouseY = mouse.y//         var newScale = currentScale//         if (wheel.angleDelta.y > 0) {
//             newScale *= 1.1
//         } else {
//             newScale /= 1.1
//         }
//         newScale = Math.max(minScale, Math.min(newScale, maxScale))
//         currentScale = newScale
//         videoOutput.scale = currentScale
//         videoOutput.transformOrigin = Qt.point(mouseX, mouseY)
//     }
// }

//        MouseArea {
//            anchors.fill: parent
//            onWheel: {
//                if (wheel.angleDelta.y > 0) {
//                    videoOutput.scale *= 1.1
//                } else {
//                    videoOutput.scale /= 1.1
//                }
//            }
//        }

// MouseArea {
//     id: mouseArea
//     anchors.fill: parent

//     onWheel: {
//         zoomScale.origin.x = mouseArea.mouseX
//         zoomScale.origin.y = mouseArea.mouseY

//         zoomScale.xScale *= wheel.angleDelta.y > 0 ? 1.1 : 0.909090
//         zoomScale.yScale *= wheel.angleDelta.y > 0 ? 1.1 : 0.909090
//     }

//     onDoubleClicked: {
//         zoomScale.xScale = 1
//         zoomScale.yScale = 1
//     }
// }


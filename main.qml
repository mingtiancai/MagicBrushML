import QtQuick
import QtQuick.Window
import QtQuick3D
import QtQuick.Controls
import Qt.labs.platform
import QtQuick.Layouts
import QtQml
import QtQuick3D.Helpers

ApplicationWindow {
    width: 1024
    height: 768
    visible: true
    title: qsTr("MagicBrushML");

    MenuBar{
        Menu{
            title: qsTr("&File")
            MenuItem{
                text: qsTr("&Open")
            }

            MenuItem{
                text: qsTr("&Close")
                onTriggered: close()
            }
        }

        Menu{
            title: qsTr("&Edit")
        }

        Menu{
            title: qsTr("&View")
        }

        Menu{
            title: qsTr("&Render")
        }

        Menu{
            title: qsTr("&Window")
        }

        Menu{
            title: qsTr("&Run")
        }

        Menu{
            title: qsTr("&Tools")
        }

        Menu{
            title: qsTr("&Help")
        }
    }

    View3D {
        id: view3D
        anchors.fill: parent
        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
            clearColor: "#3a4055"
            backgroundMode: SceneEnvironment.Color
        }

        MouseArea{
            id:mouse
            anchors.fill: parent
            property int cx: 0
                property int cy: 0
                    onWheel: function(wheel){
                    if (wheel.angleDelta.y>0)
                        camera.z = camera.z+5
                    else
                        camera.z = camera.z-5
                    }
                    onPressed:function(mouse) {
                    cx = mouse.x
                    cy = mouse.y
                }

                onPositionChanged: function(mouse){
                var intervalX = mouse.x-cx
                var intervalY = mouse.y-cy
                cameraNode.eulerRotation.y = intervalX+cameraNode.eulerRotation.y
                cameraNode.eulerRotation.x = cameraNode.eulerRotation.x-intervalY
                cx = mouse.x
                cy = mouse.y

            }
        }
        Node {
            id: node
            DirectionalLight {
                id: directionalLight
            }

            Model {
                id: cubeModel
                source:"./data/mesh/test.mesh";
                DefaultMaterial {
                    id: cubeMaterial
                    diffuseColor: "#b5bcd7"
                }
                materials: cubeMaterial
            }
        }

        Node{
            id:cameraNode

            PerspectiveCamera {
                id: camera
                z: 15
            }
        }

        DebugView {
            source: view3D
        }
        AxisHelper {
            scale: Qt.vector3d(0.01, 0.01, 0.01)
            enableAxisLines: true
            enableXYGrid: true
            enableXZGrid: false
            enableYZGrid: false
        }
    }
}

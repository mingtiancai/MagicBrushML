import QtQuick
import QtQuick3D
import QtQuick3D.Helpers

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("MagicBrushML")

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
                    onWheel: {
                        if (wheel.angleDelta.y>0)
                            camera.z = camera.z+5
                        else
                            camera.z = camera.z-5
                        }
                    }
                    Node {
                        id: node
                        DirectionalLight {
                            id: directionalLight
                        }

                        Model {
                            id: cubeModel
                            source: "data/mesh/test.mesh"
                            DefaultMaterial {
                                id: cubeMaterial
                                diffuseColor: "#4aee45"
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
                    WasdController {
                        controlledObject: cameraNode
                    }

                }
            }

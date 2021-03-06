import QtQuick 2.15
import QtQuick3D 1.15

//渲染3D场景的视口
View3D {
    environment: SceneEnvironment {
        clearColor: "darkGreen"
        backgroundMode: SceneEnvironment.Color
    }

    //透视投影
    PerspectiveCamera {
        id: camera
        position: Qt.vector3d(-80, -20, 300)
        //eulerRotation.x: -30
    }

    //光源
    DirectionalLight {
        eulerRotation.x: -100
        eulerRotation.y: -100
        eulerRotation.z: 500
    }

    //加载3D模型数据
    //为了使模型可渲染，它至少需要一个网格Mesh和一种材料Material
    //圆球
    Model {
        position: Qt.vector3d(0, 0, 0)
        source: "#Sphere"
        materials: [ DefaultMaterial {
                diffuseColor: "blue"
            }
        ]
    }
    //矩形
    Model {
        position: Qt.vector3d(-100, -100, 0)
        source: "#Cube"
        scale: Qt.vector3d(2, 0.1, 1)
        eulerRotation: Qt.vector3d(0,0,-20)
        materials: [ DefaultMaterial {
                diffuseColor: "red"
            }
        ]
    }
}

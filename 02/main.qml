import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick3D 1.15
import QtMultimedia 5.0

import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import  QtQuick.Scene3D  2.0
import  Qt3D.Core  2.0
import  Qt3D.Render  2.0
import  Qt3D.Input  2.0
import  Qt3D.Extras  2.0
ApplicationWindow {
    visible: true
    width: 1440
    height: 900
    title: "创新实践植物三维";
    id: root;

    FileDialog
    {
        id: fileDialog
        onAccepted:
        {
            mesh.source = fileDialog.fileUrl
        }
    }

    menuBar: MenuBar{
        id:menu
        Menu {
            title: "文件";
            MenuItem{
                text: "图片";
//                icon.source:"qrc:/icon/picture.png"
            }
            MenuItem{
                text: "视频";
//                icon.source:"qrc:/icon/video.png"
            }
            MenuItem{
                text: "退出";
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: "处理";
            InputDialog{id:input}
            MenuItem{
                objectName: "CameraCalibrate"
                text: "相机标定";
                onTriggered:{
                    input.visible=true;

                }
//                icon.source:"qrc:/icon/camera.png"
            }
            MenuItem{
                text: "3D化";
//                icon.source:"qrc:/icon/3D.png"
            }
        }
        Menu {
            title: "可视化";
            MenuItem{
                text: "3D状态";
//                icon.source:"qrc:/icon/3D.png"
                onTriggered: fileDialog.open()
            }
        }
    }
    Rectangle{
        id:area_3D
        width:parent.width/5*3
        height:parent.height
        Scene3D
        {
            anchors.fill: parent

            aspects: [ "input" ,  "logic" ]
            cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

            Entity
            {
                id: sceneRoot

                Camera
                {
                    id: camera
                    projectionType: CameraLens.PerspectiveProjection
                    fieldOfView:  30
                    aspectRatio:  16 / 9
                    nearPlane :  0.1
                    farPlane :  1000.0
                    position: Qt.vector3d(10.0,0.0,10.0)
                    upVector: Qt.vector3d(0.0,1.0 ,0.0)
                    viewCenter: Qt.vector3d(0.0,0.0,0.0)
                }

                OrbitCameraController
                {
                    camera: camera
                }

                components: [
                    RenderSettings
                    {
                        activeFrameGraph: ForwardRenderer
                        {
                            clearColor: Qt.rgba(0,0.5,1,1)
                            camera: camera
                        }
                    },
                    InputSettings
                    {
                    }
                ]

                Mesh {
                    id: mesh
                }

                PhongMaterial {
                    id: phongmaterial
                    ambient: Qt.rgba( 0.6, 0.2, 0.1, 1 )
                    diffuse: Qt.rgba( 0.2, 0.6, 0.1, 1 )
                    specular: Qt.rgba( 0.2, 0.9, 0.1, 1 )
                    shininess: 1
                }

                Entity
                {
                    id: treeEntity

                    components: [
                        mesh,
                        phongmaterial
                    ]
                }
            }
        }

    }
    Rectangle{
        id:video
        x:area_3D.width
        width:parent.width/5*2
        height:parent.height/2
        color:"black"
        Column{
            Rectangle{
                id:screen
                color:"black"
                width:video.width
                height: video.height-50
                MediaPlayer{
                    id:player
                    source: fd.fileUrl
                    autoPlay: true
                    volume: voice.value
                }
                VideoOutput {
                    anchors.fill: parent
                    source: player
                }
            }
            Rectangle{
                id:control
                color:"#80202020"
                border.color: "gray"
                border.width: 1
                width:video.width
                height: 20
                Row{
                    spacing: 10
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 10
                    anchors.left: parent.left
                    //调节播放速度
                    Slider{
                        id:playPos
                        width: video.width*0.75
                        height: 10
                        maximumValue: video.duration
                        minimumValue: 0
                        value:player.position
                        anchors.verticalCenter: parent.verticalCenter
                        stepSize:1000
                        style: SliderStyle {
                            groove: Rectangle {
                                width: video.width*0.8
                                height: 8
                                color: "gray"
                                radius: 2
                                Rectangle {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: player.duration>0?parent.width*player.position/player.duration:0
                                    color: "blue"
                                }
                            }
                            handle: Rectangle {
                                anchors.centerIn: parent
                                color: control.pressed ? "white" : "darkgray"
                                border.color: "gray"
                                border.width: 2
                                implicitWidth: 15
                                implicitHeight: 15
                                radius:7.5
                                Rectangle{
                                    width: parent.width-8
                                    height: width
                                    radius: width/2
                                    color: "blue"
                                    anchors.centerIn: parent
                                }
                            }
                        }
                        //点击鼠标设置播放位置
                        MouseArea {
                            property int pos
                            anchors.fill: parent
                            onClicked: {
                                if (player.seekable)
                                    pos = player.duration * mouse.x/parent.width
                                player.seek(pos)
                                playPos.value=pos;
                            }
                        }
                    }
                    Image{
                        width: 15
                        height: 15
//                        source: "./Images/voice.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    //调节音量
                    Slider{
                        id:voice
                        width: video.width*0.15
                        height: 10
                        value:player.volume
                        stepSize: 0.1
                        maximumValue: 1
                        minimumValue: 0
                        anchors.verticalCenter: parent.verticalCenter
                        style: SliderStyle {
                            groove: Rectangle {
                                implicitWidth: video.width*0.2
                                implicitHeight: 8
                                color: "gray"
                                radius: 2
                                Rectangle {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: player.volume>0?parent.width*player.volume:0
                                    color: "blue"
                                }
                            }
                            handle: Rectangle {
                                anchors.centerIn: parent
                                color: control.pressed ? "white" : "darkgray"
                                border.color: "gray"
                                border.width: 2
                                implicitWidth: 15
                                implicitHeight: 15
                                radius:7.5
                                Rectangle{
                                    width: parent.width-8
                                    height: width
                                    radius: width/2
                                    color: "blue"
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }
            }
            //控制区域
            Rectangle{
                id:bottom
                color:"#80202020"
                border.color: "gray"
                border.width: 1
                width: video.width
                height: 30
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    spacing: 10
                    Button{
                        width: 30
                        height: 20
                        property int status: 1  //默认播放
                        iconSource: "qrc:/icon/play.png"
                        onClicked: {
                            if(status==1)
                            {
                                player.pause();
                                tooltip="开始";
                                console.log("start")
                                status=0;
                                iconSource: "qrc:/icon/play.png"
                            }
                            else{
                                player.play() ;
                                tooltip="暂停";
                                console.log("pause")
                                status=1;
                                iconSource: "qrc:/icon/pause.png"
                            }
                        }
                    }
                    Button{
                        width: 30
                        height: 20
                        onClicked: player.stop()
                        tooltip: "停止"
                        iconSource: "qrc:/icon/stop.png"
                    }
                    //快进快退10s
                    Button{
                        width: 30
                        height: 20
                        onClicked: player.seek(player.position+10000)
                        tooltip: "快退"
                        iconSource: "qrc:/icon/back.png"
                    }
                    Button{
                        width: 30
                        height: 20
                        onClicked: player.seek(player.position-10000)
                        tooltip: "快进"
                        iconSource: "qrc:/icon/pass.png"
                    }
                    Button{
                        width: 30
                        height: 20
                        tooltip: "打开文件"
                        onClicked: fd.open()
                        iconSource: "qrc:/icon/video.png"
                        FileDialog{
                            id:fd
                            nameFilters: ["Vedio Files(*.avi *.mp4 *rmvb *.rm)"]  //格式过滤
                            selectMultiple: false
                        }
                    }
                    Text{
                        anchors.verticalCenter: parent.verticalCenter
                        text:parent.currentTime(player.position)+"/"+parent.currentTime(player.duration)
                        color: "white"
                    }
                    //时间格式化
                    function currentTime(time)
                    {
                        var sec= Math.floor(time/1000);
                        var hours=Math.floor(sec/3600);
                        var minutes=Math.floor((sec-hours*3600)/60);
                        var seconds=sec-hours*3600-minutes*60;
                        var hh,mm,ss;
                        if(hours.toString().length<2)
                            hh="0"+hours.toString();
                        else
                            hh=hours.toString();
                        if(minutes.toString().length<2)
                            mm="0"+minutes.toString();
                        else
                            mm=minutes.toString();
                        if(seconds.toString().length<2)
                            ss="0"+seconds.toString();
                        else
                            ss=seconds.toString();
                        return hh+":"+mm+":"+ss
                    }
                }
            }
        }
    }
    Rectangle{
        id:picture
        x:area_3D.width
        y:video.height
        width:parent.width/5*2
        height:parent.height/2
        ListView {
            id: listview
            height: 100
            anchors{
                left: parent.left
                right: parent.right
                top: parent.top
            }
            orientation: Qt.Horizontal
            delegate:
                Image {
                source: modelData
            }
        }
        Component.onCompleted: {
            var images = [
                        "http://doc.qt.io/qt-5/images/declarative-qtlogo.png",
                        "http://doc.qt.io/qt-5/images/declarative-qtlogo.png",
                        "http://doc.qt.io/qt-5/images/declarative-qtlogo.png",
                        "http://doc.qt.io/qt-5/images/declarative-qtlogo.png"
                    ]
            listview.model = images
        }
    }
}

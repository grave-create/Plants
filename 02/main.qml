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
ApplicationWindow {
    visible: true
    width: 1440
    height: 900
    color: "white";
    title: "创新实践植物三维";
    id: root;
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
            MenuItem{
                text: "相机处理";
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
            }
        }
    }
    Rectangle{
        id:area_3D
        width:parent.width/5*3
        height:parent.height
//        gradient: Gradient{
//            GradientStop{ position: 0.0; color: "lightsteelblue" }
//            GradientStop{ position: 1.0; color: "slategray" }
//        }
//        Text{
//            text:"3D显示区"
//            anchors.centerIn: parent
//        }
        FirstModel{
            id:firstmodel
            visible:true
            anchors.fill: parent
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
                        height: 30
                        property int status: 1  //默认播放
    //                    iconImage: "./Images/pause.png"
                        onClicked: {
                            if(status===1)
                            {
                                player.pause();
                                tooltip="开始";
                                console.log("start")
                                status=0;
                                iconImage="./Images/play.png"
                            }
                            else{
                                player.play() ;
                                tooltip="暂停";
                                console.log("pause")
                                status=1;
                                iconImage="./Images/pause.png"
                            }
                        }
                    }
                    Button{
                        width: 30
                        height: 30
                        onClicked: player.stop()
                        tooltip: "停止"
    //                    iconImage: "./Images/stop.png"
                    }
                    //快进快退10s
                    Button{
                        width: 30
                        height: 30
                        onClicked: player.seek(player.position+10000)
                        tooltip: "快退"
    //                    iconImage: "./Images/back.png"
                    }
                    Button{
                        width: 30
                        height: 30
                        onClicked: player.seek(player.position-10000)
                        tooltip: "快进"
    //                    iconImage: "./Images/pass.png"
                    }
                    Button{
                        width: 30
                        height: 30
                        tooltip: "打开文件"
                        onClicked: fd.open()
    //                    iconImage: "./Images/add.png"
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
//        MediaPlayer {
//                id: player;
////                source: "C:/Users/12974/Desktop";视频位置

//                onError: {
//                    console.log(errorString);
//                }
//            }

//            VideoOutput {
//                anchors.fill: parent;
//                source: player;
//            }

//            MouseArea {
//                anchors.fill: parent;
//                onClicked: {
//                    player.play();
//                }
//            }

//        gradient: Gradient{
//            GradientStop{ position: 0.0; color: "lightsteelblue" }
//            GradientStop{ position: 1.0; color: "slategray" }
//        }
//        Text{
//            text:"视频显示区"
//            anchors.centerIn: parent
//        }
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
//        gradient: Gradient{
//            GradientStop{ position: 0.0; color: "lightsteelblue" }
//            GradientStop{ position: 1.0; color: "slategray" }
//        }
//        Text{
//            text:"照片显示区"
//            anchors.centerIn: parent
//        }
    }
}

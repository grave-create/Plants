import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Dialogs 1.2
Dialog{
    id:input
    visible: false
    width: 320
    height: 240

    Row {
        spacing: 10

        Text { text: qsTr("请输入棋盘格行数:"); font.pointSize: 15
            verticalAlignment: Text.AlignVCenter }

        Rectangle {
            width: 100
            height: 24
            color: "lightgrey"
            border.color: "grey"

            TextInput {
                 id:board_size_x
                anchors.fill: parent
                anchors.margins: 2
                font.pointSize: 15
                focus: true
            }
        }
    }
    Row {
        spacing: 10
        y:60
        Text { text: qsTr("请输入棋盘格列数:"); font.pointSize: 15
            verticalAlignment: Text.AlignVCenter }

        Rectangle {
            width: 100
            height: 24
            color: "lightgrey"
            border.color: "grey"

            TextInput {
                id:board_size_y
                anchors.fill: parent
                anchors.margins: 2
                font.pointSize: 15
                focus: true
            }
        }
    }
    Row {
        spacing: 10
        y:120
        Text { text: qsTr("请输入棋盘中格子宽(mm):"); font.pointSize: 15
            verticalAlignment: Text.AlignVCenter }

        Rectangle {
            width: 100
            height: 24
            color: "lightgrey"
            border.color: "grey"

            TextInput {
                id:square_size_x
                anchors.fill: parent
                anchors.margins: 2
                font.pointSize: 15
                focus: true
            }
        }
    }
    Row {
        spacing: 10
        y:180
        Text { text: qsTr("请输入棋盘中格子高(mm):"); font.pointSize: 15
            verticalAlignment: Text.AlignVCenter }

        Rectangle {
            width: 100
            height: 24
            color: "lightgrey"
            border.color: "grey"

            TextInput {
                id:square_size_y
                anchors.fill: parent
                anchors.margins: 2
                font.pointSize: 15
                focus: true
            }
        }
    }

   onAccepted:{
        CameraCalibrator.setBoardSize(board_size_x.text,board_size_y.text,square_size_x.text,square_size_y.text);
        CameraCalibrator.CarmeraCalibrate();
    }
}

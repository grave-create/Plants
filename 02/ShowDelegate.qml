import QtQuick 2.0
import QtQuick.Controls 2.2
Button {
    id:imageContainer
    width: grid.cellWidth
    height: grid.cellHeight
    anchors.margins: 10
   // radius: 10
   // border.color: "black"
   // color: pictureIndex === model.index ? "#2770DF" :"#ffffff"
    background: Rectangle {
        radius: 10
        color: "#ffffff"
        border.color: pictureIndex == index ? "#2770DF" :
                       hovered ? "#6C6A6A" : "transparent"
        border.width: 3
    }
    Image{
        anchors.horizontalCenter:   parent.horizontalCenter
        anchors.verticalCenter:     parent.verticalCenter
        source:                     model.picSrc
        sourceSize.width:           parent.width * 0.90
        sourceSize.height:          parent.height * 0.90
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            pictureIndex=model.index
            mainImage.source=model.picSrc
            console.log(parent.width, parent.height)
            console.log(model.picSrc)
        }
    }
}

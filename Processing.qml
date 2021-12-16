import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 6.0

Rectangle {
    
    id: root
    color: myBackground

    AnimatedImage {
        id: animation;
        width: 60
        height: 60
        anchors.verticalCenter: parent.verticalCenter
        source: "icons/load.webp" ;
        autoTransform: true
        playing: true
        asynchronous: true
        anchors.horizontalCenter: parent.horizontalCenter
}
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}
}
##^##*/

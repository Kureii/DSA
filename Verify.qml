import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Layouts 6.0
import QtQuick.Dialogs


Rectangle {
    
    id: root
    signal buttonClicked();


    Button {
        height: 66
        width:302
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        enabled: true
        background: Rectangle {
            anchors.fill: parent
            color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
            radius: 0

            Label{
                text: nameLoadArch
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Roboto Medium"
                color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
            }
        }
        onClicked: {
            root.buttonClicked();
        }
    }
}


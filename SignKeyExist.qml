import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Layouts 6.0


GridLayout {
    
    id: root
    signal yes()
    signal no()
    signal back()
    rowSpacing: 0
    columnSpacing: 0
    columns: 3


    Label {
        text: nameKeyExist
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        Layout.columnSpan: 3
        Layout.minimumHeight: 28
        Layout.fillWidth: true
        Layout.fillHeight: false
        font.family: "Roboto Medium"
        color: myWhiteFont
    }

    Button {
        Layout.bottomMargin: 0
        Layout.topMargin: 0
        Layout.minimumHeight: 32
        Layout.maximumHeight:32
        Layout.fillWidth: true
        enabled: true
        onClicked: {
            root.yes();
        }
        background: Rectangle {
            anchors.fill: parent
            color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
            radius: 0

            Label{
                text: nameOverwrite
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Roboto Medium"
                color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
            }
        }
    }

    Button {
        Layout.fillHeight: true
        Layout.bottomMargin: 0
        Layout.topMargin: 0
        Layout.minimumHeight: 32
        Layout.maximumHeight: 32
        Layout.fillWidth: true
        enabled: true
        background: Rectangle {
            anchors.fill: parent
            color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
            radius: 0

            Label{
                text: nameSlcOF
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Roboto Medium"
                color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
            }
        }
        onClicked: {
            root.no();
        }
    }

    Button {
        Layout.fillHeight: true
        Layout.bottomMargin: 0
        Layout.topMargin: 0
        Layout.minimumHeight: 32
        Layout.maximumHeight: 32
        Layout.fillWidth: true
        enabled: true
        background: Rectangle {
            anchors.fill: parent
            color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
            radius: 0

            Label{
                text: nameBack
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Roboto Medium"
                color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
            }
        }
        onClicked: {
            root.back();
        }
    }
}

import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Layouts 6.0
import QtQuick.Dialogs


GridLayout {
    
    id: root
    signal buttonClicked();
    rowSpacing: 0
    columnSpacing: 0
    columns: 2


    Label {
        text: "Language / Jazyk"
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        Layout.columnSpan: 2
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
            myLang.getLang("eng_US")
            root.buttonClicked();
        }
        background: Rectangle {
            anchors.fill: parent
            color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
            radius: 0

            Label{
                text: "English"
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
                text: "Czech"
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Roboto Medium"
                color: parent.parent.down ? myUpperBar : (parent.parent.hovered ? Qt.darker(myWhiteFont, 1.25) : myWhiteFont)
            }
        }
        onClicked: {
            myLang.getLang("cs_CZ")
            root.buttonClicked();
        }
    }
}

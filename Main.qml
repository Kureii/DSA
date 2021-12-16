import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 6.0
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects

Window {
    id: mainWindow
    visible: true
    width: 310
    height: 100
    color: "transparent"

    flags:  Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    property bool activeWindow: true

    property string nameAction: ""
    property string nameSing: ""
    property string nameVeri: ""
    property string nameChose: ""
    property string nameFile: ""
    property string nameFolder: ""
    property string nameKey: ""
    property string nameGen: ""
    property string nameIncK: ""
    property string nameY: ""
    property string nameN: ""
    property string nameSaveArch: ""
    property string nameLoadArch: ""
    property string nameWait: ""

    property color tmpEncodingClr: "#fff"
    property color tmpDecodingClr: "#fff"

    readonly property color myUpperBar: "#1a1512"
    readonly property color myBackground: "#201e1b"
    readonly property color myWhiteFont: "#e4f8ff"
    readonly property color myBackground2: "#acb1aa"
    readonly property color myHighLighht: "#F9D800"//"#3fa108"
    readonly property color myCloseImg: "#fcf8fe"
    readonly property color myCloseBtn: "#de2f05"

    property bool wasEncodedText: false
    property bool wasOpenText: false
    property bool wasNkeyD: false
    property bool wasNkeyE: false
    property bool wasDKey: false
    property bool wasEKey: false
    property bool wasEncDone: false
    property bool wasDecDone: false

    /*function getX(x){
        if(!lang.running && !timeline.enabled){
            let tmp = x - 150
            if (tmp > 0) {
                return tmp
            } else {
                return 0
            }
        } else {
            return myX
        }
    }

    function getOldX(x){
        if(!lang.running && !timeline.enabled){
            return x
        } else {
            return myOldX
        }
    }

    function getY(y){
        if(!lang.running && !timeline.enabled){
            let tmp = y - 114
            if (tmp > 0) {
                return tmp
            } else {
                return 0
            }
        } else {
            return myY
        }
    }

    function getOldY(y){
        if(!lang.running && !timeline.enabled){
            return y
        } else {
            return myOldY
        }
    }*/

    Flickable {
        id: flickable
        anchors.fill: parent
        transformOrigin: Item.Center

        // window
        Rectangle {
            id: window
            anchors.fill: parent
            anchors.bottomMargin: 0
            color: myBackground
            radius: 4
            border.color: myUpperBar
            border.width: 4

            GridLayout {
                anchors.fill: parent
                rowSpacing: 0
                columns: 1
                columnSpacing: 2

                //upperBar
                Rectangle {
                    id: upperBar
                    color: myUpperBar
                    radius: 4
                    Layout.rightMargin: 0
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.maximumHeight: 30
                    Layout.minimumHeight: 30
                    Layout.fillWidth: true

                    Rectangle {
                        width: 200
                        height: 8
                        color: myUpperBar
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                    }

                    RowLayout {
                        anchors.fill: parent

                        MouseArea {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            property variant clickPos: "1,1"
                            onPressed: {
                                clickPos  = Qt.point(mouseX,mouseY)
                            }
                            onPositionChanged: {
                                var delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
                                mainWindow.x += delta.x;
                                mainWindow.y += delta.y;
                            }
                        }

                        RowLayout {
                            width: 60
                            Layout.rightMargin: 0
                            layoutDirection: Qt.LeftToRight
                            Layout.columnSpan: 2
                            Layout.fillWidth: false
                            Layout.fillHeight: true
                            spacing: 0

                            Button {
                                Layout.minimumWidth: 30
                                Layout.minimumHeight: 30
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                enabled: true
                                visible: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                background: Rectangle{
                                    color: parent.pressed ? Qt.tint(Qt.lighter(myUpperBar, 2.5), "#100c03FF") : (parent.hovered ? Qt.tint(Qt.lighter(myUpperBar, 3), "#100c03FF") : myUpperBar)
                                    Rectangle{
                                        width: 12
                                        height: 2
                                        color: parent.parent.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 10
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        radius: 1
                                    }
                                }
                                onClicked: mainWindow.showMinimized()
                            }

                            Button {
                                Layout.minimumWidth: 30
                                Layout.minimumHeight: 30
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                background: Rectangle{
                                    id: rectangle1
                                    color: parent.pressed ? Qt.darker(myCloseBtn, 1.5) : (parent.hovered ? myCloseBtn : myUpperBar)
                                    radius: 4

                                    Rectangle {
                                        width: 30
                                        height: 6
                                        anchors.bottom: parent.bottom
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.bottomMargin: 0
                                        color: parent.color
                                    }

                                    Rectangle {
                                        width: 6
                                        height: 30
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: 0
                                        color: parent.color
                                    }

                                    Rectangle{
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: 45
                                        color: parent.parent.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                    Rectangle{
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: -45
                                        color: parent.parent.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }

                                }
                                onClicked: mainWindow.close()
                            }

                        }
                    }

                    Text {
                        text: "DSA"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 36
                        font.family: "Roboto Medium"
                        font.weight: Font.Medium
                        color: myWhiteFont

                    }

                    Button {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        height: 30
                        width: 30
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        background: Rectangle{
                            color: parent.pressed ? Qt.tint(Qt.lighter(myUpperBar, 2.5), "#100c03FF") : (parent.hovered ? Qt.tint(Qt.lighter(myUpperBar, 3), "#100c03FF") : myUpperBar)
                            radius: 4
                            Rectangle {
                                width: 30
                                height: 6
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottomMargin: 0
                                color: parent.color
                            }

                            Rectangle {
                                width: 6
                                height: 30
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 0
                                color: parent.color
                            }
                            Image {
                                horizontalAlignment: Image.AlignLeft
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                source: "icons/TaskBar.svg"
                                anchors.leftMargin: 5
                                anchors.topMargin: 5
                                anchors.bottomMargin: 5
                                sourceSize.height: 20
                                sourceSize.width: 20
                            }
                           
                        }
                        onClicked: stack.pop(lang)
                    }
                }
                
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    visible:true
                    color: "transparent"
                    StackView {
                        id: stack
                        anchors.fill: parent
                        anchors.leftMargin: 4
                        anchors.rightMargin:4
                        anchors.bottomMargin: 4
                        initialItem: lang
                    }

                    Lang {
                        id: lang
                        visible: true
                        onButtonClicked: {
                            stack.push(singVerify)
                        }
                    }

                    SingVerify {
                        id: singVerify
                        visible: false
                        onSing: {
                            stack.push(sing)
                        }
                        onVerify: {
                            stack.push(verify)
                        }
                    }

                    Sing {
                        id: sing
                        visible: false
                        onButtonClicked: {
                            stack.push(singKey)
                        }
                    }

                    SingKey {
                        id: singKey
                        visible: false
                        onButtonClicked: {
                            stack.push(singSave)
                        }
                    }

                    SingSave {
                        id: singSave
                        visible: false
                        onButtonClicked: {
                            stack.push(singSaveAs)
                        }
                    }

                    SingSaveAs{
                        id: singSaveAs
                        visible: false
                        onButtonClicked: {
                            stack.push(singSaveAs)
                        }
                    }

                    Verify {
                        id: verify
                        visible: false
                        onButtonClicked: {
                            stack.push(proc)
                        }

                    Processing {
                        id: proc
                        visible: false
                    }

                    }
                    Rectangle{
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.top: parent.top
                        anchors.bottomMargin: 4
                        width:4
                        color: myUpperBar
                    }
                    Rectangle{
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.top: parent.top
                        anchors.bottomMargin: 4
                        width:4
                        color: myUpperBar
                    }
                }
            }
        }
    }

    Connections {
        target: myData
        function onMyNKey(n) {
            myNKey = nameNKey + ": " + n
        }

        function onMyEKey(e) {
           myEKey = nameEKey + ": " + e
        }

        function onMyDKey(d) {
            myDKey = nameDKey + ": " + d
        }

        function onMyEncoding(x) {
            myEncoding = x
        }
        function onMyDecoding(y) {
            myDecoding = y
        }
    }

    Connections {
        target: myLang
        function onNameAction(x) {
            nameAction = x
        }
        function onNameSing(x) {
            nameSing = x
        }
        function onNameVeri(x) {
            nameVeri = x
        }
        function onNameChose(x) {
            nameChose = x
        }
        function onNameFile(x) {
            nameFile = x
        }
        function onNameFolder(x) {
            nameFolder = x
        }
        function onNameKey(x) {
            nameKey = x
        }
        function onNameGen(x) {
            nameGen = x
        }
        function onNameIncK(x) {
            nameIncK = x
        }
        function onNameY(x) {
            nameY = x
        }
        function onNameN(x) {
            nameN = x
        }
        function onNameSaveArch(x) {
            nameSaveArch = x
        }
        function onNameLoadArch(x) {
            nameLoadArch = x
        }
        function onNameWait(x) {
            nameWait = x
        }
    }

}



import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 6.0
import QtQuick.Dialogs
import Qt.labs.platform

Window {
    id: mainWindow
    visible: true
    width: 310
    height: 100
    color: "transparent"

    flags:  Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    property bool activeWindow: true
    property bool findKPub: false
    property bool findSign: false
    property bool havePub: false
    property bool keysExist: false

    property string nameToolTip: ""
    property string nameAction: ""
    property string nameSign: ""
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
    property string namePrivKeyFilter: ""
    property string nameSignFinal: ""
    property string nameSlctVerFile: ""
    property string nameSlctPubKey: ""
    property string nameSlctSign: ""
    property string namePubKey: ""
    property string nameSignFile: ""
    property string nameBack: ""
    property string nameSelect: ""
    property string nameVerifed: ""
    property string nameKeyExist:""
    property string nameOverwrite:""
    property string nameSlcOF:""
    property string nameMatchNF: ""
    property string nameFileNF:""
    property string namePubNF:""
    property string nameSignNF:""

    property string folderPath: ""
    property string verifingResult: ""

    property var nameZip: []

    readonly property color myUpperBar: "#1a1512"
    readonly property color myBackground: "#201e1b"
    readonly property color myWhiteFont: "#e4f8ff"
    readonly property color myBackground2: "#acb1aa"
    readonly property color myHighLighht: "#F9D800"//"#3fa108"
    readonly property color myCloseImg: "#fcf8fe"
    readonly property color myCloseBtn: "#de2f05"



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
                        id: home
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        height: 30
                        width: 30
                        enabled: false
                        ToolTip {
                            text: nameToolTip
                            enabled: parent.enabled

                            visible: parent.hovered && parent.enabled
                            background: Rectangle {
                                color: myBackground2
                                border.color: myHighLighht
                                radius: 4
                               
                                Label {
                                    color: "#F9D800"
                                    font.pointSize: 12
                                    font.family: "Roboto Medium"
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.rightMargin: 2
                                    anchors.leftMargin: 2
                                    anchors.bottomMargin: 2
                                    anchors.topMargin: 2
                                }
                                
                            }
                            
                        }
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        background: Rectangle{
                            color: parent.enabled ? (parent.pressed ? Qt.tint(Qt.lighter(myUpperBar, 2.5), "#100c03FF") : (parent.hovered ? Qt.tint(Qt.lighter(myUpperBar, 3), "#100c03FF") : myUpperBar)) : myUpperBar
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

                        
                        onClicked: {
                            stack.pop(lang)
                            myData.clear()
                            home.enabled = false
                        }
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
                            stack.push(signVerify)
                            home.enabled = true
                        }
                    }

                    SignVerify {
                        id: signVerify
                        visible: false
                        onSign: {
                            stack.push(sign)
                        }
                        onVerify: {
                            stack.push(verify)
                        }
                    }

                    Sign {
                        id: sign
                        visible: false
                        onButtonFile: {
                            stack.push(proc1)
                            signFile.visible = true
                        }
                        onButtonFolder: {
                            stack.push(proc1)
                            signFolder.visible = true
                        }
                    }
                    SignFolder {
                        id: signFolderPage
                        visible: false
                        onButtonClicked: {
                            stack.push(signKey)
                        }
                    }

                    SignKey {
                        id: signKey
                        visible: false
                        onSelect: {
                            stack.push(proc2)
                            getPriv.visible = true
                        }
                        onGen: {
                            stack.push(proc2)
                            genKey.visible = true
                        }
                    }

                    SignSave {
                        id: signSave
                        visible: false
                        onInclude: {
                            myData.havePubFce()
                            if (havePub) {
                                stack.push(signSaveAs)
                            } else {
                                stack.push(proc5)
                                getPubKeyFileSign.visible = true
                            }
                        }
                        onDont: {
                            stack.push(signSaveAs)
                        }
                    }

                    SignKeyExist{
                        id: keyExist
                        visible: false
                        onYes: {
                            stack.push(proc4)
                            myData.overwrite(genKey.currentFolder)
                            stack.push(signSave)
                        }
                        onNo: {
                            stack.push(proc3)
                            genKey.visible = true;
                        }
                        onBack: stack.pop(signKey)
                    }

                    SignSaveAs{
                        id: signSaveAs
                        visible: false
                        onButtonClicked: {
                            stack.push(chose)
                        }
                    }

                    Verify {
                        id: verify
                        visible: false
                        onButtonClicked: {
                            home.enabled = false
                            stack.push(proc1)
                            getVerFile.visible = true
                        }

                    SignChose {
                        id: chose
                        visible: false
                        onButtonClicked: {
                            stack.push(signFinal)
                        }
                    }

                    SignFinal {
                        id: signFinal
                        visible: false
                    }

                    Processing {
                        id: proc1
                        visible: false
                    }

                    Processing {
                        id: proc2
                        visible: false
                    }

                    Processing {
                        id: proc3
                        visible: false
                    }

                    Processing {
                        id: proc4
                        visible: false
                    }

                    Processing {
                        id: proc5
                        visible: false
                    }

                    VerifyPubKNF {
                        id: pubKNF
                        visible: false
                        onBack: {
                            stack.pop(verify)
                        }
                        onSelect: {
                            stack.push(proc2)
                            getPubKeyFileVer.visible = true
                        }
                    }

                    VerifySignNF {
                        id: signNF
                        visible: false
                        onBack: {
                            stack.pop(verify)
                        }
                        onSelect: {
                            stack.push(proc3)
                            getSignFile.visible = true
                        }
                    }

                    Verifed{
                        id: verifed
                        visible: false
                        onBack: {
                            stack.pop(lang)
                            myData.clear()
                            home.enabled = false
                        }
                    }

                    VerifyFileNotFound {
                        id: verifyFileNotFound
                        visible: false
                        onBack: {
                            stack.pop(lang)
                            myData.clear()
                            home.enabled = false
                        }
                    }

                    VerifyMatchNotFound {
                        id: verifyMatchNotFound
                        visible: false
                        onBack: {
                            stack.pop(lang)
                            myData.clear()
                            home.enabled = false
                        }
                    }

                    VerifyPubNotFound {
                        id: verifyPubNotFound
                        visible: false
                        onBack: {
                            stack.pop(lang)
                            myData.clear()
                            home.enabled = false
                        }
                    }

                    VerifySignNotFound {
                        id: verifySignNotFound
                        visible: false
                        onBack: {
                            stack.pop(lang)
                            myData.clear()
                            home.enabled = false
                        }
                    }

                    }

                    // visual repair (window border)
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


    // select file to sign
    FileDialog {
        id: signFile 
        visible: false
        flags: FileDialog.ReadOnly
        onAccepted: {
            //var url = /String(fileDialog.currentFile)
            //var index = 0
            //var urlCh = url.split("")
            //for (let i =0; i <url.length; i++){
            //    if(urlCh[i] === "/") {index = i + 1;}
            //}
            //var filename = url.substring(index);
            //fileState.text = filename
            //fileState2.text = filename
            myData.getFile(signFile.currentFile)
            stack.push(signKey)
        }
        onRejected: {
            stack.pop(sign)
        }
    }

    // select private key
    FileDialog {
        id: getPriv 
        visible: false
        nameFilters: [namePrivKeyFilter]
        flags: FileDialog.ReadOnly
        onAccepted: {
            myData.getPrivKey(getPriv.currentFile)
            stack.push(signSave)
        }
        onRejected: {
            stack.pop(sign)
        }
    }

    // select file to verify
    FileDialog {
        id: getVerFile 
        visible: false
        title: nameSlctVerFile
        flags: FileDialog.ReadOnly
        onAccepted: {
            myData.findKeyPub(getVerFile.currentFile)
            myData.findSignature(getVerFile.currentFile)
            myData.getVerifyFile(getVerFile.currentFile)
            if (findKPub) {
                if (findSign){
                    myData.verify()
                    if (verifingResult == "ok") { // verifed
                        stack.push(verifed)
                    } else if (verifingResult == "err4") { //err4 – signature dont match
                        stack.push(verifyMatchNotFound)
                    } else if (verifingResult == "err1") { //err1 .sign not found
                        stack.push(verifyPubNotFound)
                    } else if (verifingResult == "err2") { //err2 key.pub not found
                        stack.push(verifySignNotFound)
                    } else { //err3 main file not found
                        stack.push(verifyFileNotFound)
                    }
                } else {
                    stack.push(signNF)
                }
            } else {
                stack.push(pubKNF)
            }
        }
        onRejected: {
            stack.pop(verify)
        }
    }

    // select public key for sign archive
    FileDialog {
        id: getPubKeyFileSign
        visible: false
        flags: FileDialog.ReadOnly
        title: nameSlctPubKey
        nameFilters: [namePubKey]
        onAccepted: {
            myData.loadPubKS(getPubKeyFileSign.currentFile)
            stack.push(signSaveAs)
        }
        onRejected: {
            stack.pop(signSave)
        }
    }

    // select public key for verify
    FileDialog {
        id: getPubKeyFileVer 
        visible: false
        flags: FileDialog.ReadOnly
        title: nameSlctPubKey
        nameFilters: [namePubKey]
        onAccepted: {
            myData.loadPubKV(getPubKeyFileVer.currentFile)
            myData.findSignature(getVerFile.currentFile)
            if (findSign){
                myData.verify()
                if (verifingResult == "ok") { // verifed
                    stack.push(verifed)
                } else if (verifingResult == "err4") { //err4 – signature dont match
                    stack.push(verifyMatchNotFound)
                } else if (verifingResult == "err1") { //err1 .sign not found
                    stack.push(verifyPubNotFound)
                } else if (verifingResult == "err2") { //err2 key.pub not found
                    stack.push(verifySignNotFound)
                } else { //err3 main file not found
                    stack.push(verifyFileNotFound)
                }
            } else {
                stack.push(signNF)
            }
        }
        onRejected: {
            stack.pop(verify)
        }
    }

    // select .sign for verify
    FileDialog {
        id: getSignFile 
        visible: false
        flags: FileDialog.ReadOnly
        title: nameSlctSign
        nameFilters: [nameSignFile]
        onAccepted: {
            myData.getSignature(getSignFile.currentFile)
            myData.verify()
            console.log(verifingResult);
            if (verifingResult == "ok") { // verifed
                stack.push(verifed)
            } else if (verifingResult == "err4") { //err4 – signature dont match
                stack.push(verifyMatchNotFound)
            } else if (verifingResult == "err1") { //err1 .sign not found
                stack.push(verifyPubNotFound)
            } else if (verifingResult == "err2") { //err2 key.pub not found
                stack.push(verifySignNotFound)
            } else { //err3 main file not found
                stack.push(verifyFileNotFound)
            }
        }
        onRejected: {
            stack.pop(verify)
        }
    }

    // select folder for sign
    FolderDialog {
        id: signFolder 
        visible: false
        options: FolderDialog.ReadOnly
        onAccepted: {
            folderPath = signFolder.currentFolder
            stack.push(signFolderPage)
        }
        onRejected: {
            stack.pop(sign)
        }
    }

    // select forder for generate keys
    FolderDialog {
        id: genKey 
        visible: false
        onAccepted: {
            myData.keyGen(genKey.currentFolder)
            if (keysExist) {
                stack.push(keyExist)
                stack.pop(keyExist)
            } else {
                stack.push(signSave)
            }
        }
        onRejected: {
            stack.pop(signKey)
        }
    }

    // data
    Connections {
        target: myData
        function onFindKPub(x) {
            findKPub = x
        }
        function onFindSign(x) {
            findSign = x
        }
        function onHavePub(x) {
            havePub = x
        }
        function onKeysExist(x) {
            keysExist = x
        }
        function onVerifingResult(x) {
            verifingResult = x
        }
    }

    // language
    Connections {
        target: myLang
        function onNameToolTip(x) {
            nameToolTip = x
        }
        function onNameAction(x) {
            nameAction = x
        }
        function onNameSign(x) {
            nameSign = x
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
        function onNamePrivKeyFilter(x) {
            namePrivKeyFilter = x
        }
        function onNameZip(x) {
            nameZip = x
        }
        function onNameSignFinal(x) {
            nameSignFinal= x
        }
        function onNameSlctVerFile(x){
            nameSlctVerFile = x
        }
        function onNameSlctPubKey(x){
            nameSlctPubKey = x
        }
        function onNameSlctSign(x){
            nameSlctSign = x
        }
        function onNamePubKey(x){
            namePubKey = x
        }
        function onNameSignFile(x){
            nameSignFile = x 
        }
        function onNameBack(x) {
            nameBack = x
        }
        function onNameVerifed(x) {
            nameVerifed = x           
        }
        function onNameSelect(x) {
            nameSelect = x
        }
        function onNameKeyExist(x) {
            nameKeyExist = x
        }
        function onNameOverwrite(x) {
            nameOverwrite = x
        }        
        function onNameSlcOF(x) {
            nameSlcOF = x
        }
        function onNameMatchNF(x) {
            nameMatchNF = x
        }
        function onNameFileNF(x) {
            nameFileNF = x
        }
        function onNamePubNF(x) {
            namePubNF = x
        }
        function onNameSignNF(x) {
            nameSignNF = x
        }
    }

}



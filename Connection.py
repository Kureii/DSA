import base64
from os import path, rename, remove
import Fce
from Lang import appLang
from PySide6.QtCore import QObject, Slot, Signal
from urllib.parse import unquote



class GetData(QObject):
    def __init__(self):
        QObject.__init__(self)

    privKey = []
    pubKey = []
    includePub = False
    wasFolder = False
    signed = False
    pubKeyPath = ""
    file = ""
    signature = ""


    findKPub = Signal(bool)
    findSign = Signal(bool)
    havePub = Signal(bool)
    keysExist = Signal(bool)
    verifingResult = Signal(str)

    @Slot(str)
    def getFile(self, file):
        self.file = Fce.ToSysPath(file)
        self.wasFolder = False

    @Slot(str, str)
    def getFolder(self, mypath, suffix):
        mypath = Fce.ToSysPath(mypath)
        # special chars
        mypath = unquote(mypath) 
        # create archive in program folder
        Fce.makeArchive(path.basename(mypath) + suffix, mypath) 
        # move archive to final folder
        rename(path.basename(mypath) + suffix, mypath + suffix) 
        self.file = mypath + suffix
        self.wasFolder = True

    @Slot(str)
    def getPrivKey(self, key):
        key = Fce.ToSysPath(key)
        k = open(key, "rb")
        privK = k.read()
        k.close()
        privK = privK.split(b'+/')
        self.privKey = []
        for i in privK:
            tmp = base64.b64decode(i)
            self.privKey.append(int(tmp))


    @Slot(str)
    def keyGen(self, folder):
        Folder =Fce.ToSysPath(folder)
        print(path.isfile(Folder + "/key.priv") or path.isfile(Folder + "/key.pub"))
        if path.isfile(Folder + "/key.priv") or path.isfile(Folder + "/key.pub"):
            self.keysExist.emit(True)
        else:
            Fce.makePrivPub(Folder)
            with open(Folder + "/key.priv", "rb") as keys:
                privK = keys.read()
            privK = privK.split(b"+/")
            self.privKey = [int(base64.b64decode(privK[0])), int(base64.b64decode(privK[1]))]
            self.pubKeyPath = Folder + "/key.pub"
            for i in privK:
                tmp = base64.b64decode(i)
                self.privKey.append(int(tmp))

    @Slot(bool)
    def incKey(self, YN):
        self.includePub = YN

    @Slot(str)
    def sign(self, suffix):
        mypath = self.file[:len(self.file) - len(path.basename(self.file))]
        self.signed = Fce.makeSign(mypath, self.file, self.privKey, self.pubKeyPath,
                                   self.includePub, suffix, wasFolder=self.wasFolder)

    @Slot(str)
    def findKeyPub(self, file):
        file = Fce.ToSysPath(file)
        #is zipped
        if Fce.IsKPubInArchive(file):
            self.findKPub.emit(True)
        else:
            tmppath = file[:len(file) - len(path.basename(file))]  + "key.pub"
            self.findKPub.emit(path.isfile(tmppath))

    @Slot(str)
    def findSignature(self, file):
        file = Fce.ToSysPath(file)
        self.findSign.emit(Fce.IsSignInArchive(file))

    @Slot(str)
    def loadPubKV(self, file):
        key = Fce.ToSysPath(file)
        key = open(key)
        pubK = key.read()
        key.close()
        self.pubKey = []
        for i in pubK:
            tmp = base64.b64decode(i)
            self.pubKey.append(int(tmp))

    @Slot(str)
    def loadPubKS(self, file):
        self.pubKeyPath = Fce.ToSysPath(file)
    
    @Slot()
    def havePubFce(self):
        print("havepub?")
        self.havePub.emit(not self.pubKeyPath == "")

    @Slot(str)
    def overwrite(self, file):
        Folder = Fce.ToSysPath(file)
        Fce.makePrivPub(Folder)
        with open(Folder + "/key.priv", "rb") as keys:
            privK = keys.read()
        privK = privK.split(b"+/")
        self.privKey = [int(base64.b64decode(privK[0])), int(base64.b64decode(privK[1]))]
        self.pubKeyPath = Folder + "/key.pub"
        for i in privK:
            tmp = base64.b64decode(i)
            self.privKey.append(int(tmp))

    @Slot()
    def clear(self):
        self.havePub.emit(False)
        self.findKPub.emit(False)
        self.findSign.emit(False)
        self.privKey = []
        self.pubKey = []
        self.includePub = False
        if self.wasFolder and not self.signed:
            remove(self.file)
        self.wasFolder = False
        self.signed = False
        self.pubKeyPath = ""
        self.file = ""
        self.signature = ""

    @Slot(str)
    def getSignature(self, file):
        file = Fce.ToSysPath(file)
        with open(file) as f:
            self.signature = f.read()

    @Slot(str)
    def getVerifyFile(self, file):
        self.file = Fce.ToSysPath(file)


    @Slot()
    def verify(self):
        print(f"self.file: {self.file}")
        self.verifingResult.emit(Fce.Verify(self.file, self.pubKey, self.signature))

    

#<|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|>

class Language(QObject):
    def __init__(self):
        QObject.__init__(self)

    nameToolTip = Signal(str)
    nameAction = Signal(str)
    nameSign = Signal(str)
    nameVeri = Signal(str)
    nameChose = Signal(str)
    nameFile = Signal(str)
    nameFolder = Signal(str)
    nameKey = Signal(str)
    nameGen = Signal(str)
    nameIncK = Signal(str)
    nameY = Signal(str)
    nameN = Signal(str)
    nameSaveArch = Signal(str)
    nameLoadArch = Signal(str)
    nameWait = Signal(str)
    namePrivKeyFilter = Signal(str)
    nameZip = Signal(list)
    nameSignFinal = Signal(str)
    nameSlctVerFile = Signal(str)
    nameSlctPubKey = Signal(str)
    nameSlctSign = Signal(str)
    namePubKey = Signal(str)
    nameSignFile = Signal(str)
    nameBack = Signal(str)
    nameSelect = Signal(str)
    nameVerifed =Signal(str)
    nameKeyExist = Signal(str)
    nameOverwrite = Signal(str)
    nameSlcOF = Signal(str)
    nameMatchNF = Signal(str)
    nameFileNF = Signal(str)
    namePubNF = Signal(str)
    nameSignNF = Signal(str)

    @Slot(str)
    def getLang(self, lng):
        myLang = appLang[lng]
        self.nameToolTip.emit(myLang['nameToolTip'])
        self.nameAction.emit(myLang['nameAction'])
        self.nameSign.emit(myLang['nameSign'])
        self.nameVeri.emit(myLang['nameVeri'])
        self.nameChose.emit(myLang['nameChose'])
        self.nameFile.emit(myLang['nameFile'])
        self.nameFolder.emit(myLang['nameFolder'])
        self.nameKey.emit(myLang['nameKey'])
        self.nameGen.emit(myLang['nameGen'])
        self.nameIncK.emit(myLang['nameIncK'])
        self.nameY.emit(myLang['nameY'])
        self.nameN.emit(myLang['nameN'])
        self.nameSaveArch.emit(myLang['nameSaveArch'])
        self.nameLoadArch.emit(myLang['nameLoadArch'])
        self.nameWait.emit(myLang['nameWait'])
        self.namePrivKeyFilter.emit(myLang['namePrivKeyFilter'])
        self.nameZip.emit(myLang['nameZip'])
        self.nameSignFinal.emit(myLang['nameSignFinal'])
        self.nameSlctVerFile.emit(myLang['nameSlctVerFile'])
        self.nameSlctPubKey.emit(myLang['nameSlctPubKey'])
        self.nameSlctSign.emit(myLang['nameSlctSign'])
        self.namePubKey.emit(myLang['namePubKey'])
        self.nameSignFile.emit(myLang['nameSignFile'])
        self.nameBack.emit(myLang['nameBack'])
        self.nameSelect.emit(myLang['nameSelect'])
        self.nameVerifed.emit(myLang['nameVerifed'])
        self.nameKeyExist.emit(myLang['nameKeyExist'])
        self.nameOverwrite.emit(myLang['nameOverwrite'])
        self.nameSlcOF.emit(myLang['nameSlcOF'])
        self.nameMatchNF.emit(myLang['nameMatchNF'])
        self.nameFileNF.emit(myLang['nameFileNF'])
        self.namePubNF.emit(myLang['namePubNF'])
        self.nameSignNF.emit(myLang['nameSignNF'])
import base64
from os import name, path, rename
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
    pubKeyPath = ""
    file = ""

    findKPub = Signal(bool)

    @Slot(str)
    def getFile(self, file):
        # windows
        if name == "nt":
            self.file = file[8:]
        # unix
        else:
            self.file = file[7:]
        self.wasFolder = False

    @Slot(str, str)
    def getFolder(self, mypath, type):
        # windows
        if name == "nt":
            mypath = mypath[8:]
        # unix
        else:
            mypath = mypath[7:]
        myformat = ""
        # tar
        if type == ".tar.gz":
            myformat = "w:gz"
        elif type == ".tar.bz2":
            myformat = "w:bz2"
        elif type == ".tar.lzma":
            myformat = "w:xz"
        
        # special chars
        mypath = unquote(mypath) 
        # create archive in program folder
        Fce.makeArchive(path.basename(mypath) + type, mypath, myformat) 
        # move archive to final folder
        rename(path.basename(mypath) + type, mypath + type) 
        self.file = mypath + type
        self.wasFolder = True

    @Slot(str)
    def keyGen(self, folder):
        if name == "nt":
            Folder = folder[8:]
        else:
            Folder = folder[7:]
        Fce.makePrivPub(Folder)
        keys = open(Folder + "/key.priv", "rb")
        keys = keys.read()
        keys = keys.split(b"+/")
        self.privKey = []
        self.pubKeyPath = Folder + "/key.pub"
        for i in keys:
            tmp = base64.b64decode(i)
            self.privKey.append(int(tmp))

    @Slot(bool)
    def incKey(self, YN):
        self.includePub = YN

    @Slot(str)
    def sign(self, suffix):
        mypath = self.file[:len(self.file) - len(path.basename(self.file))]
        Fce.makeSign(mypath, self.file, self.privKey, self.pubKeyPath, self.includePub, suffix, wasFolder=self.wasFolder)

    @Slot(str)
    def findKeyPub(self, file):
        # windows
        if name == "nt":
            file = file[8:]
        # unix
        else:
            file = file[7:]
        #is zipped
        if Fce.IsKPubInArchive(file):
            self.findKPub.emit(True)
        else:
            print(len(path.basename(file)))
            tmppath = file[:len(file) - len(path.basename(file))]  + "key.pub"
            print(tmppath)
            self.findKPub.emit(path.isfile(tmppath))

    @Slot(str)
    def findSignature(self, file):
        # windows
        if name == "nt":
            file = file[8:]
        # unix
        else:
            file = file[7:]
        self.Fce.IsSignInArchive(file)

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
        

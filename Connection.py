import os
import Fce
from Lang import appLang
from PySide6.QtCore import QObject, Slot, Signal


class GetData(QObject):
    def __init__(self):
        QObject.__init__(self)

    

class Language(QObject):
    def __init__(self):
        QObject.__init__(self)

    nameAction = Signal(str)
    nameSing = Signal(str)
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

    @Slot(str)
    def getLang(self, lng):
        myLang = appLang[lng]
        self.nameAction.emit(myLang['nameAction'])
        self.nameSing.emit(myLang['nameSing'])
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


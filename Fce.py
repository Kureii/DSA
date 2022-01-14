from os import name, path, walk, remove, listdir, rmdir
import math
import secrets
import random
import string
import base64
import tarfile
import zipfile
import re
from hashlib import sha3_512


class RSA():
    digs = string.digits + string.ascii_letters.upper()

    def __init__(self, text, n, d=0, e=0):
        self.text = text
        self.blockText = []
        self.n = n
        self.output = ""
        if e:
            self.e = e
            self.enc()
        else:
            self.d = d
            self.dec()

    def blocking(self, block):
        text = self.text
        lenText = len(text)
        if block < lenText:
            if lenText % block:
                pls = 1
            else:
                pls = 0
            for i in range(lenText // block + pls):
                tmp = text[i * block]
                for j in range(block - 1):
                    if i * block + j + 1 < lenText:
                        tmp += text[i * block + j + 1]
                self.blockText.append(tmp)
        else:
            self.blockText = [text]

    def enc(self):
        myenc = ""
        self.blocking(4)
        for i in self.blockText:
            tmp = ""
            for j in i:
                tmp += "0" * (14 - len(bin(ord(j)))) + bin(ord(j))[2:50]
            intTmp = int(tmp, 2)
            myenc += str(pow(intTmp, self.e, self.n)) + " "
        self.output = myenc

    def dec(self):
        mydec = ""
        ' '.join(self.text.split())
        if self.text[-1] == " ":
            self.text = self.text[0:-1]
        self.blockText = self.text.split()
        for i in self.blockText:
           
            i = int(i)
            tmp = bin(pow(int(i), int(self.d), self.n))[
                2:len(bin(pow(int(i), int(self.d), self.n)))]
            tmp = "0" * (48 - len(tmp)) + tmp
            tmpList = []
            for j in range(4):
                tmp2 = ""
                for k in range(12):
                    tmp2 += tmp[j * 12 + k]
                tmpList.append(tmp2)
            for j in tmpList:
                mydec += chr(int(j, 2))
        self.output = mydec

    def int2base(self, x, base):
        if x < 0:
            sign = -1
        elif x == 0:
            return self.digs[0]
        else:
            sign = 1

        x *= sign
        digits = []

        while x:
            digits.append(self.digs[x % base])
            x = x // base

        if sign < 0:
            digits.append('-')

        digits.reverse()

        return ''.join(digits)

class genRSAKey():
    def __init__(self):
        P = self.makePrime()
        Q = self.makePrime()
        self.N = P * Q
        FiN = (P - 1) * (Q - 1)
        self.D = self.findD(FiN)
        self.E = self.findE(self.D, FiN)

    def makePrime(self):
        returnTmp = []
        for x in range(10):
            a = random.randrange(0, 10)
            textTmp = ""
            listTmp = list(secrets.token_hex(10))
            random.shuffle(listTmp)
            for i in range(len(listTmp)):
                textTmp += listTmp[i]
            listTmp = textTmp
            textTmp = ""
            listTmp = list(str(int(listTmp, 16))[a: a + 13])
            random.shuffle(listTmp)
            for i in range(len(listTmp)):
                textTmp += listTmp[i]
            textTmp = str(int(textTmp))
            if len(textTmp) != 13:
                for i in range(13 - len(textTmp)):
                    textTmp += str(random.randrange(0, 9))
            returnTmp.append(int(textTmp))
        myReturn = self.isPrime(returnTmp)
        return myReturn

    def isPrime(self, tmpList):
        count = 0
        while True:
            num = tmpList[count]
            if all(num % i != 0 for i in range(2, int(math.sqrt(num))+1)):
                break
            count += 1
            if count == len(tmpList) - 1:
                num = self.makePrime()
                break
        return num

    def findD(self, FiN):
        while True:
            tmp = []
            for i in range(50):
                d = random.randrange(3, FiN - 1, 2)
                if math.gcd(d, FiN) == 1:
                    tmp.append(d)

            tmp2 = tmp[0]
            if len(tmp):
                for i in tmp:
                    if i < tmp2:
                        tmp2 = i
                d = tmp2
                break
        return d

    def findE(self, D, FiN):
        return pow(D, -1, FiN)

def makeHashes(file):
    o = open(file, "rb")
    hash = sha3_512(o.read())
    o.close()
    return hash.hexdigest()

def makePrivPub(file):    
    key = genRSAKey()
    nkey = base64.b64encode(bytes(f'{key.N}', "ascii"))
    dkey = base64.b64encode(bytes(f'{key.D}', "ascii"))
    ekey = base64.b64encode(bytes(f'{key.E}', "ascii"))
    pubkey = nkey
    pubkey += b'+/'
    pubkey += dkey
    privkey = nkey
    privkey += b'+/'
    privkey += ekey
    with open(f"{file}/key.pub", "wb") as pub:
        pub.write(pubkey)
    with open(f"{file}/key.priv", "wb") as priv:
        priv.write(privkey)

def makeArchive(output_file, source_file):
    print(output_file)
    if ".tar.gz" in output_file:
        myFormat = "w:gz"
    elif".tar.bz2"  in output_file:
        myFormat = "w:bz2"
    elif ".tar.lzma"  in output_file:
        myFormat = "w:xz"
    else:
        myFormat=""
    source_folder =list_files(source_file)
    if myFormat != "":
        with tarfile.open(output_file, myFormat) as tar:
            for i in source_folder:
                tar.add(i, "." +i[len(source_file)::])
        tar.close()
    else: 
        with zipfile.ZipFile(output_file, 'w') as zip:
            for i in source_folder:
                zip.write(i, "."+i[len(source_file)::])
            zip.close()

def list_files(walk_dir):
    lst = []
    for root, subdirs, files in walk(walk_dir):
        for filename in files:
            filePath = path.join(root, filename)
            filePath.replace("\\", "/")
            lst.append(str(filePath))
    return lst

def makeSign(file, filePath, privKey, pubPath="", includePub=False ,suffix="", wasFolder=False):
    # file = new archive path
    # filePath = signing file
    # privKey = private key
    # pubPath = path to pubKey
    # includePub = include file key.pub
    # wasFolder = was file folder?
    
    if suffix == ".tar.gz":
        myFormat = "w:gz"
    elif suffix == ".tar.bz2":
        myFormat = "w:bz2"
    elif suffix == ".tar.lzma":
        myFormat = "w:xz"

    # get hash
    sign = makeHashes(filePath)

    # encode hash
    signString = RSA(sign, privKey[0], e=privKey[1]).output

    # create file "filename".sign
    tmp = path.basename(filePath)
    tmp2 = tmp.rfind(".")
    if ".tar" in tmp:    
        tmp = file + tmp[:tmp2 - 4] + ".sign"
    else:
        tmp = file + tmp[:tmp2] + ".sign"
    file = tmp
    signFile = open(f"{tmp}", "w")
    signFile.write(str(signString))
    signFile.close()
    
    # make archive
    if suffix == ".zip":
        with zipfile.ZipFile(file + suffix, 'w') as zip:
            zip.write(filePath, path.basename(filePath))
            zip.write(tmp, path.basename(tmp))
            if includePub:
                zip.write(pubPath, path.basename(pubPath))
            zip.close()
    elif suffix == ".7z":
        with zipfile.ZipFile(file + suffix, 'w') as zip:
            zip.write(filePath, path.basename(filePath))
            zip.write(tmp, path.basename(tmp))
            if includePub:
                zip.write(pubPath, path.basename(pubPath))
            zip.close()
    elif suffix == ".rar":
        with zipfile.ZipFile(file + suffix, 'w') as zip:
            print(f'pubPath: {pubPath}\n basename: {path.basename(pubPath)}')

            zip.write(filePath, path.basename(filePath))
            zip.write(tmp, path.basename(tmp))
            if includePub:
                zip.write(pubPath, path.basename(pubPath))
            zip.close()
    elif suffix == ".tar.gz":
        with tarfile.open(file + suffix, myFormat) as tar:
            tar.add(filePath, path.basename(filePath))
            tar.add(tmp, path.basename(tmp))
            if includePub:
                tar.add(pubPath, path.basename(pubPath))
            tar.close()
    elif suffix == ".tar.bz2":
        with tarfile.open(file + suffix, myFormat) as tar:
            tar.add(filePath, path.basename(filePath))
            tar.add(tmp, path.basename(tmp))
            if includePub:
                tar.add(pubPath, path.basename(pubPath))
            tar.close()
    elif suffix == ".tar.lzma":
        with tarfile.open(file + suffix, myFormat) as tar:
            tar.add(filePath + suffix, path.basename(filePath))
            tar.add(tmp, path.basename(tmp))
            if includePub:
                tar.add(pubPath, path.basename(pubPath))
            tar.close()
    remove(tmp)
    if wasFolder:
        remove(filePath)
    return True


def IsZip(file):
    if (".sign.zip" in file or 
        ".sign.7z" in file or 
        ".sign.rar" in file):
        return True
    else:
        return False

def IsTar(file):
    if (".sign.tar.gz" in file or 
        ".sign.tar.bz2" in file or 
        ".sign.tar.lzma" in file):
        return True
    else:
        return False

def IsKPubInArchive(file):
    if IsZip(file):
        with zipfile.ZipFile(file) as myzip:
            return 'key.pub' in myzip.namelist()
    elif IsTar(file):
        with tarfile.open(file) as tar:
            return 'key.pub' in tar.getnames()
    else:
        return False
    
def IsSignInArchive(file):
    if IsZip(file):
        with zipfile.ZipFile(file) as myzip:
            for i in myzip.namelist():
                if '.sign' in i:
                    return True
            return False
    elif IsTar(file):
        with tarfile.open(file) as tar:
            for i in tar.getnames():
                if '.sign' in i:
                    return True
            return False
    else:
        return False

def ToSysPath(file):
    # windows
    if name == "nt":
        return file[8:]
    # unix
    else:
        return file[7:]

def Verify(file, pub, sign):
    # output: "err1" = .sign not found
    # output: "err2" = key.pub not found
    # output: "err3" = main file not found
    # output: "err4" = signature don't match
    # output: "ok" = signaturee was verifed
    wasArchive = False
    tmp = file.rfind("/") +1
    tmp2 = file.rfind(".sign")
    newDir = file[:tmp] + "TMP" + file[tmp:tmp2]
    if IsZip(file):
        wasArchive = True
        with zipfile.ZipFile(file, 'r') as zippy:
            zippy.extractall(newDir)
    elif IsTar(file):
        wasArchive = True
        with tarfile.open(file, "r") as tar:
            tar.extractall(newDir)
    if wasArchive and sign == "":
        for i in listdir(newDir):
            if ".sign" in i:
                signPath = newDir + "/" + i
                with open(signPath, "r") as tmp:
                    sign = tmp.read()
                    break
        if sign == "":
            for i in listdir(newDir):
                remove(newDir + "/" + i)
            rmdir(newDir)
            return "err1"
    if wasArchive and pub == []:
        pubPath = newDir + "/key.pub" 
        if path.isfile(pubPath):
            with open(pubPath, "rb") as tmp:
                tmp2 = tmp.read()
                tmp2 = tmp2.split(b"+/")
                pub = [int(base64.b64decode(tmp2[0])), int(base64.b64decode(tmp2[1]))]
        else:
            for i in listdir(newDir):
                remove(newDir + "/" + i)
            rmdir(newDir)
            return "err2"
    if wasArchive:
        tmp = file.rfind("/") +1
        tmp2 = file.rfind(".sign")
        fileName = file[tmp:tmp2]
        tmp = False
        for i in listdir(newDir):
            if fileName in i and ".sign" not in i:
                file = newDir + "/" + i
                tmp = True
                break
        if not tmp:
            for i in listdir(newDir):
                remove(newDir + "/" + i)
            rmdir(newDir)
            return "err3"
    hashNow = makeHashes(file)
    signHash = RSA(sign, pub[0], d=pub[1]).output
    if signHash == hashNow:
        return "ok"
    else:
        return "err4"
    
    

#!/usr/bin/env python
from subprocess import run
from configparser import ConfigParser
from pathlib import Path
from os import listdir, link

def getLatestTag() -> str:
    gitTag = None
    cmd = "git describe --tags".split(" ")
    gitTag = run(cmd, capture_output=True).stdout.decode("utf-8")
    return gitTag.strip()

def getLastestHash() -> str:
    gitHash = None
    cmd = "git rev-parse --short HEAD".split(" ")
    gitHash = run(cmd, capture_output=True).stdout.decode("utf-8")
    return gitHash.strip()

def writeExport(confFile):
    config = ConfigParser()
    config.read(confFile)
    config['preset.0']['export_path'] = f'"../bin/HCSpaceOrigins-linux-{getLatestTag()}-{getLastestHash()}.x86_64"'
    config['preset.1']['export_path'] = f'"../bin/HCSpaceOrigins-win64-{getLatestTag()}-{getLastestHash()}.exe"'
    config['preset.1.options']['application/product_version'] = f'"{getLatestTag()}_{getLastestHash()}"'

    with open(confFile, 'w') as iniFile:
        config.write(iniFile)

def writeProjectVersion(file):
    with open(file, 'r') as proFile:
        proFileLines = proFile.readlines()
    
    newFileContents = ""
    for line in proFileLines:
        if line.strip()[:15] == "config/version=":
            line = f'config/version="{getLatestTag()}"'
        
        newFileContents += line
    
    with open(file, 'w') as newproFile:
        newproFile.write(newFileContents)

def generateBinaries():
    exports = ["linux", "win64"]
    for name in exports:
        cmd = f'godot --path src --export {name}'.split()
        run(cmd)

def cleanOldFiles():
    files = listdir("bin/")
    for file in files:
        file = Path("bin").joinpath(file)
        Path.unlink(file)

def makeCompressed():
    files = listdir("bin/")
    for file in files:
        expFilename = file.split('-')
        newFileExt = file.split('.')[-1]
        newFileStem = f'{expFilename[0]}-{expFilename[1]}-latest'
        newFilename = f'{newFileStem}.{newFileExt}'
        oldfile = Path("bin").joinpath(file)
        if newFileExt == "exe":
            run(f'zip bin/{newFileStem}.zip {oldfile}'.split(" "))
        else:
            run(f'tar cjf bin/{newFileStem}.tar.bz2 {oldfile}'.split(" "))
        
        #newFile = Path("bin").joinpath(newFilename)

        #link(oldfile,newFile)

#Check if export file exists
exportFile = Path("src/export_presets.cfg")
projectFile = Path("src/project.godot")

if not exportFile.exists() or not projectFile.exists():
    print("ERROR: Export config file not found!")
    exit(1)

if __name__ == "__main__":
    writeExport(exportFile)
    writeProjectVersion(projectFile)
    cleanOldFiles()
    generateBinaries()
    makeCompressed()

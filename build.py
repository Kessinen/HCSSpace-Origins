#!/usr/bin/env python
from subprocess import run
from configparser import ConfigParser
from pathlib import Path

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

#Check if export file exists
configFile = Path("src/export_presets.cfg")
if not configFile.exists():
    print("ERROR: Export config file not found!")
    exit(1)

config = ConfigParser()
config.read("src/export_presets.cfg")
config['preset.0']['export_path'] = f'"../bin/HCSpaceOrigins-linux-{getLatestTag()}-{getLastestHash()}.x86_64"'
config['preset.1']['export_path'] = f'"../bin/HCSpaceOrigins-win64-{getLatestTag()}-{getLastestHash()}.exe"'
config['preset.1.options']['application/product_version'] = f'"{getLatestTag()}_{getLastestHash()}"'

with open(configFile, 'w') as iniFile:
    config.write(iniFile)

exports = ["linux", "win64"]

for name in exports:
    cmd = f'godot --path src --export {name}'.split()
    run(cmd)

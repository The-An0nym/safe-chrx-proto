#!scripts/.venv/bin/python3

import pathlib
import sys
import os

PYTHON=sys.executable
if PYTHON in ["", None]:
    PYTHON = "python3"

WRK=pathlib.Path(__file__).parent.parent.parent.resolve()
SRC=WRK.joinpath("chromium/src")

DEPOT_TOOLS=WRK.joinpath("depot_tools")
VENVBIN=WRK.joinpath("scripts/.venv/bin")
sys.path.insert(0, DEPOT_TOOLS)
os.environ["PATH"] = str(DEPOT_TOOLS) + os.pathsep + str(VENVBIN) + os.pathsep + os.environ["PATH"]

OUT=SRC.joinpath("out")
RELEASE=OUT.joinpath("Release")

BUILD=WRK.joinpath("build")
PATCH=WRK.joinpath("patch")

IS_LINUX = sys.platform in ["linux" , "linux2"]

with open(WRK.joinpath("chromium.version"), "rb") as f:
    VERSION=f.read().decode("utf-8")

del sys, pathlib, os
#!scripts/.venv/bin/python3

import sys

from build import gn
from utils import OUT, SRC, ccache_, GOOGLEPYTHON, GOOGLEENV
from utils.wrap import pyexc

def test(target:str):
    outdir=OUT.joinpath("Debug")
    OUTR=str(outdir.relative_to(SRC))

    gn(outdir=OUTR, debug=True)
    ccache_.show()
    ccache_.z()
    pyexc(str(SRC.joinpath("tools/autotest.py")), "-C" ,OUTR, target, cwd=SRC, python=GOOGLEPYTHON, env=GOOGLEENV)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: scripts/autotest.py os_crypt_unittest.cc", file=sys.stderr)
        sys.exit(1)
    
    target = sys.argv[1]
    
    test(target=target)

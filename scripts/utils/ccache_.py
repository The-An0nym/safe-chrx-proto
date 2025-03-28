#!scripts/.venv/bin/python3

from .wrap import exc

def set_max_g(size:int=30):
    exc("ccache", f"--max-size={size}G")

def show():
    exc("ccache", "-s")

def z():
    exc("ccache", "-z")

def clear():
    res = input("Are you sure you want to clear all Ccache ?\n:")
    if res in ["y", "yes"]:
        exc("ccache", "-C")
    else:
        raise ValueError("Clearing ccache aborted based on user-input")
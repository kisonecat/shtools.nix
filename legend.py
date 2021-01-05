#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p "python3.withPackages(ps: [ps.numpy ps.numba (callPackage ./shtools.nix {})])"

import numpy as np
import pyshtools as pyshtools
import math

# here cnorm is for the complex version, and 4pi denotes the fully normalized one
def plm(l, m, theta):
  return pyshtools.legendre.legendre_lm (l, m, math.cos(theta), normalization='4pi', csphase=1, cnorm=1)

angles = [70.7803310155746,
          70.7995625617803,
          70.8236040097436,
          70.6147177544817,
          70.5671433751329]

for theta in angles:
    for l in range(10):
        for m in range(l+1):
            print('P_{}^{}(cos {}) = {}'.format(l,m,theta,plm(l,m,theta)))

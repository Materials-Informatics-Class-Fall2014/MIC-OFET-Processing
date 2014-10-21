# -*- coding: utf-8 -*-
"""
Created on Tue Oct 21 18:22:20 2014

@author: Imperssonator
"""

import IPython.nbformat.current as nbf
nb = nbf.read(open('SwiftCon.py', 'r'), 'py')
nbf.write(nb, open('SwiftCon.ipynb', 'w'), 'ipynb')
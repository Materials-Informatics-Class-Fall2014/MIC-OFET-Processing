# -*- coding: utf-8 -*-
"""
Created on Tue Oct 21 11:55:53 2014

@author: Imperssonator
"""

import numpy

import scipy

from scipy import ndimage,misc

import matplotlib.pyplot as plt

path = "/Users/Imperssonator/Documents/GA Tech/Classes/Informatics/MIC-OFET-Processing/_data/15%_2min_2.tif"

D15 = misc.imread(path)

plt.imshow(D15)

[hist, bin_edges] = numpy.histogram(D15, bins=50)

plt.hist(hist)
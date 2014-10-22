# -*- coding: utf-8 -*-
"""
Created on Tue Oct 21 13:50:28 2014

@author: Imperssonator
"""

from swiftclient import Connection

authURL = 'https://swift.storm.gatech.edu/auth/v1.0'
mainURL = 'https://npersson3@swift.storm.gatech.edu'
user = 'npersson3'
PW = 'SmallBowel=20ft'
container='img'

swift = Connection(authurl=authURL,user=user,key=PW,insecure=True)

(headers,containers)=swift.get_account()

print(headers)
print(containers)

cont1=swift.get_container(container)
#print(cont1)

files = cont1[1]

for ii in files:
    filename=ii['name']
    print(filename)
    # now you can iterate any number of operations over your cloud-stored images
    # get the image, do analysis, then save the results of the analysis back on swiftstack
    
#!/usr/bin/env python

import sys
reload(sys)
sys.setdefaultencoding("utf-8")

import os
import plistlib
from BeautifulSoup import BeautifulSoup

# Path to HTML file and resulting plist file

pathHTML = "../html/"
pathPlist = "../audioLocationsCache.plist"

#### NO NEED TO EDIT BELOW THIS LINE ####

# Define main dictionary "root of plist"

mainDict = dict()

# List Directory Containing HTML files

html_files = os.listdir(pathHTML)

# Loop through files listed

for f in html_files:
	
	# If the file is not .DS_Store (must only be the HTML files in the defined directory).
	
	if f != ".DS_Store":
		print "Processing File: "+f
		
		# Open the file for reading
		
		fileHandle = open(pathHTML+f,'r')
		htmlbody = ''.join(fileHandle.read().splitlines())
		fileHandle.close
		
		# Start the html parser, BeautifulSoup
		
		soup = BeautifulSoup(htmlbody)
		
		### Some string parsing to get the meta data in the format we want it. ###
		
		# Topic #
		
		topicLine = soup.findAll('meta', key_name="topic")[0]
		topicStartSplit = topicLine.encode('utf-8').split('<meta key_name="topic" content="')[1]
		topic = topicStartSplit.split('" />')[0]
		
		# Title #
		
		titleLine = soup.findAll('meta', key_name="title")[0]
		titleStartSplit = titleLine.encode('utf-8').split('<meta key_name="title" content="')[1]
		title = titleStartSplit.split('" />')[0]
		
		# Subtitle #
		
		subtitleLine = soup.findAll('meta', key_name="subtitle")[0]
		subtitleStartSplit = subtitleLine.encode('utf-8').split('<meta key_name="subtitle" content="')[1]
		subtitle = subtitleStartSplit.split('" />')[0]
		
		# Longitude #
		
		longitudeLine = soup.findAll('meta', key_name="longitude")[0]
		longitudeStartSplit = longitudeLine.encode('utf-8').split('<meta key_name="longitude" content="')[1]
		longitude = longitudeStartSplit.split('" />')[0]
		
		# Latitude #
		
		latitudeLine = soup.findAll('meta', key_name="latitude")[0]
		latitudeStartSplit = latitudeLine.encode('utf-8').split('<meta key_name="latitude" content="')[1]
		latitude = latitudeStartSplit.split('" />')[0]
		
		# UUID #
		
		uuidLine = soup.findAll('meta', key_name="uuid")[0]
		uuidStartSplit = uuidLine.encode('utf-8').split('<meta key_name="uuid" content="')[1]
		uuid = uuidStartSplit.split('" />')[0]
		
		# Audio file location #
		audioFileRemoteLocationLine = soup.findAll('meta', key_name="audioFileRemoteLocation")[0]
		audioFileRemoteLocationStartSplit = audioFileRemoteLocationLine.encode('utf-8').split('<meta key_name="audioFileRemoteLocation" content="')[1]
		audioFileRemoteLocation = audioFileRemoteLocationStartSplit.split('" />')[0]
		
		# cover image #
		coverImageLocationLine = soup.findAll('meta', key_name="coverImage")[0]
		coverImageLocationStartSplit = coverImageLocationLine.encode('utf-8').split('<meta key_name="coverImage" content="')[1]
		coverImageLocation = coverImageLocationStartSplit.split('" />')[0]
	   	
		#print coverImageLocation
		#coverImage = urllib.urlopen(asciify_url(unicode(coverImageLocation)))
		#print coverImage.read()
		#encodedCoverImage = tempfile.TemporaryFile()
		#encodedCoverImage = base64.b64encode(coverImage.read())
        
                #print encodedCoverImage

		finDict = {'topic': topic, 'title': title, 'subtitle': subtitle, 'longitude': longitude, 'latitude': latitude, 'uuid': uuid, 'descriptionPage': htmlbody, 'audioFileRemoteLocation': audioFileRemoteLocation, 'coverImageRemoteLocation': coverImageLocation}
		
		mainDict[uuid] = finDict
		
		#print "Topic: "+topic
		#print "Title: "+title
		#print "Subtitle: "+subtitle
		#print "Longitude: "+longitude
		#print "Latitude: "+latitude
		#print "UUID: "+uuid
		#print "Remote File Location: "+audioFileName
		#print "-"
	
	plistlib.writePlist(mainDict, pathPlist)

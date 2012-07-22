import ConfigParser
from os import path
import constants

class appConfig:
	""" This class administered all data used for configuration the application """
	
	def __init__ (self):

		configFile = ConfigParser.RawConfigParser()

		if path.exists(_CONFIG_FILE):
			configFile.read(_CONFIG_FILE)
		else:
			createNewCFG(_CONFIG_FILE)

	
	def	createNewCFG(fileName):
		""" if Not exists config file. I'll create a new one with default values """
	
		#Mailer inbox

		configFile.add_section(_IN_SECTION)
		configFile.set(_IN_SECTION, _IN_HOST , "mail.yourhost.com")
		configFile.set(_IN_SECTION, _IN_USERNAME , "your username por inbox")
		configFile.set(_IN_SECTION, _IN_PASS , "your password")
		configFile.set(_IN_SECTION, _IN_SRV_TYPE , "POP3_SSL")
		configFile.set(_IN_SECTION, _IN_PORT , "995")
		configFile.set(_IN_SECTION, _IN_PROCDIR , "./procDir")

	def readConfig (section, value):
	#TODO Verify that section and value exists in configFile
		return config.get(section, value)

import ConfigParser
from os import path

######## INPUT MAILBOX ##################
from constants import _CONFIG_FILE, _IN_SECTION, _IN_HOST, _IN_USERNAME
from constants import _IN_PASS, _IN_SRV_TYPE, _IN_PORT, _IN_PROCDIR
#########################################



class appConfig:
	""" This class administered all data used for configuration the application """
	
	def __init__ (self):

		self.configFile = ConfigParser.RawConfigParser()

		if path.exists(_CONFIG_FILE):
			self.configFile.read(_CONFIG_FILE)
		else:
			self.createNewCFG (_CONFIG_FILE)

		self.hostIn = self.configFile.get( _IN_SECTION ,  _IN_HOST )
		self.userIn = self.configFile.get( _IN_SECTION , _IN_USERNAME )
		self.passIn = self.configFile.get( _IN_SECTION , _IN_PASS )
		self.srvTypeIn = self.configFile.get( _IN_SECTION , _IN_SRV_TYPE )
		self.portIn = self.configFile.get( _IN_SECTION , _IN_PORT )
		self.procDir = self.configFile.get( _IN_SECTION , _IN_PROCDIR )

	
	def	createNewCFG(self, fileName):
		""" if Not exists config file. I'll create a new one with default values """
	
		#Mailer inbox

		self.configFile.add_section(_IN_SECTION)
		self.configFile.set(_IN_SECTION, _IN_HOST , "mail.yourhost.com")
		self.configFile.set(_IN_SECTION, _IN_USERNAME , "your username por inbox")
		self.configFile.set(_IN_SECTION, _IN_PASS , "your password")
		self.configFile.set(_IN_SECTION, _IN_SRV_TYPE , "POP3_SSL")
		self.configFile.set(_IN_SECTION, _IN_PORT , "995")
		self.configFile.set(_IN_SECTION, _IN_PROCDIR , "./procDir")

		with open(fileName, 'wb') as cfgfile:
			self.configFile.write(cfgfile)

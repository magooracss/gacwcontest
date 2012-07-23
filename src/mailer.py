import poplib
from email.Parser import Parser
from dataconfig import appConfig

#TODO Make IMAP implementation


class mailer ():
	""" This class check mailbox and store new/updated scores in database"""

	def __init__(self):
		
		configuration = appConfig()

		self.host = configuration.hostIn
		self.user = configuration.userIn
		self.password = configuration.passIn
		self.srvType = configuration.srvTypeIn
		self.port = configuration.portIn
		self.procDir = configuration.procDir
		
	
	def processMail (self, mailNumber, theConnection):
		""" Read mail in pos mailNumber, stored its address & date in a LogFile and store the contest log in 'procDir' """
		
		response, headerLines, bytes = theConnection.retr (mailNumber) #Get mail

		tmpStr = '\n'.join (headerLines) #Put an Carriage Return to each element in headerLines
		p = Parser ()
		email = p.parsestr(tmpStr)
		
		if(email.is_multipart()):
			for part in email.get_payload():
				partType = part.get_content_type() # ('Text/plain', 'image/gif',...)
				if ("Text/plain" != partType): #I get all the attachments. I'm not analizing logs in text
					attFile = open (part.get_filename, 'wb')
					attFile.write (part.get_payload (decode = True))
					attFile.close

	
	def	getNewLogs (self):
		""" Stored new logs from email in the process dir (procDir)"""

		#Connection
		cnx = poplib . POP3_SSL ( self.host , self.port ) 
		cnx.user ( self.user )
		cnx.pass_ ( self.password)

		#Read mails from server 
		for idx in range (cnx.list()[1]):
			processMail(idx+1, cnx)
		
		#Close the connection
		cnx.quit()

if __name__ == '__main__':
	cfg = mailer()
	cfg.getNewLogs()


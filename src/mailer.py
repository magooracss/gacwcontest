import poplib
from email.Parser import Parser


#TODO Make IMAP implementation


class mailer (self):
	""" This class check mailbox and store new/updated scores in database"""

	def __init__(self):
		
		#TODO: Put this values in a config file

		self.host = "elHost" # address of server POP3
		self.user = "usuarioCorreo"	#Mail User
		self.password = "claveUsuario"	#Pass mail user
		self.srvType = "POP"	#Type server mail (IMAP/POP3/POP3_SSL)
		self.port = 995 #Port of server
		self.procDir = "./procDir"
		
	
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

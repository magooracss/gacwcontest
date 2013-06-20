# -*- coding: utf-8 -*-

#import sqlite3
from .errorlog import errorLog
from .msgs import ERROR_FILEFORMAT


class Cabrillo(object):

    def __init__(self, db=None):
        self.dbFile = db
        self.currDataFile = []
        self.error = errorLog()
        self.vCabrilllo = 0  # Version of Cabrillo

    def fileFormatOK(self, aFile):
        fData = open(aFile, 'r')
        aLinePart = fData.readline().partition(':')
        validCriteria = ['START-OF-LOG', 'CALLSIGN', 'CATEGORY',
             'CLAIMED-SCORE', 'NAME', 'ADDRESS']

        while (len(validCriteria) != 0):
            aLine = fData.readline()
            if (not aLine):
                break

            aLinePart = aLine.partition(':')
            if aLinePart[0].upper() in validCriteria:
                validCriteria.remove(aLinePart[0].upper())

        return (len(validCriteria) == 0)

    def processLine(aLine):
      #  raise NotImplementedError("Please Implement this method")
      # Cabrillo v2 & v3 differ only in the header information (I think)
      # It isn't necessary to make a subclass for each version
        return

    def loadQSOFile(self, aFile):
        """
            Read aFile and if the format is correct, import it to dbFile
        """
        if self.fileFormatOK(aFile):
            for aLine in self.currDataFile:
                selLine = self.inspectLine(aLine)
                self.processLine(selLine)
        else:
            self.error.error2Log(ERROR_FILEFORMAT + aFile)


class Cabrillov2(Cabrillo):

    def __init__(self):
        super(Cabrillov2, self).__init__()

    def processLine(aLine):
        return

# -*- coding: utf-8 -*-

import logging


class errorLog(object):

    def __init__(self, fileOutput='errorlog.log'):
        self.logger = logging.getLogger('procontest')
        hdlr = logging.FileHandler(fileOutput)
        formatter = logging.Formatter(
            '%(asctime)s %(levelname)s %(message)s')
        hdlr.setFormatter(formatter)
        self.logger.addHandler(hdlr)
        self.logger.setLevel(logging.WARNING)

    def error2Log(self, msg):
        self.logger.error(msg)
# -*- coding: utf-8 -*-

from peewee import *
from config import PATH_DB


class Contest(Model):

    def __init__(self):
        super(Contest, self).__init__()

    class Meta:

        def __init__(self):
            database = SqliteDatabase(PATH_DB)

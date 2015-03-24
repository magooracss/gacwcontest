# -*- coding: utf-8 -*-

from peewee import *
from config import PATH_DB


class Contester (Model):

    def __init__(self):
        super(Contester, self).__init__()

    class Meta:

        def __init__(self):
            database = SqliteDatabase(PATH_DB)

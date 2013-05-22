package org.mirah.notepad

import android.content.Context
import android.database.Cursor
import android.database.SQLException
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteDatabase.CursorFactory
import android.database.sqlite.SQLiteOpenHelper
import android.util.Log

class NotesDbHelper < SQLiteOpenHelper
  def self.initialize:void
    @@TAG = self.class.getName
    @@DATABASE_NAME = "data"
    @@DATABASE_CREATE = <<SQL
    create table notes (
      _id integer primary key autoincrement,
      title text not null,
      body text not null,
      date text not null
    );
SQL
    @@DATABASE_VERSION = 2
  end
  
  def initialize (context:Context)
    super context, @@DATABASE_NAME, CursorFactory(nil), @@DATABASE_VERSION
  end
  
  def onCreate(db:SQLiteDatabase):void
    db.execSQL @@DATABASE_CREATE
  end
  
  def onUpgrade(db:SQLiteDatabase, oldVersion:int, newVersion:int):void
    Log.w @@TAG, "Upgrading database from version #{oldVersion} to #{newVersion}, which will destroy all old data"
    db.execSQL "DROP TABLE IF EXISTS notes"
    onCreate db
  end
end
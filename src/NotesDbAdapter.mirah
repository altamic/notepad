package org.mirah.notepad

import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import android.util.Log

import java.util.List

class NotesDbAdapter
  def self.initialize:void
    @@DATABASE_TABLE = "notes"
    @@KEY_ROWID = "_id"
    @@KEY_TITLE = "title"
    @@KEY_BODY  = "body"
    @@KEY_DATE  = "date"
  end
  
  def initialize (context:Context)
    @@dbHelper = NotesDbHelper.new context
  end
  
  def open:void
    @db = @@dbHelper.getWritableDatabase
  end
  
  def close:void
    @@dbHelper.close
  end
  
  def self.DATABASE_TABLE
    @@DATABASE_TABLE
  end
  
  def self.KEY_ROWID
    @@KEY_ROWID
  end

  def self.KEY_TITLE
    @@KEY_TITLE
  end

  def self.KEY_BODY
    @@KEY_BODY
  end
  
  def self.KEY_DATE
    @@KEY_DATE
  end
  
  def createNote(title:String, body:String, date:String):long
    initialValues = ContentValues.new
    initialValues.put @@KEY_TITLE, title
    initialValues.put @@KEY_BODY, body
    initialValues.put @@KEY_DATE, date
    
    @db.insert @@DATABASE_TABLE, nil, initialValues
  end
  
  def fetchNote(rowId:long):Cursor
    array = toStringArray([@@KEY_ROWID, @@KEY_TITLE, @@KEY_BODY, @@KEY_DATE])
    cursor = @db.query true, @@DATABASE_TABLE, array, "#{@@KEY_ROWID} = #{rowId}", nil, nil, nil, nil, nil
    if !cursor.nil?
      cursor.moveToFirst
    end
    cursor
  end
  
  def updateNote(rowId:long, title:String, body:String, date:String):boolean
    args = ContentValues.new
    args.put @@KEY_TITLE, title
    args.put @@KEY_BODY, body
    args.put @@KEY_DATE, date
    
    (@db.update @@DATABASE_TABLE, args, "#{@@KEY_ROWID} = #{rowId}", nil) > 0;
  end
  
  def deleteNote(rowId:long):boolean
    (@db.delete @@DATABASE_TABLE, "#{@@KEY_ROWID} = #{rowId}", nil) > 0
  end
  
  def fetchAllNotes:Cursor
    array = toStringArray([@@KEY_ROWID, @@KEY_TITLE, @@KEY_BODY, @@KEY_DATE])
    @db.query @@DATABASE_TABLE, array, nil, nil, nil, nil, nil
  end
  
  def toStringArray(list:List):String[]
    strings = String[list.size]
    list.size.times { |i| strings[i] = String(list.get(i)) }
    strings
  end
end


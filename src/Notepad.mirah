package org.mirah.notepad

import android.app.ListActivity
import android.app.AlertDialog
import android.content.Intent
import android.database.Cursor
import android.os.Bundle

import android.view.ContextMenu
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.Button

import android.view.ContextMenu.ContextMenuInfo
import android.widget.AdapterView.AdapterContextMenuInfo
import android.widget.ListView
import android.widget.SimpleCursorAdapter

class Notepad < ListActivity
  def self.initialize:void
    @@ACTIVITY_CREATE = 0
    @@ACTIVITY_EDIT = 1

    @@INSERT_ID = Menu.FIRST
    @@DELETE_ID = Menu.FIRST + 1
  end

  def onCreate(state):void
    super state
    setContentView R.layout.notepad
    @@db = NotesDbAdapter.new self
    @@db.open
    fillData
    registerForContextMenu(getListView)
    
    saveButton = Button(findViewById R.id.save)
    this = self # scoping
    saveButton.setOnClickListener do |view|
      this.createNote
    end
  end
  
  def onDestroy:void
    super
    @@db.close
  end
  
  def onCreateOptionsMenu(menu:Menu)
    getMenuInflater.inflate(R.menu.notepad, menu)
    true
  end
  
  def onOptionsItemSelected(item:MenuItem)
    if item.getItemId == R.id.menu_about
      builder = AlertDialog.Builder.new self
      builder.setTitle "About"
      builder.setMessage "This program has been written in Mirah."      
      builder.setPositiveButton "OK" { |dialog, i|
        dialog.cancel
      }
      builder.show
      return true
    else
      super item
    end
  end
  
  def onMenuItemSelected(item:MenuItem):boolean
    if item.getItemId == @@INSERT_ID
      createNote
      return true
    end
    true
  end

  def fillData:void
    notesCursor = @@db.fetchAllNotes
    startManagingCursor notesCursor
    
    from = String[2]; from[0] = NotesDbAdapter.KEY_TITLE; from[1] = NotesDbAdapter.KEY_DATE
    to = int[2]; to[0] = R.id.text1; to[1] = R.id.date_row
    
    notes = SimpleCursorAdapter.new self, R.layout.notes_row, notesCursor, from, to
    setListAdapter notes
  end

  def onCreateContextMenu(menu:ContextMenu, v:View, menuInfo:ContextMenuInfo):void
    super menu, v, menuInfo
    menu.add 0, @@DELETE_ID, 0, R.string.menu_delete
  end

  def onContextItemSelected(item:MenuItem):boolean
    if item.getItemId == @@DELETE_ID
      info = item.getMenuInfo
      @@db.deleteNote AdapterContextMenuInfo(info).id
      fillData
      return true
    end
    super item
  end

  def createNote
    intent = Intent.new self, NoteEdit.class
    startActivityForResult intent, @@ACTIVITY_CREATE
  end

  def onListItemClick(list:ListView, view:View, position:int, id:long):void
    super list, view, position, id
    i = Intent.new self, NoteEdit.class
    i.putExtra NotesDbAdapter.KEY_ROWID, id
    startActivityForResult i, @@ACTIVITY_EDIT
  end

  def onActivityResult(requestCode:int, resultCode:int, intent:Intent):void
    super requestCode, resultCode, intent
    fillData
  end
end

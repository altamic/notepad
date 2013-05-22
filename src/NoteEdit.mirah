package org.mirah.notepad

import android.app.Activity
import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.os.Bundle

import android.view.ContextMenu
import android.view.Menu
import android.view.MenuItem

import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.TextView

import android.util.Log

import java.text.SimpleDateFormat
import java.util.Date

class NoteEdit < Activity
  def onCreate(state):void
    super state
    setContentView R.layout.note_edit
    
    @@db = NotesDbAdapter.new self
    @@db.open
    
    @titleText = EditText(findViewById R.id.title)
    @bodyText  = EditText(findViewById R.id.body)
    @dateText  = TextView(findViewById R.id.date)
    
    msTime      = long(System.currentTimeMillis)
    curDateTime = Date.new msTime
    formatter   = SimpleDateFormat.new "d'/'M'/'y"
    @curDate    = formatter.format curDateTime
    
    @dateText.setText @curDate
    
    @rowId  = if state.nil?
                long(-1)
              else
                state.getLong NotesDbAdapter.KEY_ROWID
              end
    
    if @rowId == -1
      extras = getIntent.getExtras
      @rowId = extras.getLong NotesDbAdapter.KEY_ROWID unless extras.nil?
    end
    
    populateFields
  end

  def onSaveInstanceState(outState):void
    super outState
    saveState
    outState.putLong NotesDbAdapter.KEY_ROWID, @rowId
  end

  def onPause:void
    super
    saveState
  end

  def onResume:void
    super
    populateFields
  end
  
  def onDestroy:void
    super
    @@db.close
  end
  
  def onCreateOptionsMenu(menu:Menu)
    getMenuInflater.inflate(R.menu.note_edit, menu)
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
    elsif item.getItemId == R.id.menu_delete
      @note.close if not @note.nil?
      @@db.deleteNote(@rowId) unless @rowId == -1
      finish
      return true
    elsif item.getItemId == R.id.menu_save
      saveState
      finish
      return true
    else
      super item
    end
  end

  def saveState:void
    title = @titleText.getText.toString
    body  = @bodyText.getText.toString
    
    if @rowId == -1
      id = @@db.createNote title, body, @curDate 
      if id > 0
        @rowId = id
      end
    else
      @@db.updateNote @rowId, title, body, @curDate
    end
  end

  def populateFields:void
    unless @rowId == -1
      @note = @@db.fetchNote @rowId
      startManagingCursor @note
      @titleText.setText @note.getString(@note.getColumnIndexOrThrow NotesDbAdapter.KEY_TITLE)
      @bodyText.setText @note.getString(@note.getColumnIndexOrThrow NotesDbAdapter.KEY_BODY)
      @dateText.setText @note.getString(@note.getColumnIndexOrThrow NotesDbAdapter.KEY_DATE)
    end
  end
end


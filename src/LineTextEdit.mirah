import android.content.Context

import android.view.View
import android.widget.EditText

import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Rect

import android.util.AttributeSet

class LineEditText < EditText
  def initialize(context:Context, attrs:AttributeSet)
    super context, attrs
    @rect = Rect.new; @paint = Paint.new 
    @paint.setStyle(Paint.Style.FILL_AND_STROKE)
    @paint.setColor(Color.BLUE);
  end

  def onDraw(canvas:Canvas):void
    height = self.getHeight
    line_height = self.getLineHeight
    
    count = height / line_height
    count = self.getLineCount if self.getLineCount > count
    
    baseline = int(self.getLineBounds(0, @rect))
    
    #
    # scoping
    #
    paint = @paint
    rect  = @rect
    this = self  
    
    count.times do
      canvas.drawLine(rect.left, baseline + 1, rect.right, baseline + 1, paint)
      baseline += this.getLineHeight
    end
  
    super canvas
  end
end
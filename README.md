Android Notepad in Mirah
========================

A port of the Android [Notepad Tutorial](http://developer.android.com/training/notepad/) to [Mirah](http://www.mirah.org/) with some graphic decoration

<img src="http://s18.postimg.org/997f5m9t5/mirah_notepad_1.png" alt="Mirah Notepad Screenshot 1" style="display:block" />

<img src="http://s21.postimg.org/b97q2urdz/mirah_notepad_2.png" alt="Mirah Notepad Screenshot 2" style="display:block" />


Installation
------------

### Prerequisites ###

0. [jruby](http://www.jruby.org/download) 1.7.x or newer, possibly installed with [rvm](https://rvm.io/rvm/install/) on your unix box
1. [mirah](https://github.com/mirah/mirah#ruby) (0.1.0 or newer) (with `gem install mirah`)
2. [pindah](https://github.com/mirah/pindah#requirements) (0.1.3.dev)
3. working Android env on your box: `android`, `adb` commands etc.. available
4. Android device or emulator conforming at least with API 10 (version 2.3.3)
5. Android API 15 installed


### Build Debug version ###

  `rake debug`

  `rake installd && rake logcat`


Credits
-------

Marko Kocić <https://github.com/markokocic/android-notepad-mirah>

Edison Heng <http://www.codeproject.com/Articles/524204/Simple-notepad-for-Android>



License
-------

Copyright (C) 2013 Michelangelo Altamore

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

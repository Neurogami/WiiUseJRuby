Neurogami::WiiUseJRuby
===================

by James Britt / Neurogami

http://www.neurogami.com


DESCRIPTION:
-------------------

A set of Ruby libs to make calling into the WiiUseJ Java jar a little nicer.  

Intended for use with JRuby


FEATURES:
-------------------

Gives a more Ruby-ish API to the underlying Java classes.

SYNOPSIS
------------

Install the gem from gems.neurogami.com

In the root of your project, run 

     wiiusejruby
  

This will copy over the lib files under lib/ruby/wiiusejruby



REQUIREMENTS
-------------------

You need to be using JRuby, and have WiiUseJ as part of your project.

WiiUseJ may not work well, or at all, on certain operating systems.  Such issues seem to depend on the underlying Bluetooth stack.

You will need to grab the WiiUseJ jar and any required Bluetooth libraries.  Please check the [WiiUseJ project page](http://code.google.com/p/wiiusej/) for details.  WiiUseJRuby assumes you have already set up you project with the required WiUseJ files.

The code more or less assumes you are creating a [Monkeybars](https://github.com/monkeybars/monkeybars-core) app.  It should not be too hard to pull apart the core WiUseJ code if you wish to use the JRuby stuff independent of Monkeybars. 


INSTALL
-------------------

(sudo) gem install WiiUseJRuby --source http://gems/neurogami.com

Or finagle an installation from the git repo.


THE EXAMPLE
-------------

There's an example program included.  It's a very simple Monkeybars app, and happens to include all the files required to build and run the program on Ubuntu. It has not been extensively tested, so don't bet your life on it running for you.  Attempts were made to get it working in Windows 7 but the result was failure and depression.

If you cannot run it then the most likely culprit is the Bluetooth stack.  You need to be using JRuby with the project, and will need to have [Rawr](https://github.com/rawr/rawr) installed.

The code should be enough to show you how to use WiiUseJ in a program, and how to set up event mappings to get code to respond to the assorted Wiimote events.

WiiUseJ seems to have a bug or quirk or something that prevents it from correctly indicating when a button has been released.  Or it's possible the code in the example is wrong. Any information about this is welcome, because button-release events are very useful.

There is another Wiimote Java library, WiiRemoteJ, that does a much better job with this.  This is a JRuby wrapper library for that as well, [WiiRemoteJRuby](https://github.com/Neurogami/WiiRemoteJRuby).

WiiRemoteJRuby may be the better library.  it seems the original project has been abandoned, and it was never open source, so you're stuck using a compiled jar.  Some folks have picked up the code ([for example](https://github.com/micromu/WiiRemoteJ)) though it isn't clear if anything has been updated.

Note that even though WiiUseJ is open source, it too has not seen much attention in many years.  WiiUseJ is released under the GNU Lesser GPL.  WiiRemoteJ has a less formal license.

Examine each to see if one or another works better for you.



LICENSE
--------------

(The MIT License)

Copyright (c) 2015 James Britt/Neurogami

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


Feed your head.

Hack your world.

Live curious.

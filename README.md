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

LICENSE
--------------

(The MIT License)

Copyright (c) 2015 James Britt

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

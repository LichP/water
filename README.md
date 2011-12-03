Water: Web App Template for Executable Ruby
===========================================

Water provides a [Rack][1] powered web app template, a launcher for the web
app, and a couple of rake tasks to build app + launcher as either a
standalone Windows executable or an Inno installer using [Ocra][2] (creating
an installer requires [Inno Setup][3]).

Uses
----

I currently have a bunch of Cygwin based Ruby command-line apps/scripts at
work for automating some of my regular admin tasks, but these aren't very
accesible for my non-techy colleagues, so my plan is to port these in to a
web app that can be easily deployed on Windows machines without need for
hosting etc.

Quick Start
-----------

1. Install [RubyInstaller for Windows][4]
2. Install gems for Ocra, Rack, and your favourite web framework (the
template uses [Sinatra][5] by default)
3. Clone the Water repo
4. Run ```applaunch.rb```: if everything installed OK you should get the
template app run in a console window and a new tab in your default browser
showing the app's home page.
5. Modify ```$app_name``` and ```$app_version``` in the Rakefile to suit
your needs (@todo: come up with a better way of doing this)
6. Run ```rake exe``` to make a standalone executable

Optional: To make an installer, install [Inno Setup][3] and run ```rake
installer```

Known Issues
------------

Windows firewall will likely complain at you every time you run the
standalone executable, as the embedded Ruby interpreter will be unpacked to
a different directory each time (see [Ocra issue 19][6]). This problem can
be avoided by going down the installer route.

--
Phil Stewart
December 2011

[1]: http://rack.rubyforge.org
[2]: http://ocra.rubyforge.org
[3]: http://www.jrsoftware.org
[4]: http://rubyinstaller.org
[5]: http://www.sinatrarb.com
[6]: https://github.com/larsch/ocra/issues/19
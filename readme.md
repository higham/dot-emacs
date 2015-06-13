Dot Emacs 
==========

This repository contains my .emacs file.
It builds on the work of many others, including
[Sacha Chua](https://github.com/sachac),
[Xah Lee](https://github.com/xahlee), and
[John Wiegley](https://github.com/jwiegley).

I run Emacs on both Windows and Mac machines.  On Windows, my ~/.emacs file
(called .emacs_windows in this repository) loads .~/dropbox/.emacs and
then ./dropbox/.emacs_custom-windows.
The setup for the Mac is similar.

* Some of the .emacs code uses conditional tests to see whether it is
  running on a Windows machine or a Mac machine and take different action
  in each case.

* The code is lightly documented with links to sources for the
  things I am using.

* I have recently started using John Wiegley's use-package for loading
  packages.  Not everything is converted and I may convert other package to
  load this way.


<!---
Some more background information is given in the blog post ...
-->

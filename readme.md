Dot Emacs 
==========

This repository contains my .emacs file.
It builds on the work of many others, including
[Sacha Chua](https://github.com/sachac),
[Xah Lee](https://github.com/xahlee), and
[John Wiegley](https://github.com/jwiegley).

I run Emacs on both Windows and Mac machines.  On Windows, my ~/.emacs file
(called .emacs_windows in this repository) loads ~/dropbox/.emacs and
then ~/dropbox/.emacs_custom-windows.
The setup for the Mac is analogous.

* Some of the .emacs code uses conditional tests to see whether it is
  running on a Windows machine or a Mac machine and take different action
  in each case.

* The code is lightly documented with links to sources for the
  things I am using.

* I have recently started using John Wiegley's use-package for loading
  packages.  Not everything is converted and I may convert other packages to
  load this way.

* Orgstruct mode is turned on by the first line of the file, so pressing
  tab or shift-tab will collapse or expand the file into or from headings,
  as in Org mode.

Some more background information is given in the blog post
[My Dot Emacs](https://nickhigham.wordpress.com/2015/06/18/my-dot-emacs).

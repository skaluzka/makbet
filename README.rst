Welcome to the **makbet** project!

**makbet** stands for **mak**\ efile **b**\ ased **e**\ xtraordinary **t**\ ool.

Keep reading && have fun! :)


Why?
====

This project has been created for several reasons...

Mainly to help:

- automating various complex scenarios,
- modelling, and prototyping complex real-life processes (e.g.: production/delivery chain) consisting of many tasks having many dependencies,
- reflecting, simulating and profiling complicated existing flows,
- visualizing dependencies in big projects (can help to find circular dependencies),
- optimizing execution paths in existing systems.

But also to help:

- learning GNU make utility,
- learning DOT language,
- learning bash scripting.

And (the last but not least):

- **FOR FUN! :)**


Features
========

**makbet's** key features are:

- based on GNU make tool and its features,
- easy extensible,
- contains built-in minimalistic tasks library (set of bash scripts),
- support for parallelism,
- pure console tool - no GUI required,
- good and fast integration with other console programs,
- minimal system requirements (see below).


System requirements
===================

Well... nothing special here :)

The only system requirements are:

- GNU linux OS
- GNU make tool (version **3.82+**)
- bash tool

So far **makbet** has been successfully tested (run all example scenarios
from ``examples/`` dir) with GNU make **4.3** and bash **5.0.16**.


Installing
==========

Installing **makbet** is quite easy.

- Clone the **makbet** project.
- Export the ``MAKBET_PATH`` variable pointing to clone directory (e.g.: ``export MAKBET_PATH=/tmp/makbet``).

That's all. You are ready to go! :)


Few words about backward compatibility
======================================


Please be aware that **makbet** is still in heavy development phase (no
major release has been done so far).

There are a couple of quite nice improvements already proposed, see the
details here https://github.com/skaluzka/makbet/issues. Therefore there
is no guarantee that backward compatibility will be keept (at least until
the first official version will be released).


Examples
========

Two **DOT** online editors have been successfully tested with **makbet**:

- https://edotor.net/ (fully interactive!)
- http://webgraphviz.com/ (very simple, but works! :D)


References
==========

Useful **GNU make** links:

- https://www.gnu.org/software/make/manual/
- http://www.conifersystems.com/whitepapers/gnu-make/

Useful **DOT language** links:

- https://graphviz.gitlab.io/documentation/
- https://en.wikipedia.org/wiki/DOT_%28graph_description_language%29


Contributing
============

Pull requests are welcome! :)


Mission statement
=================

*"What's done, is done."* (William Shakespeare, **Macbeth**).

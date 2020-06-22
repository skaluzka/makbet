Welcome the **makbet** project!

|

**makbet** stands for **mak**\ (efile) **b**\ (ased) **e**\ (xtraordinary)
**t**\ (ool).

Keep reading && have fun! :)

|

Why?
====

This project has been created for several reasons...

Mainly to help:

- automating various complex scenarios,
- modelling, and prototyping complex real-life processes
  (e.g.: production/delivery chain) consisting of many tasks having many
  dependencies,
- reflecting, simulating and profiling complicated existing flows,
- visualizing dependencies in big projects (can help to find circular
  dependencies, or long execution paths),
- optimizing execution paths in existing systems.

But also to help:

- learning **GNU make** utility,
- learning **DOT** language,
- learning bash scripting.

|

And (the last but not least):

- **FOR FUN! :)**

|

Features
========

**makbet's** key features are:

- based on **GNU make** tool and its features,
- easy extensible,
- contains built-in minimalistic tasks library (set of bash scripts),
- support for parallelism,
- can be easy added/embedded into existing projects as 3rd party SW,
- pure console tool - no GUI required,
- good and fast integration with other console programs,
- unified naming scheme for all makbet's specific environment variables
  (every variable has ``MAKBET_`` prefix),
- unified syntax for all makbet's CLI options (every option has
  ``MAKBET_`` prefix),
- saving tasks' details in **key=value** ``*.cfg`` files for further
  usage (e.g.: by shell scripts),
- saving tasks' details in ``*.csv`` files for futher processing if needed
  (this feature can be enabled by ``MAKBET_CSV=1`` CLI option),
- profiling - measuring tasks duration (this feature can be enabled by
  ``MAKBET_PROFILES=1`` CLI option),
- generating **DOT** output showing relations between tasks (this feature can
  be enabled by ``MAKBET_DOT=1`` CLI option),
- minimal system requirements (see below).

|

System requirements
===================

Well... nothing special here :)

The only system requirements are:

- GNU linux OS
- GNU make tool (version **3.82+**)
- bash tool

All example scenarios have been successfully tested with with **GNU make 4.3**
and **bash 5.0.16**.

|

Installing
==========

Installing **makbet** is quite easy.

- Download or clone the **makbet** project from github.
- Export the ``MAKBET_PATH`` variable pointing to makbet's main directory
  (e.g.: ``export MAKBET_PATH=/tmp/makbet``).

And that's all. You are now ready to write your own scenarios (or play with
built-in `examples <https://github.com/skaluzka/makbet/tree/master/examples>`_).

|

Few words about backward compatibility
======================================


Please be aware that **makbet** is still in heavy development phase (no
major release has been done so far).

There are a couple of quite nice improvements already proposed for **makbet**,
see the details here https://github.com/skaluzka/makbet/issues.  Therefore
there is no guarantee that backward compatibility will be keept (at least until
the first official version will be released).

|

DOT output
==========

For every properly created scenario **makbet** is able to generate output
compatible with **DOT** language (in form of so-called **digraph** - directed
graph - showing the flow direction between all tasks).  Such output can be
easily saved or redirected to file.  This can be achieved by passing
``MAKBET_DOT=1`` option to ``make`` execution command (by deafult
``MAKBET_DOT=0``).  Special makbet's target ``.show-summary-dot-file`` will
display **DOT** results as in below example:

::

    [user@localhost test-scenario1]$ make all MAKBET_DOT=1 && make .show-summary-dot-file

    ...

    2020-06-13 16:04:56 [INFO]: Task all started.
    2020-06-13 16:04:56 [INFO]: Task all terminated.

    digraph {

    "all" -> "t-F";
    "t-A";
    "t-B1" -> "t-A";
    "t-B2" -> "t-A";
    "t-B3" -> "t-A";
    "t-B4" -> "t-A";
    "t-B5" -> "t-A";
    "t-C" -> "t-B2";
    "t-C" -> "t-B3";
    "t-D" -> "t-C";
    "t-E" -> "t-B1";
    "t-E" -> "t-B4";
    "t-E" -> "t-B5";
    "t-E" -> "t-D";
    "t-F" -> "t-E";

    }

    [user@localhost test-scenario1]$


Two **DOT** online editors have been successfully tested with **makbet**:

- https://edotor.net/ (fully interactive!)
- http://webgraphviz.com/ (very simple, but works! :D)

|

References
==========

Useful **GNU make** links:

- https://www.gnu.org/software/make/manual/
- http://www.conifersystems.com/whitepapers/gnu-make/

Useful **DOT language** links:

- https://graphviz.gitlab.io/documentation/
- https://en.wikipedia.org/wiki/DOT_%28graph_description_language%29

|

Contributing
============

Pull requests are welcome! :)

For more details about contributing rules please check
`CONTRIBUTING.rst <https://github.com/skaluzka/makbet/blob/master/CONTRIBUTING.rst>`_
file.

|

Mission statement
=================

*"What's done, is done."* - William Shakespeare, **Macbeth**.

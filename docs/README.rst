Welcome to **makbet's** documentation!

|

Keep reading && have fun! :)

|

----

|

The documentation directory structure is:

::

  $MAKBET_PATH/docs/
  ├── examples/
  │   ├── 01.dummy/
  │   │   ├── results.csv
  │   │   ├── results.dot
  │   │   └── results.png
  │   ├── 02.toolchain-basic/
  │   │   ├── results.csv
  │   │   ├── results.dot
  │   │   └── results.png
  │   ├── 02.toolchain-complex/
  │   │   ├── results.csv
  │   │   ├── results.dot
  │   │   └── results.png
  │   ├── 03.ping-dns-servers/
  │   │   ├── results.csv
  │   │   ├── results.dot
  │   │   └── results.png
  │   ├── 04.sleep/
  │   │   ├── results.csv
  │   │   ├── results.dot
  │   │   └── results.png
  │   └── 05.comments/
  │       ├── results.csv
  │       ├── results.dot
  │       └── results.png
  ├── templates/
  │   └── scenario/
  │       └── Makefile
  └── README.rst

where:

- ``docs/`` - The main documentation directory.  Its absolute path can be
  defined as ``$MAKBET_PATH/docs`` (or ``$MAKBET_PATH/docs/``) assuming the
  ``$MAKBET_PATH`` variable is pointing to **makbet's** main directory.
- ``docs/examples/`` - Separate directory dedicated to storing all
  documentation about **makbet's** examples placed inside top-level
  ``examples/`` directory.
- ``docs/templates/`` - Separate directory dedicated to storing various makbet's
  templates (like scenario template for example) which can be freely used while
  creating custom content.
- ``README.rst`` - The file you are reading now.


.. End of file

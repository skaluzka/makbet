Welcome to **makbet's** examples content!

|

Keep reading && have fun! :)

|

----

**Table of contents**
---------------------

- | `Background`_
- | `01.dummy`_
- | `02.toolchain-basic`_
- | `02.toolchain-complex`_
- | `03.ping-dns-servers`_
- | `Directory structure`_

|

**Background**
--------------

We are providing **four** complete examples for further study and examination.
Every example can be freely run with all combinations of **makbet's** CLI
options (``MAKBET_*``) as well as easily modified.  All results of modifications
are easy to observe and notice.

|

**01.dummy**
------------

The first example is saved in ``examples/01.dummy/`` directory.  It doesn't do
anything special.  The file ``01.dummy/Makefile`` (called also a **makbet's**
scenario file) contains list of all tasks which are specific for this
example.  All defined tasks are just a fake tasks (please check the content of
``examples/01.dummy/tasks/generic-task.sh`` script).  This example can be run
at any time with minimal requirements and effort.

|

**02.toolchain-basic**
----------------------

The second example is saved in ``examples/02.toolchain-basic/`` directory.  The
main goal of this example is to build, locally from the source code, a simple
toolchain consists of:

- **doxygen 1.8.19**
- **git 2.28.0**
- **kcov 38**
- **make 4.3**
- **python 3.9.0b5**

|

**02.toolchain-complex**
------------------------

The next example is saved in ``examples/02.toolchain-complex/`` directory.  The
goal of this example is exactly the same as in ``examples/02.toolchain-basic``
case.  In fact, the real differences between **02.toolchain-basic** and
**02.toolchain-complex** examples are the ``Makefile`` files which both have
different constructions.  **02.toolchain-complex** example uses more advanced
syntax in its ``Makefile`` file.  However both examples share the same set of
tasks from ``examples/lib/tasks/02.toolchain/common/`` directory.  Two different
versions of the same scenario have been created for comparison and testing
purposes.  As expected final results for both **02.toolchain-basic** and
**02.toolchain-complex** should be the same.

|

**03.ping-dns-servers**
-----------------------

The last example is saved in ``examples/03.ping-dns-servers/`` directory.  The
goal of that example is to ping **three** DNS servers
(``1.1.1.1`` + ``8.8.4.4`` + ``8.8.8.8``) simultaneously using standard ``ping``
utility.  There is no dedicated script in this example.  Syntax of raw ``ping``
commands are passed directly to ``TASK_template`` macro.

|

**Directory structure**
-----------------------

The **makbet's** examples directory structure is:

::

  examples/
  ├── 01.dummy/
  │   ├── Makefile
  │   └── tasks/
  │       └── generic-task.sh
  ├── 02.toolchain-basic/
  │   └── Makefile
  ├── 02.toolchain-complex/
  │   └── Makefile
  ├── 03.ping-dns-servers/
  │   └── Makefile
  ├── lib/
  │   └── tasks/
  │       └── 02.toolchain/
  │           └── common/
  │               ├── build-doxygen.sh
  │               ├── build-git.sh
  │               ├── build-kcov.sh
  │               ├── build-make.sh
  │               └── build-python.sh
  └── README.rst

|

where:

- ``examples/`` - The main examples directory.  Its absolute path can be defined
  as ``$MAKBET_PATH/examples`` (or ``$MAKBET_PATH/examples/``) assuming the
  ``$MAKBET_PATH`` variable is pointing to **makbet's** main directory.

|

- ``01.dummy/`` - Dedicated directory for **makbet's** ``01.dummy`` example.
- ``01.dummy/Makefile`` - So-called **makbet's** scenario file.  It contains
  complete task list for **makbet's** ``01.dummy`` example.
- ``01.dummy/tasks/`` - Separate directory containing tasks specific only for
  **makbet's** ``01.dummy`` example.
- ``01.dummy/tasks/generic-task.sh`` - Simple and generic **Bash** script used
  only in **makbet's** ``01.dummy`` example.  It doesn't do anything special.

|

- ``02.toolchain-basic/`` - Dedicated directory for **makbet's**
  ``02.toolchain-basic`` example.
- ``02.toolchain-basic/Makefile`` - So-called **makbet's** scenario file.  It
  contains complete task list for **makbet's** ``02.toolchain-basic`` example.

|

- ``02.toolchain-complex/`` - Dedicated directory for **makbet's**
  ``02.toolchain-complex`` example.
- ``02.toolchain-complex/Makefile`` - So-called **makbet's** scenario file.  It
  contains complete task list for **makbet's** ``02.toolchain-complex`` example.
  This ``Makefile`` file is more advanced version of
  ``02.toolchain-basic/Makefile`` file described earlier.

|

- ``03.ping-dns-servers/`` - Dedicated directory for **makbet's**
  ``03.ping-dns-servers`` example.
- ``03.ping-dns-servers/Makefile`` - So-called **makbet's** scenario file.  It
  contains complete task list for **makbet's** ``03.ping-dns-servers`` example.

|

- ``lib/tasks/02.toolchain/common/`` - Separate directory containing all tasks
  common for both **02.toolchain-basic** and **02.toolchain-complex** examples.
- ``lib/tasks/02.toolchain/common/build-doxygen.sh`` - This **Bash** script is
  used by **two** ``build-doxygen`` tasks (defined in **02.toolchain-basic**
  and **02.toolchain-complex** examples).  Its aim is to build
  **doxygen 1.8.19** from previously downloaded sources.
- ``lib/tasks/02.toolchain/common/build-git.sh`` - This **Bash** script is used
  by **two** ``build-git`` tasks (defined in **02.toolchain-basic** and
  **02.toolchain-complex** examples).  Its aim is to build **git 2.28.0** from
  previously downloaded sources.
- ``lib/tasks/02.toolchain/common/build-kcov.sh`` - This **Bash** script is used
  by **two** ``build-kcov`` tasks (defined in **02.toolchain-basic** and
  **02.toolchain-complex** examples).  Its aim is to build **kcov 38** from
  previously downloaded sources.
- ``lib/tasks/02.toolchain/common/build-make.sh`` - This **Bash** script is used
  by **two** ``build-make`` tasks (defined in **02.toolchain-basic** and
  **02.toolchain-complex** examples).  Its aim is to build **make 4.3** from
  previously downloaded sources.
- ``lib/tasks/02.toolchain/common/build-python.sh`` - This **Bash** script is
  used by **two** ``build-python`` tasks (defined in **02.toolchain-basic** and
  **02.toolchain-complex** examples).  Its aim is to build **python 3.9.0b5**
  from previously downloaded sources.

|

- ``README.rst`` - The file you are reading now.


.. The end

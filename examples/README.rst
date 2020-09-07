Welcome to **makbet's** examples content!

|

Keep reading && have fun! :)

|

----

**Table of Contents**
---------------------

- | `Background`_
- | `01.dummy`_
- | `02.toolchain-simple`_
- | `03.toolchain-advanced`_
- | `04.ping-dns-servers`_
- | `05.sleep`_
- | `06.comments`_
- | `Directory structure`_

|

**Background**
--------------

We are providing **six** complete examples for further study and examination.
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

**02.toolchain-simple**
-----------------------

The second example is saved in ``examples/02.toolchain-simple/`` directory.
The main goal of this example is to build, locally from the source code,
a simple toolchain consists of:

- **doxygen 1.8.19**
- **git 2.28.0**
- **kcov 38**
- **make 4.3**
- **python 3.9.0b5**

|

**03.toolchain-advanced**
-------------------------

The next example is saved in ``examples/03.toolchain-advanced/`` directory.  The
goal of this example is exactly the same as in ``examples/02.toolchain-simple``
case.  In fact, the real differences between **02.toolchain-simple** and
**03.toolchain-advanced** examples are the ``Makefile`` files which both have
different constructions.  **03.toolchain-advanced** example uses more advanced
syntax in its ``Makefile`` file.  However both examples share the same set of
tasks from ``examples/lib/tasks/02.toolchain/common/`` directory.  Two different
versions of the same scenario have been created for comparison and testing
purposes.  As expected final results for both **02.toolchain-simple** and
**03.toolchain-advanced** should be the same.

|

**04.ping-dns-servers**
-----------------------

The next example is saved in ``examples/04.ping-dns-servers/`` directory.  The
goal of that example is to show how useful parallel tasks execution can be.
With this scenario **three** popular DNS servers
(``1.1.1.1`` + ``8.8.4.4`` + ``8.8.8.8``) can be checked/pinged simultaneously
using standard ``ping`` utility.  To achieve that, the ``-j`` flag has to be
passed to the ``make`` command (for example ``make -j4``).  Please note that
there is no dedicated task script in this example.  The syntax of all raw
``ping`` commands is passed directly to ``TASK_template`` macro.

|

**05.sleep**
------------

The next example is saved in ``examples/05.sleep/`` directory.  This is another
good example showing how to play with parallel tasks execution.  The Makefile
file of this scenario contains **five** sleep tasks: ``sleep-1s``, ``sleep-2s``,
``sleep-3s``, ``sleep-5s`` and ``sleep-8s``.  All of them can be run,
sequentially - one after another, if ``make`` command will be run with ``-j1``
flag (or without ``-j`` flag at all).  But they can be also run in parallel if
``-j3`` (or in general if jobs value will be greater than 1) flag will be passed
to the ``make`` command.

|

**06.comments**
---------------

The last example is saved in ``examples/06.comments/`` directory.  This example
is degraded - all tasks inside scenario ``Makefile`` are commented nonetheless
``makbet.mk`` works as expected and works the same like for any other scenario.

|

**Directory structure**
-----------------------

The **makbet's** examples directory structure is:

::

  $MAKBET_PATH/examples/
  ├── 01.dummy/
  │   ├── Makefile
  │   └── tasks/
  │       └── generic-task.sh
  ├── 02.toolchain-simple/
  │   └── Makefile
  ├── 03.toolchain-advanced/
  │   └── Makefile
  ├── 04.ping-dns-servers/
  │   └── Makefile
  ├── 05.sleep/
  │   └── Makefile
  ├── 06.comments/
  │   └── Makefile
  ├── lib/
  │   └── tasks/
  │       ├── 02.toolchain/
  │       │   └── common/
  │       │       ├── build-doxygen.sh
  │       │       ├── build-git.sh
  │       │       ├── build-kcov.sh
  │       │       ├── build-make.sh
  │       │       └── build-python.sh
  │       └── common/
  │           ├── check-dirs.sh
  │           ├── check-files.sh
  │           ├── create-dir-structure.sh
  │           ├── download-file.sh
  │           ├── exec-cmd.sh
  │           ├── show-free-space.sh
  │           ├── show-uname.sh
  │           ├── show-uptime.sh
  │           ├── sleep.sh
  │           ├── uncompress-tgz-file.sh
  │           ├── uncompress-txz-file.sh
  │           └── uncompress-zip-file.sh
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

- ``02.toolchain-simple/`` - Dedicated directory for **makbet's**
  ``02.toolchain-simple`` example.
- ``02.toolchain-simple/Makefile`` - So-called **makbet's** scenario file.  It
  contains complete task list for **makbet's** ``02.toolchain-simple`` example.

|

- ``03.toolchain-advanced/`` - Dedicated directory for **makbet's**
  ``03.toolchain-advanced`` example.
- ``03.toolchain-advanced/Makefile`` - So-called **makbet's** scenario file.  It
  contains complete task list for **makbet's** ``03.toolchain-advanced``
  example.  This ``Makefile`` file is more advanced version of
  ``02.toolchain-simple/Makefile`` file described earlier.

|

- ``04.ping-dns-servers/`` - Dedicated directory for **makbet's**
  ``04.ping-dns-servers`` example.
- ``04.ping-dns-servers/Makefile`` - So-called **makbet's** scenario file.  It
  contains complete task list for **makbet's** ``04.ping-dns-servers`` example.

|

- ``05.sleep/`` - Dedicated directory for **makbet's** ``05.sleep`` example.
- ``05.sleep/Makefile`` - So-called **makbet's** scenario file.  It contains
  complete task list for **makbet's** ``05.sleep`` example.

|

- ``06.comments/`` - Dedicated directory for **makbet's** ``06.comments``
  example.
- ``06.comments/Makefile`` - So-called **makbet's** scenario file.  It contains
  complete task list for **makbet's** ``06.comments`` example.

|

- ``lib/tasks/02.toolchain/common/`` - Separate directory containing all tasks
  common for both **02.toolchain-simple** and **03.toolchain-advanced**
  examples.
- ``lib/tasks/02.toolchain/common/build-doxygen.sh`` - This **Bash** script is
  used by **two** ``build-doxygen`` tasks (defined in **02.toolchain-simple**
  and **03.toolchain-advanced** examples).  Its aim is to build
  **doxygen 1.8.19** from previously downloaded sources.
- ``lib/tasks/02.toolchain/common/build-git.sh`` - This **Bash** script is used
  by **two** ``build-git`` tasks (defined in **02.toolchain-simple** and
  **03.toolchain-advanced** examples).  Its aim is to build **git 2.28.0** from
  previously downloaded sources.
- ``lib/tasks/02.toolchain/common/build-kcov.sh`` - This **Bash** script is used
  by **two** ``build-kcov`` tasks (defined in **02.toolchain-simple** and
  **03.toolchain-advanced** examples).  Its aim is to build **kcov 38** from
  previously downloaded sources.
- ``lib/tasks/02.toolchain/common/build-make.sh`` - This **Bash** script is used
  by **two** ``build-make`` tasks (defined in **02.toolchain-simple** and
  **03.toolchain-advanced** examples).  Its aim is to build **make 4.3** from
  previously downloaded sources.
- ``lib/tasks/02.toolchain/common/build-python.sh`` - This **Bash** script is
  used by **two** ``build-python`` tasks (defined in **02.toolchain-simple** and
  **03.toolchain-advanced** examples).  Its aim is to build **python 3.9.0b5**
  from previously downloaded sources.

|

- ``lib/tasks/common/`` - Separate directory containing all tasks common for
  all makbet's examples.  Tasks from that directory are used in both
  **02.toolchain-simple** and **03.toolchain-advanced** examples.

|

- ``README.rst`` - The file you are reading now.


.. End of file

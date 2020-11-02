Welcome to **makbet's** examples content!

|

Keep reading && have fun! :)

|

----

**Table of Contents**
---------------------

- | `Background`_
- | `Directory structure`_

|

**Background**
--------------

We are providing **six** complete examples for further study and examination.
Every example can be freely run with all combinations of **makbet's** CLI
options (``MAKBET_*``) as well as easily modified.  All results of modifications
are easy to observe and notice.

|

**Directory structure**
-----------------------

The **makbet's** examples directory structure is:

::

  $MAKBET_PATH/examples/
  ├── 01.dummy/
  │   ├── Makefile
  │   ├── README.rst
  │   ├── results/
  │   │   ├── output.csv
  │   │   ├── output.dot
  │   │   └── output.png
  │   └── tasks/
  │       └── generic-task.sh
  ├── 02.toolchain-simple/
  │   ├── Makefile
  │   ├── README.rst
  │   └── results/
  │       ├── output.csv
  │       ├── output.dot
  │       └── output.png
  ├── 03.toolchain-advanced/
  │   ├── Makefile
  │   ├── README.rst
  │   └── results/
  │       ├── output.csv
  │       ├── output.dot
  │       └── output.png
  ├── 04.ping-dns-servers/
  │   ├── Makefile
  │   ├── README.rst
  │   └── results/
  │       ├── output.csv
  │       ├── output.dot
  │       └── output.png
  ├── 05.sleep/
  │   ├── Makefile
  │   ├── README.rst
  │   └── results/
  │       ├── output.csv
  │       ├── output.dot
  │       └── output.png
  ├── 06.comments/
  │   ├── Makefile
  │   ├── README.rst
  │   └── results/
  │       ├── output.csv
  │       ├── output.dot
  │       └── output.png
  ├── lib/
  │   └── tasks/
  │       ├── build-scripts/
  │       │   ├── build-doxygen.sh
  │       │   ├── build-git.sh
  │       │   ├── build-kcov.sh
  │       │   ├── build-make.sh
  │       │   └── build-python.sh
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

  17 directories, 49 files

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

- ``lib/tasks/build-scripts/`` - Separate directory containing all tasks
  common for both **02.toolchain-simple** and **03.toolchain-advanced**
  examples.
- ``lib/tasks/build-scripts/build-doxygen.sh`` - This **Bash** script is
  used by **two** ``build-doxygen`` tasks (defined in **02.toolchain-simple**
  and **03.toolchain-advanced** examples).  Its aim is to build
  **doxygen 1.8.20** from previously downloaded sources.
- ``lib/tasks/build-scripts/build-git.sh`` - This **Bash** script is used
  by **two** ``build-git`` tasks (defined in **02.toolchain-simple** and
  **03.toolchain-advanced** examples).  Its aim is to build **git 2.29.2** from
  previously downloaded sources.
- ``lib/tasks/build-scripts/build-kcov.sh`` - This **Bash** script is used
  by **two** ``build-kcov`` tasks (defined in **02.toolchain-simple** and
  **03.toolchain-advanced** examples).  Its aim is to build **kcov 38** from
  previously downloaded sources.
- ``lib/tasks/build-scripts/build-make.sh`` - This **Bash** script is used
  by **two** ``build-make`` tasks (defined in **02.toolchain-simple** and
  **03.toolchain-advanced** examples).  Its aim is to build **make 4.3** from
  previously downloaded sources.
- ``lib/tasks/build-scripts/build-python.sh`` - This **Bash** script is
  used by **two** ``build-python`` tasks (defined in **02.toolchain-simple** and
  **03.toolchain-advanced** examples).  Its aim is to build **python 3.9.0**
  from previously downloaded sources.

|

- ``lib/tasks/common/`` - Separate directory containing all tasks common for
  all makbet's examples.  Tasks from that directory are used in both
  **02.toolchain-simple** and **03.toolchain-advanced** examples.

|

- ``README.rst`` - The file you are reading now.


.. End of file

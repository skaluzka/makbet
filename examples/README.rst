Welcome to **makbet's** examples content!

|

Keep reading && have fun! :)

|

We are providing **two** complete examples for further study and examination.

|

The first example is saved in ``examples/dummy`` directory.  It doesn't do
anything special.  The file ``dummy/Makefile`` (called also a scenario file)
contains list of all tasks which are specific for this example.  All defined
tasks are just a dummy tasks (please check the content of
``examples/dummy/tasks/generic-task.sh`` script).  This example can be run at
any time with minimal requirements and effort.

|

The second example which is saved in ``examples/toolchain`` directory has
**two** versions (scenario files): **basic** and **advanced**.  Both versions
(scenario files) share the same set of tasks which are simple ``bash`` scripts
saved inside ``examples/toolchain/tasks`` directory.  The main goal of this
example is to build, locally from the source code, a simple toolchain consists
of:

- **doxygen 1.8.18**
- **git 2.27.0**
- **kcov 38**
- **make 4.3**
- **python 3.9.0b4**

The real differences between **basic** and **advanced** versions are the
``Makefile`` files which both have different constructions.  As mentioned above
both scenario files share the same set of tasks thus the final result should be
exactly the same.

|

Both (**dummy** and **toolchain**) examples can be freely run with all
combinations of **makbet's** CLI options (``MAKBET_*``).  As expected both
examples can be easily modified.  All results of modifications are easy to
observe and notice.

|

The **makbet's** examples directory structure is:

::

  examples/
  ├── README.rst
  ├── dummy/
  │   ├── Makefile
  │   └── tasks/
  │       └── generic-task.sh
  └── toolchain/
      ├── tasks/
      │   ├── build-doxygen.sh
      │   ├── build-git.sh
      │   ├── build-kcov.sh
      │   ├── build-make.sh
      │   └── build-python.sh
      ├── basic/
      │   └── Makefile
      └── advanced/
          └── Makefile

|

where:

- ``examples/`` - The main examples directory (its absolute path is defined as
  ``$MAKBET_PATH/examples`` assuming the ``$MAKBET_PATH`` variable is pointing
  to **makbet's** main directory).
- ``README.rst`` - The file you are reading now.

|

- ``dummy/`` - Dedicated directory for **makbet's** ``dummy`` example.
- ``dummy/Makefile`` - So-called makbet's scenario file.  It contains complete
  task list for **makbet's** ``dummy`` example.
- ``dummy/tasks/`` - Separate directory containing tasks specific only for
  **makbet's** ``dummy`` example.
- ``dummy/tasks/generic-task.sh`` - Simple and generic ``bash`` script used
  only in **makbet's** ``dummy`` example.  It doesn't do anything special.

|

- ``toolchain/`` - Dedicated directory for **makbet's** ``toolchain`` example.
- ``toolchain/tasks/`` - Separate directory containing tasks specific only
  for **makbet's** ``toolchain`` example (as mentioned earlier for testing and
  comparison purposes this example has two versions: **basic** and
  **advanced**.  The ``toolchain/tasks/`` directory contains tasks common for
  both versions).
- ``toolchain/tasks/build-doxygen.sh`` - This ``bash`` script is used by **two**
  ``build-doxygen`` tasks (defined in ``examples/toolchain/basic/Makefile`` and
  ``examples/toolchain/advanced/Makefile``) for building **doxygen 1.8.18** from
  sources.
- ``toolchain/tasks/build-git.sh`` - This ``bash`` script is used by **two**
  ``build-git`` tasks (defined in ``examples/toolchain/basic/Makefile`` and
  ``examples/toolchain/advanced/Makefile``) for building **git 2.27.0** from
  sources.
- ``toolchain/tasks/build-kcov.sh`` - This ``bash`` script is used by **two**
  ``build-kcov`` tasks (defined in ``examples/toolchain/basic/Makefile`` and
  ``examples/toolchain/advanced/Makefile``) for building **kcov 38** from
  sources.
- ``toolchain/tasks/build-make.sh`` - This ``bash`` script is used by **two**
  ``build-make`` tasks (defined in ``examples/toolchain/basic/Makefile`` and
  ``examples/toolchain/advanced/Makefile``) for building **make 4.3** from
  sources.
- ``toolchain/tasks/build-python.sh`` - This ``bash`` script is used by **two**
  ``build-python`` tasks (defined in ``examples/toolchain/basic/Makefile`` and
  ``examples/toolchain/advanced/Makefile``) for building **python 3.9.0b4**
  from sources.
- ``toolchain/basic/Makefile`` - So-called makbet's scenario file.  It contains
  complete task list for **makbet's** ``toolchain`` example.
  This is a **basic** version.
- ``toolchain/advanced/Makefile`` - So-called makbet's scenario file.  It
  contains complete task list for **makbet's** ``toolchain`` example.  This is
  an **advanced** version.


.. The end

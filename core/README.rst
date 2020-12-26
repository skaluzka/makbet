Welcome to **makbet's** core directory!

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

This is **makbet's** core directory.  All files here are directly used
inside main **makbet's** file - ``makbet.mk``.  Changing these files might
significantly impact **makbet's** behaviour.  Currently all core scripts are
short, simple, **Bash** scripts, but they might be easily changed/replaced
with any other kind of executable.

|

**Directory structure**
-----------------------

::

  $MAKBET_PATH/core/
  ├── __convert_cfg2csv
  ├── __count_tasks
  ├── __get_makbet_version
  ├── __print_task_details
  ├── __save_dot_file
  ├── __save_task_event
  ├── __save_task_profile
  └── README.rst

  0 directories, 8 files

|

where:

- ``__convert_cfg2csv`` - This script will convert a single ``*.cfg`` file
  to corresponding ``*.csv`` file.

- ``__count_tasks`` -  This script will count all uncommented tasks
  (means all instances of ``TASK_template`` macro) inside particular
  **makbet's** scenario file.

- ``__get_makbet_version`` - This simple script will read the **makbet's**
  version from top-level ``VERSION`` file or from the git repository (in case
  **makbet** is running inside git clone directory).  The version will be
  printed out while running ``make makbet-version`` command.

- ``__print_task_details`` - Short script for printing task's details
  (like task id, task name, task dependencies, ...) on the console, during
  the runtime.  This script is being run only in case ``MAKBET_VERBOSE``
  variable is greater or equeal than ``1``.

- ``__save_dot_file`` - This script will save the **DOT** code, describing
  every task, to its dedicated file (file with ``*.dot`` extension) inside
  the ``$MAKBET_PATH/.cache/dot/`` directory.  The script is being run only
  when ``MAKBET_DOT`` variable is set to ``1``.  By default ``MAKBET_DOT=0``.

- ``__save_task_event`` - This script will save task's ``*.cfg`` event file
  into ``$MAKBET_PATH/.cache/events/cfg/`` directory.  Every task event file
  can be converted from ``*.cfg`` to ``*.csv`` form when ``MAKBET_CSV``
  variable is set to ``1``.  By default ``MAKBET_CSV=0``.  In case
  ``MAKBET_CSV=1`` the script ``__convert_cfg2csv``, described above, will
  convert ``*.cfg`` file to ``*.csv`` form, and save it into
  ``$MAKBET_PATH/.cache/events/csv/`` location.  The ``MAKBET_CSV_SEP`` and
  ``MAKBET_EVENTS_CSV_HEADER`` variables defined in ``makbet.mk`` file will
  be used during ``*.csv`` file generation.

- ``__save_task_profile`` - This script will save task's ``*.cfg`` **profile**
  **results** - inside ``$MAKBET_PATH/.cache/prof/cfg/`` directory.  Tasks
  profiling is disabled by default (``MAKBET_PROF=0``).  In case
  ``MAKBET_CSV=1`` the script ``__convert_cfg2csv``, described above, will
  convert ``*.cfg`` file to ``*.csv`` form, and save it into
  ``$MAKBET_PATH/.cache/prof/csv/`` location.  The ``MAKBET_CSV_SEP`` and
  ``MAKBET_PROF_CSV_HEADER`` variables defined in ``makbet.mk`` file will
  be used during ``*.csv`` file generation.

- ``README.rst`` - The file you are reading now.


.. End of file

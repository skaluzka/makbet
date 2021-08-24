This document describes the syntax of **TASK_template** macro defined
in ``makbet.mk`` file.

|

Keep reading && have fun! :)

|

----

**Table of Contents**
---------------------

- | `Reference syntax`_
- | `Complete form - examples`_
- | `Minimized forms - examples`_
- | `Useful links`_


**Reference syntax**
--------------------

The reference syntax of **TASK_template** macro is:

::

    $(eval $(call TASK_template, \
        TASK_NAME, "TASK_DESCR", \
        TASK_DEPS, \
        TASK_CMD, TASK_CMD_OPTS \
    ))

In simple cases (short task's name, description, dependencies, ...)
the **five line** block format is recommended:

.. csv-table::
   :header: Line Number, Code line, Description
   :delim: |

    1 | ``$(eval $(call TASK_template, \`` | Begin of ``TASK_template`` macro evaluation.
    2 | ``TASK_NAME, "TASK_DESCR", \`` | Defining task's name (``TASK_NAME``) and task's description (``"TASK_DESCR"``).
    3 | ``TASK_DEPS, \`` | Defining task's dependencies (``TASK_DEPS``).
    4 | ``TASK_CMD, TASK_CMD_OPTS \`` | Defining task's command (``TASK_CMD``) and its options (``TASK_CMD_OPTS``).
    5 | ``))`` | End of ``TASK_template`` macro evaluation.

In more complex cases it is recommended to use multi-line constructions:

::

    $(eval $(call TASK_template, \
        TASK_NAME, \
        "TASK_DESCR", \
        TASK_DEPS, \
        TASK_CMD, \
            TASK_CMD_OPTS \
    ))

.. csv-table::
   :header: Line Number, Code line, Description
   :delim: |

    1 | ``$(eval $(call TASK_template, \`` | Begin of ``TASK_template`` macro evaluation.
    2 | ``TASK_NAME, \`` | Defining task's name (``TASK_NAME``).
    3 | ``"TASK_DESCR", \`` | Defining task's description (``"TASK_DESCR"``).
    4 | ``TASK_DEPS, \`` | Defining task's dependencies (``TASK_DEPS``).
    5 | ``TASK_CMD, \`` | Defining task's command (``TASK_CMD``).
    6 | ``TASK_CMD_OPTS \`` | Defining task's command options (``TASK_CMD_OPTS``).
    7 | ``))`` | End of ``TASK_template`` macro evaluation.

The **TASK_template** macro accepts **five** positional parameters:

1. ``TASK_NAME``
2. ``TASK_DESCR``
3. ``TASK_DEPS``
4. ``TASK_CMD``
5. ``TASK_CMD_OPTS``

Order of all these parameters is important and cannot be mixed, otherwise
evaluation of **TASK_template** macro might cause unexpected behavior.
As parameter's separator, the comma (**,**) sign is used.
Such comma-separated syntax is coming originally from **GNU make** utility
(please read the links collected in `Useful links`_ section at the bottom
of this page).

This explains why, right after the **TASK_template** macro evaluation line
**five** comma-separated parameters (parts) are present.

The meanings of all parameters are:

- ``TASK_NAME`` - **Mandatory**. The name of the task.  It must be declared
  with comma sign at the end.
- ``"TASK_DESCR"`` - **Mandatory**. The task's description. It must be quoted.
  Empty strings allowed.  It must be declared with comma sign at the end.
- ``TASK_DEPS`` - **Optional**. All task's dependencies (space separated if
  more than one).  An empty field allowed.  It must be declared with comma
  sign at the end.
- ``TASK_CMD`` - **Optional**. The task's command.  An empty field allowed.
  It must be declared with comma sign at the end if ``TASK_CMD_OPTS`` is also
  used.
- ``TASK_CMD_OPTS`` - **Optional**. All options (space separated if more than
  one) passed to task's command.  Empty field allowed.  It can be finished with
  comma sign at the end.


**Complete form - examples**
----------------------------

**Example 1:**

::

    $(eval $(call TASK_template, \
        ping1111, "Ping 1.1.1.1 dns server", \
        INIT, \
        ping, -c10 1.1.1.1 \
    ))

**Example 1 - explanation:**

- ``TASK_NAME``: ``ping1111``
- ``"TASK_DESCR"``: ``"Ping 1.1.1.1 dns server"``
- ``TASK_DEPS``: ``INIT``
- ``TASK_CMD``: ``ping``
- ``TASK_CMD_OPTS``:

  - ``-c10``
  - ``1.1.1.1``

**Example 2:**

::

    $(eval $(call TASK_template, \
        fetch-git-src, "Fetch git sources", \
        prepare-workdir-structure, \
        $(MAKBET_TASKS_DIR)/common/download-file, \
            https://github.com/git/git/archive/v2.33.0.zip \
            $(WORK_DIR)/git/v2.33.0.zip \
    ))

**Example 2 - explanation:**

- ``TASK_NAME``: ``fetch-git-src``
- ``"TASK_DESCR"``: ``"Fetch git sources"``
- ``TASK_DEPS``: ``prepare-workdir-structure``
- ``TASK_CMD``: ``$(MAKBET_TASKS_DIR)/common/download-file``
- ``TASK_CMD_OPTS``:

  - ``https://github.com/git/git/archive/v2.33.0.zip``
  - ``$(WORK_DIR)/git/v2.33.0.zip``

**Example 3:**

::

    $(eval $(call TASK_template, \
        check-all-src-dirs, "Check all source code dirs", \
        unpack-doxygen-src unpack-git-src unpack-kcov-src unpack-make-src unpack-python-src, \
        $(MAKBET_TASKS_DIR)/common/check-dirs, \
            $(WORK_DIR)/doxygen/doxygen-Release_1_9_1/ \
            $(WORK_DIR)/git/git-2.33.0/ \
            $(WORK_DIR)/kcov/kcov-38/ \
            $(WORK_DIR)/make/make-4.3/ \
            $(WORK_DIR)/python/Python-3.9.6/ \
    ))

**Example 3 - explanation:**

- ``TASK_NAME``: ``check-all-src-dirs``
- ``"TASK_DESCR"``: ``"Check all source code dirs"``
- ``TASK_DEPS``:

  - ``unpack-doxygen-src``
  - ``unpack-git-src``
  - ``unpack-kcov-src``
  - ``unpack-make-src``
  - ``unpack-python-src``

- ``TASK_CMD``: ``$(MAKBET_TASKS_DIR)/common/check-dirs``
- ``TASK_CMD_OPTS``:

  - ``$(WORK_DIR)/doxygen/doxygen-Release_1_9_1/``
  - ``$(WORK_DIR)/git/git-2.33.0/``
  - ``$(WORK_DIR)/kcov/kcov-38/``
  - ``$(WORK_DIR)/make/make-4.3/``
  - ``$(WORK_DIR)/python/Python-3.9.6/``


**Minimized forms - examples**
------------------------------

**Example 1:**

::

    $(eval $(call TASK_template, \
        @01-INIT, "Entry point", \
    ))

**Example 1 - explanation:**

- ``TASK_NAME``: ``@01-INIT``
- ``"TASK_DESCR"``: ``"Entry point"``
- ``TASK_DEPS``: **None**
- ``TASK_CMD``: **None**
- ``TASK_CMD_OPTS``: **None**

**Example 2:**

::

    $(eval $(call TASK_template, \
        all, "Ping all dns servers", \
        ping1111 ping8844 ping8888, \
    ))

**Example 2 - explanation:**

- ``TASK_NAME``: ``all``
- ``"TASK_DESCR"``: ``"Ping all dns servers"``
- ``TASK_DEPS``:

  - ``ping1111``
  - ``ping8844``
  - ``ping8888``

- ``TASK_CMD``: **None**
- ``TASK_CMD_OPTS``: **None**


**Useful links**
----------------

- https://www.gnu.org/software/make/manual/html_node/Call-Function.html
- https://www.gnu.org/software/make/manual/html_node/Eval-Function.html
- https://www.cmcrossroads.com/article/basics-gnu-make
- http://make.mad-scientist.net/the-eval-function/


.. EOF

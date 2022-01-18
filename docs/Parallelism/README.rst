This document describes the correct way of using **makbet** to run many tasks
simultaneously.

|

Keep reading && have fun! :)

|

----

**Table of Contents**
---------------------

- | `Background`_
- | `Examples`_
- | `Analysis of 04.ping-dns-servers example`_
- | `Useful links`_

|

**Background**
--------------

As already stated **makbet** framework has been built on top of **GNU Make**
tool.  It means all **GNU Make** features are also available for **makbet**
utility.  Especially, the **GNU Make** job-server mechanism, can be also used
by **makbet**.  Simply speaking, **makbet** can run many tasks in parallel,
if all of them are declared properly and have properly defined dependencies.
In **GNU Make**, ``-j/--jobs`` command line flag can be used for handling
tasks in parallel:

::

  [user@localhost ~]$ make --help | grep '\--jobs'
    -j [N], --jobs[=N]          Allow N jobs at once; infinite jobs with no arg.
  [user@localhost ~]$

The same rule applies for **makbet**.

Another **GNU Make** flag, ``-l/--max-load``, can also be used here:

::

  [user@localhost ~]$ make --help | grep -A1 '\--load'
    -l [N], --load-average[=N], --max-load[=N]
                                Don't start multiple jobs unless load is below N.
  [user@localhost ~]$

|

**Examples**
------------

Together with **makbet** few example scenarios are provided.  All of them can
be run with ``-j/--jobs`` and ``-l/--max-load`` flags.  For some examples
differences might be small and difficult to notice, but at lest **three**
examples are perfectly designed for parallel execution.  Those examples are:

- `examples/01.dummy <../../examples/01.dummy>`_
- `examples/04.ping-dns-servers <../../examples/04.ping-dns-servers>`_
- `examples/05.sleep <../../examples/05.sleep>`_

|

**Analysis of 04.ping-dns-servers example**
-------------------------------------------

The scenario file for **04.ping-dns-servers** use case is written in
`this Makefile <../../examples/04.ping-dns-servers/Makefile>`_ file.
There are **six** tasks in total defined for this scenario:

- ``@01-INIT`` - Initial task.  This is, so-called, scenario entry point
  task.  This task does not have any dependency.
- ``ping1111`` - Dedicated task to perform ICMP ping on ``1.1.1.1`` DNS
  server.  This task is executing ``ping -c10 1.1.1.1`` command and depends
  only on ``@01-INIT`` defined above.
- ``ping8844`` - Dedicated task to perform ICMP ping on ``8.8.4.4.`` DNS
  server.  This task is executing ``ping -c4 8.8.4.4`` command and depends
  only on ``@01-INIT`` defined above.
- ``ping8888`` - Dedicated task to perform ICMP ping on ``8.8.8.8.`` DNS
  server.  This task is executing ``ping -c4 8.8.8.8`` command and depends
  only on ``@01-INIT`` defined above.
- ``ping-all`` - This is so-called grouping task.  It depends on **three**
  other tasks: ``ping1111``, ``ping8844`` and ``ping8888``.  All of them
  have to succeed before **makbet** will run ``ping-all`` task.  Also,
  the finishing order of all dependent tasks, does not matter at all.
  If any dependent task will fail, **makbet** will not run ``ping-all``
  task at all.
- ``all`` - This is, so-called, a **mirror task** for ``ping-all`` task which
  is described above.  Calling both, ``make ping-all``, and ``make all``
  commands will produce exactly the same results.  If ``make all`` will
  succeed first then calling ``make ping-all`` will bring no effects at all.
  Defining and using **mirror tasks** can be useful during testing phase,
  for tasks grouping purposes, keeping consistent name schema, or to avoid
  using long names.

Corresponding information regarding all tasks can be also displayed with
``make scenario-help`` command:

::

  [user@localhost 04.ping-dns-servers]$ make scenario-help

  Found 6 valid task(s) defined in /home/user/makbet/examples/04.ping-dns-servers/Makefile:

    @01-INIT
      - Id.:   1
      - Descr: "Entry point"
      - Deps:
      - Cmd:
      - Opts:

    ping1111
      - Id.:   2
      - Descr: "Ping 1.1.1.1 dns server"
      - Deps:  @01-INIT
      - Cmd:   ping
      - Opts:  -c10 1.1.1.1

    ping8844
      - Id.:   3
      - Descr: "Ping 8.8.4.4 dns server"
      - Deps:  @01-INIT
      - Cmd:   ping
      - Opts:  -c4 8.8.4.4

    ping8888
      - Id.:   4
      - Descr: "Ping 8.8.8.8 dns server"
      - Deps:  @01-INIT
      - Cmd:   ping
      - Opts:  -c4 8.8.8.8

    ping-all
      - Id.:   5
      - Descr: "Ping all dns servers"
      - Deps:  ping1111 ping8844 ping8888
      - Cmd:
      - Opts:

    all
      - Id.:   6
      - Descr: "Ping all dns servers"
      - Deps:  ping1111 ping8844 ping8888
      - Cmd:
      - Opts:

  [user@localhost 04.ping-dns-servers]$

This scenario can be run in two modes: in **serial** mode and in **parallel**
mode.

In **serial** mode, ``make`` tool should be used together with ``-j 1``
(or ``--jobs=1``), or without ``-j/--jobs`` option at all:

::

  [user@localhost 04.ping-dns-servers]$ make all

or

::

  [user@localhost 04.ping-dns-servers]$ make -j 1 all

or

::

  [user@localhost 04.ping-dns-servers]$ make -j1 all

or

::

  [user@localhost 04.ping-dns-servers]$ make --jobs 1 all

or

::

  [user@localhost 04.ping-dns-servers]$ make --jobs=1 all

Of course ``make all`` is the shortest option, therefore it is also the most
comfortable.  All above will produce the same results.

In **serial** case, **makbet** will run all tasks, one after another,
analyzing their dependencies starting from task ``all`` (or ``ping-all``
if it was used instead of ``all``).  **makbet** will keep the order of tasks
execution the same as order of tasks declaration inside the
`Makefile <../../examples/04.ping-dns-servers/Makefile>`__ scenario.

|

In **parallel** mode, **makbet** framework will reuse **GNU Make** jobserver
mechanism to run many tasks at the same time.  To run jobserver the ``make``
command has to be invoked with ``-j/--jobs`` option.  The number of jobs, that
is obvious, **has to be greater than one**, for example:

::

  [user@localhost 04.ping-dns-servers]$ make -j4 all

or

::

  [user@localhost 04.ping-dns-servers]$ make -j 4 all

or

::

  [user@localhost 04.ping-dns-servers]$ make --jobs=4 all

or

::

  [user@localhost 04.ping-dns-servers]$ make --jobs 4 all

The jobserver mechanism will run many jobs at the same time (see the
number passed to the ``make`` by ``-j/--jobs`` flag).  The order of tasks
execution is **random** and can be different for every ``make`` command
invocation.  Of course **makbet** will analyze tasks' dependencies here
as well.  In **parallel** mode it is very important to design tasks'
dependencies properly.  With wrong dependencies model, there is a high risk
that **makbet** will call dependent task at the same time which might fail
the whole scenario.

To see different tasks order execution please invoke below command few times:

::

  [user@localhost 04.ping-dns-servers]$ make makbet-clean && make -j4 all

Also total time execution for entire scenario can be shorter in **parallel**
mode than in **serial** one.  For example, in **serial** mode, the total
execution time of **04.ping-dns-servers** scenario is about **15 seconds**
as below:

::

  [user@localhost 04.ping-dns-servers]$ make makbet-clean && time make all

  2020-12-31 18:53:29.949 [INFO]: Task "@01-INIT" (TASK_ID: 1) started.


  2020-12-31 18:53:29.967 [INFO]: Task "@01-INIT" (TASK_ID: 1) terminated.


  2020-12-31 18:53:30.037 [INFO]: Task "ping1111" (TASK_ID: 2) started.

  PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
  64 bytes from 1.1.1.1: icmp_seq=1 ttl=60 time=57.0 ms
  64 bytes from 1.1.1.1: icmp_seq=2 ttl=60 time=57.8 ms
  64 bytes from 1.1.1.1: icmp_seq=3 ttl=60 time=58.0 ms
  64 bytes from 1.1.1.1: icmp_seq=4 ttl=60 time=57.5 ms
  64 bytes from 1.1.1.1: icmp_seq=5 ttl=60 time=57.5 ms
  64 bytes from 1.1.1.1: icmp_seq=6 ttl=60 time=56.9 ms
  64 bytes from 1.1.1.1: icmp_seq=7 ttl=60 time=58.8 ms
  64 bytes from 1.1.1.1: icmp_seq=8 ttl=60 time=57.4 ms
  64 bytes from 1.1.1.1: icmp_seq=9 ttl=60 time=56.4 ms
  64 bytes from 1.1.1.1: icmp_seq=10 ttl=60 time=56.9 ms

  --- 1.1.1.1 ping statistics ---
  10 packets transmitted, 10 received, 0% packet loss, time 9013ms
  rtt min/avg/max/mdev = 56.428/57.432/58.842/0.647 ms

  2020-12-31 18:53:39.139 [INFO]: Task "ping1111" (TASK_ID: 2) terminated.


  2020-12-31 18:53:39.248 [INFO]: Task "ping8844" (TASK_ID: 3) started.

  PING 8.8.4.4 (8.8.4.4) 56(84) bytes of data.
  64 bytes from 8.8.4.4: icmp_seq=1 ttl=116 time=56.4 ms
  64 bytes from 8.8.4.4: icmp_seq=2 ttl=116 time=58.1 ms
  64 bytes from 8.8.4.4: icmp_seq=3 ttl=116 time=57.2 ms
  64 bytes from 8.8.4.4: icmp_seq=4 ttl=116 time=57.1 ms

  --- 8.8.4.4 ping statistics ---
  4 packets transmitted, 4 received, 0% packet loss, time 3004ms
  rtt min/avg/max/mdev = 56.422/57.217/58.126/0.605 ms

  2020-12-31 18:53:42.337 [INFO]: Task "ping8844" (TASK_ID: 3) terminated.


  2020-12-31 18:53:42.512 [INFO]: Task "ping8888" (TASK_ID: 4) started.

  PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
  64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=56.5 ms
  64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=56.7 ms
  64 bytes from 8.8.8.8: icmp_seq=3 ttl=117 time=56.9 ms
  64 bytes from 8.8.8.8: icmp_seq=4 ttl=117 time=57.1 ms

  --- 8.8.8.8 ping statistics ---
  4 packets transmitted, 4 received, 0% packet loss, time 3005ms
  rtt min/avg/max/mdev = 56.514/56.799/57.082/0.216 ms

  2020-12-31 18:53:45.617 [INFO]: Task "ping8888" (TASK_ID: 4) terminated.


  2020-12-31 18:53:45.706 [INFO]: Task "all" (TASK_ID: 6) started.


  2020-12-31 18:53:45.723 [INFO]: Task "all" (TASK_ID: 6) terminated.


  real	0m15.896s
  user	0m0.620s
  sys	0m0.090s
  [user@localhost 04.ping-dns-servers]$

In **parallel** mode, we can see all ``ping1111``, ``ping8844`` and
``ping8888`` tasks were started almost at the same time.  Moreover, the
total execution time is, as expected, shorter than in **serial** mode
(**9** seconds vs **15** seconds):

::

  [user@localhost 04.ping-dns-servers]$ make makbet-clean && time make -j4 all

  2020-12-31 18:59:36.215 [INFO]: Task "@01-INIT" (TASK_ID: 1) started.


  2020-12-31 18:59:36.245 [INFO]: Task "@01-INIT" (TASK_ID: 1) terminated.


  2020-12-31 18:59:36.361 [INFO]: Task "ping8844" (TASK_ID: 3) started.


  2020-12-31 18:59:36.367 [INFO]: Task "ping1111" (TASK_ID: 2) started.


  2020-12-31 18:59:36.368 [INFO]: Task "ping8888" (TASK_ID: 4) started.

  PING 8.8.4.4 (8.8.4.4) 56(84) bytes of data.
  PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
  PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
  64 bytes from 8.8.4.4: icmp_seq=1 ttl=116 time=57.7 ms
  64 bytes from 1.1.1.1: icmp_seq=1 ttl=60 time=56.2 ms
  64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=56.1 ms
  64 bytes from 8.8.4.4: icmp_seq=2 ttl=116 time=56.7 ms
  64 bytes from 1.1.1.1: icmp_seq=2 ttl=60 time=55.6 ms
  64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=56.2 ms
  64 bytes from 8.8.4.4: icmp_seq=3 ttl=116 time=56.3 ms
  64 bytes from 1.1.1.1: icmp_seq=3 ttl=60 time=55.1 ms
  64 bytes from 8.8.8.8: icmp_seq=3 ttl=117 time=56.2 ms
  64 bytes from 8.8.4.4: icmp_seq=4 ttl=116 time=56.4 ms

  --- 8.8.4.4 ping statistics ---
  4 packets transmitted, 4 received, 0% packet loss, time 3005ms
  rtt min/avg/max/mdev = 56.260/56.773/57.696/0.559 ms
  64 bytes from 1.1.1.1: icmp_seq=4 ttl=60 time=55.4 ms
  64 bytes from 8.8.8.8: icmp_seq=4 ttl=117 time=55.7 ms

  --- 8.8.8.8 ping statistics ---
  4 packets transmitted, 4 received, 0% packet loss, time 3004ms
  rtt min/avg/max/mdev = 55.698/56.033/56.208/0.199 ms

  2020-12-31 18:59:39.460 [INFO]: Task "ping8844" (TASK_ID: 3) terminated.


  2020-12-31 18:59:39.461 [INFO]: Task "ping8888" (TASK_ID: 4) terminated.

  64 bytes from 1.1.1.1: icmp_seq=5 ttl=60 time=57.1 ms
  64 bytes from 1.1.1.1: icmp_seq=6 ttl=60 time=56.1 ms
  64 bytes from 1.1.1.1: icmp_seq=7 ttl=60 time=56.6 ms
  64 bytes from 1.1.1.1: icmp_seq=8 ttl=60 time=56.3 ms
  64 bytes from 1.1.1.1: icmp_seq=9 ttl=60 time=55.3 ms
  64 bytes from 1.1.1.1: icmp_seq=10 ttl=60 time=55.8 ms

  --- 1.1.1.1 ping statistics ---
  10 packets transmitted, 10 received, 0% packet loss, time 9013ms
  rtt min/avg/max/mdev = 55.117/55.952/57.051/0.586 ms

  2020-12-31 18:59:45.470 [INFO]: Task "ping1111" (TASK_ID: 2) terminated.


  2020-12-31 18:59:45.571 [INFO]: Task "all" (TASK_ID: 6) started.


  2020-12-31 18:59:45.605 [INFO]: Task "all" (TASK_ID: 6) terminated.


  real	0m9.579s
  user	0m0.620s
  sys	0m0.140s
  [user@localhost 04.ping-dns-servers]$

For graphical representation of scenario's flow please check this
`output.png <../../examples/04.ping-dns-servers/results/output.png>`_ file.

Even more useful comparison data will be generated while passing the following
command line flags to ``make`` command: ``MAKBET_CSV=1``, ``MAKBET_PROF=1``
and ``MAKBET_DOT=1``. For more details please check main
`README <../../README.rst>`_ file (`Profiling <../../README.rst#profiling>`_,
`DOT output <../../README.rst#dot-output>`_,
`CSV output <../../README.rst#csv-output>`_,
`PNG output <../../README.rst#png-output>`_).

|

**This general approach can be applied for every valid makbet's scenario**.

|

As already mentioned, in top-level `README <../../README.rst>`__ file
(`Rationale <../../README.rst#rationale>`_ section), one of main
**makbet's** goal is to visualize complex flows for optimization
purposes.  Running scenarios in **serial** and **parallel** mode
is a good practice while searching the best and optimal tasks
combination for big projects.

|

**Useful links**
----------------

- https://www.gnu.org/software/make/manual/html_node/Parallel.html
- https://www.gnu.org/software/make/manual/html_node/Parallel-Output.html
- https://www.gnu.org/software/make/manual/html_node/Job-Slots.html
- https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html
- https://www.gnu.org/software/make/manual/html_node/Parallel-Input.html
- https://www.gnu.org/software/make/manual/html_node/Terminal-Output.html

|


.. EOF

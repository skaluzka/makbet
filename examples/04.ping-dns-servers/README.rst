**04.ping-dns-servers**
-----------------------

The goal of this example is to show how easy the parallel tasks execution
can be achieved with **makbet** utility.

|

With this scenario, the most popular **three** DNS servers
(``1.1.1.1`` + ``8.8.4.4`` + ``8.8.8.8``) can be checked simultaneously
using standard ``ping`` utility.  To achieve that, the ``-j`` flag has
to be passed to the ``make`` command (for example ``make -j4``).  Please
note that there is no dedicated task script in this example.  The syntax
of all raw ``ping`` commands is passed directly to ``TASK_template``
macro.  Input params for ``ping`` command can be different for different
servers.


.. End of file

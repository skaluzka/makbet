**05.sleep**
------------

This is another good example showing how to play with parallel tasks execution.
The Makefile file of this scenario contains **five** sleep tasks: ``sleep-1s``,
``sleep-2s``, ``sleep-3s``, ``sleep-5s`` and ``sleep-8s``.  All of them can be
run, sequentially - one after another, if ``make`` command will be run with
``-j1`` flag (or without ``-j`` flag at all).  But they can be also run in
parallel if ``-j3`` (or in general if jobs value will be greater than 1) flag
will be passed to the ``make`` command.


.. End of file

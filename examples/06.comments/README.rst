**06.comments**
---------------

This is a good example of fully degraded **makbet's** scenario.

|

All tasks defined inside scenario ``Makefile`` are commented out.
Nonetheless, ``makbet.mk`` works with this scenario as expected,
moreover it works the same way like for any other scenario.  For example,
calling the command ``make scenario-help ; echo $?`` will end without
errors, because there is no task which can be evaluated inside
``Makefile`` file.  All other special **makbet's** tasks work
also correctly.  The aim of this example is to show how to properly
comment tasks out inside inside scenario ``Makefile``.


.. EOF

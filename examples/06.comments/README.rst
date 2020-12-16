**06.comments**
---------------

This is a good example of fully degraded **makbet's** scenario.

|

All tasks defined inside scenario ``Makefile`` are commented out.
Nonetheless, ``makbet.mk`` works here as expected, and works the same
way like for any other scenario.  For example calling the command
``make scenario-help ; echo $?`` will end without errors, because there
is no task which can be evaluated inside ``Makefile`` file.


.. End of file

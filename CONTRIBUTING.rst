**Development model**


We are preferring so-called **fork** development model in **makbet** project.

For more about it please read official github help pages:
`<https://help.github.com/en/github/getting-started-with-github/fork-a-repo>`_.

Main development branch is the **master** branch. We are trying to keep the
linear history of commits, on that branch, as much as possible.

|

**Commit types**


For simplification we are distinguish only **three** type of commits in
**makbet** project:

#. Pure development commits - regular but small and reasonable updates, changes
   or enhancements including minor refactoring as well. All of them can be done
   on a **master** branch but they **must have** ``[DEV]`` subject in the commit
   message. This rule is valid only for **makbet's** maintainers who are allowed
   to work on the **master** branch directly.
   Examples:
   `45df932 <https://github.com/skaluzka/makbet/commit/45df932>`_,
   `631f41c <https://github.com/skaluzka/makbet/commit/631f41c>`_.
#. Fix and quick fix commits - various small and trivial corrections and fixes
   noticed during the regular development phase on the **master** branch and not
   covered by any github issue. All of them **must have** ``[FIX]`` subject in
   the commit message.  This rule is valid only for **makbet's** maintainers who
   are allowed to work on the **master** branch directly.
   Examples:
   `29e9822 <https://github.com/skaluzka/makbet/commit/29e9822>`_,
   `a4d6b35 <https://github.com/skaluzka/makbet/commit/a4d6b35>`_.
#. Issues reported in github - entire development handled via issues reported
   on github (https://github.com/skaluzka/makbet/issues). All of them
   **must have** properly constructed title in the commit message containing
   the number of the issue in square brackets. Examples: ``[#666] Add support
   for user sa7an`` (<- this is of course fake issue :P).

|

So... If you are not one of **makbet's** maintainers - the rule **3** ^^ is
most likely for you :)

|

**Branch naming convention for github issues**


For better handling commits and issues we are recommending strict branch naming
convention. Please see the table below:

.. csv-table::
   :header: The github issue, Suggested branch name
   :delim: |

   `#2 <https://github.com/skaluzka/makbet/issues/2>`_ | users/sa7an/issues/2
   `#3 <https://github.com/skaluzka/makbet/issues/3>`_ | users/skaluzka/issues/3

|

**Closing github issues**


According to official github documentation
(https://help.github.com/en/github/managing-your-work-on-github/linking-a-pull-request-to-an-issue)
every created issue can be closed in a two ways:

#. Directly by commit with properly constructed commit message.
#. By pull request with special description.

In **makbet** project we are preferring the latter approach.

The pull request description for issue labeled with **bug** label sholud
contain **Fix #xxx** line, eg.: ``Fix #1234``.

For other issues the pull request description sholud contain **Resolve #xxx**
line, eg.: ``Resolve #3`` -> https://github.com/skaluzka/makbet/pull/6

To check all labels please go `here <https://github.com/skaluzka/makbet/labels>`_.
To check all pull requests please go `here <https://github.com/skaluzka/makbet/pulls>`__.

|

**Squashing the commits**


Sometimes it is better to squash several commits into a single one. It always
depends on the case. The final decision should be taken by project's maintainer
during merging phase.

|

**Merging the code**


Becasue of github signing issue (described here:
https://github.com/github/hub/issues/1241) it is recommended to merge
code locally not via github GUI.


.. The end

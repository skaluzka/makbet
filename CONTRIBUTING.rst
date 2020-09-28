Welcome to **makbet's** contribution guide!

|

Keep reading && have fun! :)

|

----

**Table of Contents**
---------------------

- | `Development model`_
- | `Commit types`_
- | `Branch naming convention for GitHub issues`_
- | `Closing GitHub issues`_
- | `Pull requests`_
- | `Squashing the commits`_
- | `Merging the code`_

|

**Development model**
---------------------

We are preferring so-called **fork** development model in **makbet** project.

For more about it please read official GitHub help pages:
`<https://help.github.com/en/github/getting-started-with-github/fork-a-repo>`_.

Main development branch is the **master** branch.  We are trying to keep the
linear history of commits, on that branch, as much as possible.

|

**Commit types**
----------------

To make development process simple and fast we are distinguish only **three**
type of commits in **makbet** project:

#. | Pure development commits - regular but small and reasonable updates,
     changes or enhancements including minor refactoring as well.  All of them
     can be submitted directly to **master** branch but they **must have**
     ``[DEV]`` subject in the commit message.  This rule is valid only for
      **makbet's** maintainers who are allowed to work on the **master** branch
     directly.
   | Examples:
   | `45df932 <https://github.com/skaluzka/makbet/commit/45df932>`_:
     ``[DEV] Remove all unused help() functions``
   | `631f41c <https://github.com/skaluzka/makbet/commit/631f41c>`_:
     ``[DEV] Improve internal summary csv targets``

#. | Fix and quick fix commits - various small and trivial corrections and fixes
     for all problems noticed during the regular development on the **master**
     branch (and not yet reported via any issue).  All of them **must have**
     ``[FIX]`` subject in the commit message.  This rule is valid only for
     **makbet's** maintainers who are allowed to work on the **master** branch
     directly.
   | Examples:
   | `29e9822 <https://github.com/skaluzka/makbet/commit/29e9822>`_:
     ``[FIX] Correct all issues reported by shellcheck``
   | `a4d6b35 <https://github.com/skaluzka/makbet/commit/a4d6b35>`_:
     ``[FIX] Replace "param" by "option"``

#. | Commits triggered by issues reported in GitHub - **makbet's** users are
     reporting bugs and requesting for new features using GitHub issues
     (https://github.com/skaluzka/makbet/issues).  All related commits **must**
     **have** properly constructed title in the commit message containing the
     number of the issue in square brackets.
   | Examples:
   | `cf593ea <https://github.com/skaluzka/makbet/commit/cf593ea>`_:
     ``[#5] Add README.rst file to examples/ dir``
   | `6a8464b <https://github.com/skaluzka/makbet/commit/6a8464b>`_:
     ``[#3] Add extended help target (make makbet-help)``

|

So... If you are not one of **makbet's** maintainers - the rule **3** ^^ is
most likely for you :)

|

**Branch naming convention for GitHub issues**
----------------------------------------------

For better handling commits and issues we are recommending strict branch naming
convention.  Please see the table below:

.. csv-table::
   :header: The GitHub issue, Suggested branch name
   :delim: |

   `#2 <https://github.com/skaluzka/makbet/issues/2>`_ | users/skaluzka/issues/2
   `#3 <https://github.com/skaluzka/makbet/issues/3>`_ | users/skaluzka/issues/3

|

**Closing GitHub issues**
-------------------------

According to official GitHub documentation
(https://help.github.com/en/github/managing-your-work-on-github/linking-a-pull-request-to-an-issue)
every created issue can be closed in a two ways:

#. Directly by commit with properly constructed commit message.
#. By pull request with special description.

|

**Pull requests**
-----------------

In **makbet** project we are preferring closing issues by pull requests.

#. | The pull request description for issue labeled with **bug** label should
     contain separate ``Fix #xxx.`` line.
   | Examples:
   | https://github.com/skaluzka/makbet/pull/25
   | https://github.com/skaluzka/makbet/pull/42

#. | For any other issues the pull request description should contain
     separate ``Resolve #xxx.`` line.
   | Examples:
   | https://github.com/skaluzka/makbet/pull/6
   | https://github.com/skaluzka/makbet/pull/23

| To see all pull requests please go
  `here <https://github.com/skaluzka/makbet/pulls>`__.
| To check all available labels please go
  `here <https://github.com/skaluzka/makbet/labels>`_.

|

**Squashing the commits**
-------------------------

Sometimes it is better to squash several commits into a single one.  It always
depends on the case.  The final decision should be taken by project's maintainer
during merging phase.

|

**Merging the code**
--------------------

Because of GitHub signing issue (described here:
https://github.com/github/hub/issues/1241) it is recommended to merge
code locally not via GitHub GUI.


.. End of file

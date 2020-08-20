# This is Makefile file for "01.dummy" example scenario.

#
# Include mandatory makbet.mk file.
#
ifndef MAKBET_PATH
  $(error MAKBET_PATH is not defined)
else
  include $(MAKBET_PATH)/makbet.mk
endif

#
# All global variables required by "01.dummy" scenario.
#

GENERIC_TASK_SCRIPT := $(MAKBET_PATH)/examples/01.dummy/tasks/generic-task.sh

#
# All tasks required to run "01.dummy" scenario.
#

#
# Task "INIT" - an entry point for "01.dummy" scenario.
#
$(eval $(call TASK_template, \
	INIT, "Entry point", \
))

$(eval $(call TASK_template, \
	task-A, "Run task-A", \
	INIT, \
	$(GENERIC_TASK_SCRIPT), 1 \
))

$(eval $(call TASK_template, \
	task-B1, "Run task-B1", \
	task-A, \
	$(GENERIC_TASK_SCRIPT), 1 \
))

$(eval $(call TASK_template, \
	task-B2, "Run task-B2", \
	task-A, \
	$(GENERIC_TASK_SCRIPT), 1 \
))

$(eval $(call TASK_template, \
	task-B3, "Run task-B3", \
	task-A, \
	$(GENERIC_TASK_SCRIPT), 1 \
))

$(eval $(call TASK_template, \
	task-B4, "Run task-B4", \
	task-A, \
	$(GENERIC_TASK_SCRIPT), 1 \
))

$(eval $(call TASK_template, \
	task-B5, "Run task-B5", \
	task-A, \
	$(GENERIC_TASK_SCRIPT), 1 \
))

$(eval $(call TASK_template, \
	task-C, "Checkpoint for task-B2 and task-B3", \
	task-B2 task-B3, \
	$(GENERIC_TASK_SCRIPT), 1 \
))

$(eval $(call TASK_template, \
	task-D, "Run task-D", \
	task-C, \
	$(GENERIC_TASK_SCRIPT), 1 \
))

$(eval $(call TASK_template, \
	task-E, "Checkpoint for task-B1 task-B4 task-B5 and task-D", \
	task-B1 task-B4 task-B5 task-D, \
	$(GENERIC_TASK_SCRIPT), 1 \
))

$(eval $(call TASK_template, \
	task-F, "Run task-F", \
	task-E, \
))

$(eval $(call TASK_template, \
	task-G, "Run task-G", \
	task-F, \
	$(GENERIC_TASK_SCRIPT), 1 \
))

#
# Task "all" - the ultimate goal for "01.dummy" scenario.
#
$(eval $(call TASK_template, \
	all, "Run task all", \
	task-F, \
))

# Note:
# Target ALL is defined as a regular makefile target which is also
# allowed, but all such targets will be not visible in automatically
# generated help message.  So in fact it can be treated as a poor
# implementation of hidden (secret) target.
.PHONY: ALL
ALL: task-F


# End of file

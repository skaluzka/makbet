# This is Makefile file for "..." scenario.

#
# Include mandatory makbet.mk file.
#
ifndef MAKBET_PATH
  $(error MAKBET_PATH is not defined)
else
  include $(MAKBET_PATH)/makbet.mk
endif

#
# All required global variables.
#

# ...

#
# All tasks required to run "..." scenario.
#

# Task @01-INIT - scenario's entry point.
$(eval $(call TASK_template, \
	@01-INIT, "Entry point", \
))

$(eval $(call TASK_template, \
	task-1, "Task 1 description", \
	@01-INIT, \
	TASK_CMD, \
		TASK_CMD_OPT_1 TASK_CMD_OPT_2 TASK_CMD_OPT_3 \
))

# Ultimate task for "..." scenario.
$(eval $(call TASK_template, \
	all, "Run task all", \
	task-F, \
))


# End of file

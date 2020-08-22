# This is Makefile file for "04.sleep" example scenario.

#
# Include mandatory makbet.mk file.
#
ifndef MAKBET_PATH
  $(error MAKBET_PATH is not defined)
else
  include $(MAKBET_PATH)/makbet.mk
  MAKBET_TASKS_DIR := $(MAKBET_PATH)/examples/lib/tasks
endif

#
# All tasks required to run "04.sleep" scenario.
#

#
# Task "@01-INIT" - an entry point for "04.sleep" scenario.
#
$(eval $(call TASK_template, \
	@01-INIT, "Entry point", \
))

$(eval $(call TASK_template, \
	sleep-10s, "Do nothing - just sleep for 10 seconds", \
	@01-INIT, \
	$(MAKBET_TASKS_DIR)/common/sleep.sh, 10s \
))

$(eval $(call TASK_template, \
	sleep-100s, "Do nothing - just sleep for 100 seconds", \
	@01-INIT, \
	$(MAKBET_TASKS_DIR)/common/sleep.sh, 100s \
))

$(eval $(call TASK_template, \
	sleep-1m, "Do nothing - just sleep for 1 minute", \
	@01-INIT, \
	sleep, 1m \
))

#
# Task "all" - the ultimate goal for "04.sleep" scenario.
#
$(eval $(call TASK_template, \
	all, "Run all sleep tasks", \
	sleep-10s sleep-100s sleep-1m, \
))


# End of file

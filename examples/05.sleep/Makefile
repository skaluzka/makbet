# This is Makefile file for "05.sleep" example scenario.

#
# Include mandatory makbet.mk file.
#
ifndef MAKBET_PATH
  $(error [ERROR]: MAKBET_PATH is not defined)
else
  include $(MAKBET_PATH)/makbet.mk
  MAKBET_TASKS_DIR := $(MAKBET_PATH)/examples/lib/tasks
endif

#
# All tasks required to run "05.sleep" scenario.
#

#
# Task "@01-INIT" - an entry point for "05.sleep" scenario.
#
$(eval $(call TASK_template, \
	@01-INIT, "Entry point", \
))

$(eval $(call TASK_template, \
	sleep-1s, "Do nothing - just sleep for 1 second", \
	@01-INIT, \
	$(MAKBET_TASKS_DIR)/common/delay, 1s \
))

$(eval $(call TASK_template, \
	sleep-2s, "Do nothing - just sleep for 2 seconds", \
	@01-INIT, \
	$(MAKBET_TASKS_DIR)/common/delay, 2s \
))

$(eval $(call TASK_template, \
	sleep-3s, "Do nothing - just sleep for 3 seconds", \
	@01-INIT, \
	sleep, 3s \
))

$(eval $(call TASK_template, \
	sleep-5s, "Do nothing - just sleep for 5 seconds", \
	@01-INIT, \
	sleep, 5s \
))

$(eval $(call TASK_template, \
	sleep-8s, "Do nothing - just sleep for 8 seconds", \
	@01-INIT, \
	sleep, 8s \
))

#
# Task "all" - the ultimate goal for "05.sleep" scenario.
#
$(eval $(call TASK_template, \
	all, "Run all sleep tasks", \
	sleep-1s sleep-2s sleep-3s sleep-5s sleep-8s, \
))


# EOF

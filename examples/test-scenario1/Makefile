# This is a test-scenario1 Makefile file.

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

GENERIC_TASK_SCRIPT := $(MAKBET_PATH)/examples/test-scenario1/tasks/generic-task.sh

#
# All tasks required to run scenario from test-scenario1/Makefile file.
#

.PHONY: scenario-help
scenario-help::
	@echo ""
	@echo "All targets defined in $(CURDIR)/$(firstword $(MAKEFILE_LIST)):"
	@echo ""

$(eval $(call TASK_template, \
	INIT, \
	, \
	, \
	\
))

$(eval $(call TASK_template, \
	task-A, \
	INIT, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	task-B1, \
	task-A, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	task-B2, \
	task-A, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	task-B3, \
	task-A, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	task-B4, \
	task-A, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	task-B5, \
	task-A, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	task-C, \
	task-B2 task-B3, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	task-D, \
	task-C, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	task-E, \
	task-B1 task-B4 task-B5 task-D, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	task-F, \
	task-E, \
	,, \
))

$(eval $(call TASK_template, \
	task-G, \
	task-F, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	all, \
	task-F, \
	,, \
))

# Note:
# Target ALL is defined as a regular makefile target which is also
# allowed, but all such targets will be not visible in automatically
# generated help message. So in fact it can be treated as a poor
# implementation of hidden (secret) target.
.PHONY: ALL
ALL: task-F


# The end

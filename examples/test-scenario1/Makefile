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

GENERIC_TASK_SCRIPT := $(MAKBET_PATH)/examples/test-scenario1/tasks/generic_task.sh

#
# All tasks required to run scenario from test-scenario1/Makefile file.
#

.PHONY: scenario-help
scenario-help::
	@echo ""
	@echo "All targets defined in $(CURDIR)/$(firstword $(MAKEFILE_LIST)):"
	@echo ""

$(eval $(call TASK_template, \
	t-A, \
	, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	t-B1, \
	t-A, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	t-B2, \
	t-A, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	t-B3, \
	t-A, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	t-B4, \
	t-A, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	t-B5, \
	t-A, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	t-C, \
	t-B2 t-B3, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	t-D, \
	t-C, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	t-E, \
	t-B1 t-B4 t-B5 t-D, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	t-F, \
	t-E, \
	,, \
))

$(eval $(call TASK_template, \
	t-G, \
	t-F, \
	$(GENERIC_TASK_SCRIPT), \
		1 \
))

$(eval $(call TASK_template, \
	all, \
	t-F, \
	,, \
))

# Note:
# Target ALL is defined as a regular makefile target which is also
# allowed, but all such targets will be not visible in automatically
# generated help message. So in fact it can be treated as a poor
# implementation of hidden (secret) target.
.PHONY: ALL
ALL: t-F


# The end

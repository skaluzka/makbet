# This is the core part of makbet - mak(efile) b(ased) e(xtraordinary) (t)ool.
# Do not change it unless you know what you are doing.
#
# "What's done, is done." - William Shakespeare, Macbeth.


#
# Checking MAKBET_PATH env variable.
#
ifndef MAKBET_PATH
  $(error MAKBET_PATH is not defined)
else
  MAKBET_LIB_DIR := $(MAKBET_PATH)/lib
  MAKBET_PLUGINS := $(MAKBET_LIB_DIR)/plugins
endif

#
# Handling makbet's version.
#
MAKBET_VERSION := $(shell git describe --all --long 2> /dev/null || cat $(MAKBET_PATH)/VERSION)


.DEFAULT_GOAL := help


#
# All internal makbet dirs.
#
MAKBET_DOT_DIR := $(MAKBET_PATH)/.makbet/dot
MAKBET_EVENTS_DIR := $(MAKBET_PATH)/.makbet/events
MAKBET_EVENTS_CFG_DIR := $(MAKBET_EVENTS_DIR)/cfg
MAKBET_EVENTS_CSV_DIR := $(MAKBET_EVENTS_DIR)/csv
MAKBET_PROFILES_DIR := $(MAKBET_PATH)/.makbet/profiles
MAKBET_PROFILES_CFG_DIR := $(MAKBET_PROFILES_DIR)/cfg
MAKBET_PROFILES_CSV_DIR := $(MAKBET_PROFILES_DIR)/csv

#
# Handling CLI input: MAKBET_VERBOSE param.
#
ifndef MAKBET_VERBOSE
  MAKBET_VERBOSE := 0
endif
ifeq ($(MAKBET_VERBOSE), 0)
  _v := 0
  _v1 := 0
  _v2 := @
else ifeq ($(MAKBET_VERBOSE), 1)
  _v := 1
  _v1 := 1
  _v2 := @
else ifeq ($(MAKBET_VERBOSE), 2)
  _v := 2
  _v1 := 1
  _v2 :=
else
  $(error [ERROR]: Wrong value for MAKBET_VERBOSE param (MAKBET_VERBOSE=$(MAKBET_VERBOSE)). Allowed values: 0, 1 or 2 only)
endif

#
# Handling CLI input: MAKBET_PROFILES param.
#
ifndef MAKBET_PROFILES
  MAKBET_PROFILES := 0
endif
ifeq ($(MAKBET_PROFILES), 0)
  _p := 0
else ifeq ($(MAKBET_PROFILES), 1)
  _p := 1
else
  $(error [ERROR]: Wrong value for MAKBET_PROFILES param (MAKBET_PROFILES=$(MAKBET_PROFILES)). Allowed values: 0 or 1 only)
endif

#
# Handling CLI input: MAKBET_DOT param.
#
ifndef MAKBET_DOT
  MAKBET_DOT := 0
endif
ifeq ($(MAKBET_DOT), 0)
  _d := 0
else ifeq ($(MAKBET_DOT), 1)
  _d := 1
else
  $(error [ERROR]: Wrong value for MAKBET_DOT param (MAKBET_DOT=$(MAKBET_DOT)). Allowed values: 0 or 1 only)
endif

#
# Handling CLI input: MAKBET_CSV, MAKBET_CSV_SEP, MAKBET_EVENTS_CSV_HEADER
# and MAKBET_PROFILES_CSV_HEADER params.
#
ifndef MAKBET_CSV
  MAKBET_CSV := 0
endif
ifeq ($(MAKBET_CSV), 0)
  _c := 0
  MAKBET_CSV_SEP :=
  MAKBET_EVENTS_CSV_HEADER :=
  MAKBET_PROFILES_CSV_HEADER :=
else ifeq ($(MAKBET_CSV), 1)
  _c := 1
  ifndef MAKBET_CSV_SEP
    MAKBET_CSV_SEP := ;
  endif
  ifndef MAKBET_EVENTS_CSV_HEADER
    MAKBET_EVENTS_CSV_HEADER := TASK_NAME;TASK_DEPS;TASK_SCRIPT;TASK_SCRIPT_PARAMS;TASK_DATE_TIME;TASK_EVENT_TYPE;TASK_[STARTED|TERMINATED]_EPOCH;
  endif
  ifndef MAKBET_PROFILES_CSV_HEADER
    MAKBET_PROFILES_CSV_HEADER := TASK_NAME;TASK_DEPS;TASK_SCRIPT;TASK_SCRIPT_PARAMS;TASK_STARTED_EPOCH;TASK_TERMINATED_EPOCH;TASK_DURATION_SECONDS;TASK_DURATION;
  endif
else
  $(error [ERROR]: Wrong value for MAKBET_CSV param (MAKBET_CSV=$(MAKBET_CSV)). Allowed values: 0 or 1 only)
endif

#
# Handling CLI input: MAKBET_DATE_TIME_FORMAT param.
#
ifndef MAKBET_DATE_TIME_FORMAT
  MAKBET_DATE_TIME_FORMAT := +"%Y-%m-%d %H:%M:%S"
endif

#
# Handling CLI input: MAKBET_TASKS_DIR param.
#
ifndef MAKBET_TASKS_DIR
  MAKBET_TASKS_DIR := $(MAKBET_LIB_DIR)/tasks
endif

#
# Create makbet's internals as soon as possible.
#
# .
# └── .makbet/
#     ├── dot/
#     ├── events/
#     │   ├── cfg/
#     │   └── csv/
#     └── profiles/
#         ├── cfg/
#         └── csv/
#
# Usually it means - as soon as makbet.mk file was successfully included
# and all provided CLI params were processed without any error.
#
$(shell mkdir -p $(MAKBET_DOT_DIR))
$(shell mkdir -p $(MAKBET_EVENTS_CFG_DIR))
$(shell mkdir -p $(MAKBET_EVENTS_CSV_DIR))
$(shell mkdir -p $(MAKBET_PROFILES_CFG_DIR))
$(shell mkdir -p $(MAKBET_PROFILES_CSV_DIR))

#
# If MAKBET_VERBOSE=1 then print some extra information once.
#
ifeq ($(_v1), 1)
  $(info )
  $(info File $(lastword $(MAKEFILE_LIST)) included successfully.)
  $(info )
  $(info Listing all makbet's global variables...)
  $(info )
  $(info MAKBET_VERSION = $(MAKBET_VERSION))
  $(info )
  $(info MAKBET_PATH = $(MAKBET_PATH))
  $(info )
  $(info MAKBET_LIB_DIR = $(MAKBET_LIB_DIR))
  $(info )
  $(info MAKBET_TASKS_DIR = $(MAKBET_TASKS_DIR))
  $(info )
  $(info MAKBET_PLUGINS_DIR = $(MAKBET_PLUGINS_DIR))
  $(info )
  $(info MAKBET_VERBOSE = $(MAKBET_VERBOSE))
  $(info )
  $(info MAKBET_DOT = $(MAKBET_DOT))
  $(info MAKBET_DOT_DIR = $(MAKBET_DOT_DIR))
  $(info )
  $(info MAKBET_CSV = $(MAKBET_CSV))
  $(info MAKBET_CSV_SEP = $(MAKBET_CSV_SEP))
  $(info )
  $(info MAKBET_PROFILES = $(MAKBET_PROFILES))
  $(info MAKBET_PROFILES_DIR = $(MAKBET_PROFILES_DIR))
  $(info MAKBET_PROFILES_CFG_DIR = $(MAKBET_PROFILES_CFG_DIR))
  $(info MAKBET_PROFILES_CSV_DIR = $(MAKBET_PROFILES_CSV_DIR))
  $(info MAKBET_PROFILES_CSV_HEADER = $(MAKBET_PROFILES_CSV_HEADER))
  $(info )
  $(info MAKBET_EVENTS_DIR = $(MAKBET_EVENTS_DIR))
  $(info MAKBET_EVENTS_CFG_DIR = $(MAKBET_EVENTS_CFG_DIR))
  $(info MAKBET_EVENTS_CSV_DIR = $(MAKBET_EVENTS_CSV_DIR))
  $(info MAKBET_EVENTS_CSV_HEADER = $(MAKBET_EVENTS_CSV_HEADER))
  $(info )
  $(info MAKBET_DATE_TIME_FORMAT = $(MAKBET_DATE_TIME_FORMAT))
  $(info )
endif

#
# Definition of __print_task_details macro.
#
# Where:
# $(1) - TASK_NAME - The name of the task.
# $(2) - TASK_DEPS - All task dendencies.
# $(3) - TASK_SCRIPT - Task script file.
# $(4) - TASK_SCRIPT_PARAMS - CLI params for TASK_SCRIPT above.
#
define __print_task_details =
	echo "TASK_NAME = $(strip $(1))" ; \
	echo "TASK_DEPS = $(strip $(2))" ; \
	echo "TASK_SCRIPT = $(strip $(3))" ; \
	echo "TASK_SCRIPT_PARAMS = $(strip $(4))"
endef

#
# Definition of __save_event macro.
#
# Where:
# $(1) - TASK_NAME - The name of the task.
# $(2) - TASK_DEPS - All task dendencies.
# $(3) - TASK_SCRIPT - Task script file.
# $(4) - TASK_SCRIPT_PARAMS - CLI params for TASK_SCRIPT above.
# $(5) - TASK_EVENT_FILE - Destination event file.
# $(6) - TASK_EVENT_TYPE - The type of the event (STARTED or TERMINATED).
#
define __save_event =
	$(_v2)echo -n "" > $(5)
	$(_v2)echo "TASK_NAME=\"$(strip $(1))\"" >> $(5)
	$(_v2)echo "TASK_DEPS=\"$(strip $(2))\"" >> $(5)
	$(_v2)echo "TASK_SCRIPT=\"$(strip $(3))\"" >> $(5)
	$(_v2)echo "TASK_SCRIPT_PARAMS=\"$(strip $(4))\"" >> $(5)
	$(_v2)echo "TASK_DATE_TIME=\"`date $(MAKBET_DATE_TIME_FORMAT)`\"" >> $(5)
	$(_v2)echo "TASK_EVENT_TYPE=\"$(strip $(6))\"" >> $(5)
	$(_v2)cmd="TIMESTAMP_EPOCH=$$$$(date +'%s')" && \
		eval $$$${cmd} && \
			echo "TASK_$(6)_EPOCH=\"$$$${TIMESTAMP_EPOCH}\"" >> $(5)
endef

#
# Definition of __save_task_profile macro.
#
# Where:
# $(1) - Path to T1 *.started.cfg event file.
# $(2) - Path to T2 *.terminated.cfg event file.
# $(3) - Path to .makbet/profiles/cfg/ dir.
#
define __save_task_profile =
	touch $(strip $(3)) ; \
	comm $(1) $(2) | grep -Pv "EVENT_TYPE|DATE_TIME" | sed 's/^[ \t]*//' > $(strip $(3)) ; \
	. $(1) && . $(2) && \
		cmd="T1=$$$${TASK_STARTED_EPOCH}" && \
			eval $$$${cmd} && \
				echo "T1 = $$$${T1}secs" && \
		cmd="T2=$$$${TASK_TERMINATED_EPOCH}" && \
			eval $$$${cmd} && \
				echo "T2 = $$$${T2}secs" && \
		cmd="TASK_DURATION_SECONDS=$$$$(($$$${T2} - $$$${T1}))" && \
			eval $$$${cmd} && \
		cmd="TASK_DURATION=$$$$(date +'%Hh:%Mm:%Ss' -ud @$$$${TASK_DURATION_SECONDS})" && \
			eval $$$${cmd} && \
				echo "T2 - T1 = $$$${TASK_DURATION} ($$$${TASK_DURATION_SECONDS}secs)" && \
		echo "TASK_DURATION_SECONDS=$$$${TASK_DURATION_SECONDS}" >> $(strip $(3)) && \
		echo "TASK_DURATION=$$$${TASK_DURATION}" >> $(strip $(3))
endef

#
# Definition of __convert_cfg2csv macro.
#
# Where:
# $(1) - Path to input cfg file.
# $(2) - Path to output csv file.
# $(3) - The csv header variable.
#
define __convert_cfg2csv =
	echo "$(strip $(3))" > $(2) ; \
	cat $(1) | cut -d "=" -f2 | tr "\n" "$(MAKBET_CSV_SEP)" >> $(2) ; \
	echo "" >> $(2)
endef

#
# Definition of __save_dot_file macro.
#
# Where:
# $(1) - Path to input cfg file.
# $(2) - Path to output dot file.
#
define __save_dot_file =
	touch $(strip $(2)) ; \
	. $(1) && \
		if [ -z "$$$${TASK_DEPS}" ] ; \
		then \
			cmd='echo -e "\t\"$$$${TASK_NAME}\";" >> $(strip $(2))' && \
				eval $$$${cmd} ; \
		else \
			cmd='for t in $$$${TASK_DEPS}; do echo -e "\t\"$$$${TASK_NAME}\" -> \"$$$${t}\";" >> $(strip $(2)) ; done' && \
				eval $$$${cmd} ; \
		fi
endef

#
# Definition of TASK_template macro.
#
# Where:
# $(1) - TASK_NAME - The name of the task.
# $(2) - TASK_DEPS - All task dependencies.
# $(3) - TASK_SCRIPT - Task script file.
# $(4) - TASK_SCRIPT_PARAMS - CLI params for TASK_SCRIPT above.
#
define TASK_template =

.PHONY: $(1)
$(1): $(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg $(foreach d,$(2),$(MAKBET_EVENTS_CFG_DIR)/$(d).terminated.cfg)

$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg: $(foreach d,$(2),$(MAKBET_EVENTS_CFG_DIR)/$(d).terminated.cfg)
	@#
	@#
	@# Printing additional information if MAKBET_VERBOSE=1 or MAKBET_VERBOSE=2.
	$(_v2)if (( $(_v) >= 1 )) ; \
	then \
		$(call __print_task_details,$(1),$(2),$(3),$(4)) ; \
	fi
	@#
	@# Saving STARTED event file in $(MAKBET_EVENTS_CFG_DIR) dir.
	$(call __save_event,$(1),$(2),$(3),$(4),$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).started.cfg,STARTED)
	@#
	@echo -e "\n`date $(MAKBET_DATE_TIME_FORMAT)` [INFO]: Task \"$(strip $(1))\" started."
	@#
	@# Running the TASK_SCRIPT with TASK_SCRIPT_PARAMS params.
	$(_v2)$(3) $(4)
	@#
	@# Saving TERMINATED event file in $(MAKBET_EVENTS_CFG_DIR) dir.
	$(call __save_event,$(1),$(2),$(3),$(4),$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg,TERMINATED)
	@#
	@echo -e "`date $(MAKBET_DATE_TIME_FORMAT)` [INFO]: Task \"$(strip $(1))\" terminated."
	@#
	@# Saving *.dot file in .makbet/dot/ dir if MAKBET_DOT=1.
	$(_v2)if (( $(_d) == 1 )) ; \
	then \
		$(call __save_dot_file,\
			$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg,\
			$(MAKBET_DOT_DIR)/$(strip $(1)).dot) ; \
	fi
	@#
	@# Computing time difference (task duration) if MAKBET_PROFILES=1.
	$(_v2)if (( $(_p) == 1 )) ; \
	then \
		$(call __save_task_profile,\
			$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).started.cfg,\
			$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg,\
			$(MAKBET_PROFILES_CFG_DIR)/$(strip $(1)).cfg) ; \
	fi
	@#
	@# Converting profile *.cfg file to -> profile *.csv file
	@# if MAKBET_CSV=1 and MAKBET_PROFILES=1.
	$(_v2)if (( $(_c) == 1 )) && (( $(_p) == 1 )); \
	then \
		$(call __convert_cfg2csv,\
			$(MAKBET_PROFILES_CFG_DIR)/$(strip $(1)).cfg,\
			$(MAKBET_PROFILES_CSV_DIR)/$(strip $(1)).csv,\
			$(MAKBET_PROFILES_CSV_HEADER)) ; \
	fi
	@#
	@# Converting *.started.cfg file to -> *.started.csv file
	@# if MAKBET_CSV=1.
	$(_v2)if (( $(_c) == 1 )) ; \
	then \
		$(call __convert_cfg2csv,\
			$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).started.cfg,\
			$(MAKBET_EVENTS_CSV_DIR)/$(strip $(1)).started.csv,\
			$(MAKBET_EVENTS_CSV_HEADER)) ; \
	fi
	@#
	@# Converting *.terminated.cfg file to -> *.terminated.csv file
	@# if MAKBET_CSV=1.
	$(_v2)if (( $(_c) == 1 )) ; \
	then \
		$(call __convert_cfg2csv,\
			$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg,\
			$(MAKBET_EVENTS_CSV_DIR)/$(strip $(1)).terminated.csv,\
			$(MAKBET_EVENTS_CSV_HEADER)) ; \
	fi

# Add entry to scenario-help target.
.PHONY: scenario-help
scenario-help::
	@echo -e "  $(strip $(1))\t- Call target $(strip $(1)) (deps: $(strip $(2)))"

# If MAKBET_VERBOSE=2 printing task's script path (if any) immediately
# after TASK_template macro evaluation.
$(if $(_v2),,
  $(if $(strip $(3)),\
    $(info [INFO]: Created task $(strip $(1)) <- $(strip $(3))),\
    $(info [INFO]: Created task $(strip $(1)) <- scriptless task)\
  )
)

endef


.PHONY: .show-makbet-dir
.show-makbet-dir:
	@-tree -apugsfF $(MAKBET_PATH)/.makbet


.PHONY: .show-dot-dir
.show-dot-dir:
	@-tree -apugsfF $(MAKBET_DOT_DIR)


.PHONY: .show-summary-dot-file
.show-summary-dot-file:
	@echo ""
	@echo "digraph {"
	@echo ""
	@cat $(MAKBET_DOT_DIR)/*.dot
	@echo ""
	@echo "}"
	@echo ""


.PHONY: .show-events-cfg-dir
.show-events-cfg-dir:
	@-tree -apugsfF $(MAKBET_EVENTS_CFG_DIR)


.PHONY: .show-events-csv-dir
.show-events-csv-dir:
	@-tree -apugsfF $(MAKBET_EVENTS_CSV_DIR)


.PHONY: .show-events-dir
.show-events-dir: .show-events-cfg-dir .show-events-csv-dir


.PHONY: .show-summary-events-csv-file
.show-summary-events-csv-file:
	@find $(MAKBET_EVENTS_CSV_DIR) -name "*.csv" -exec head -1 {} \; | sort -u
	@find $(MAKBET_EVENTS_CSV_DIR) -name "*.csv" -exec tail -1 {} \; | sort


.PHONY: .show-profiles-cfg-dir
.show-profiles-cfg-dir:
	@tree -apugsfF $(MAKBET_PROFILES_CFG_DIR)


PHONY: .show-profiles-csv-dir
.show-profiles-csv-dir:
	@tree -apugsfF $(MAKBET_PROFILES_CSV_DIR)


.PHONY: .show-profiles-dir
.show-profiles-dir: .show-profiles-cfg-dir .show-profiles-csv-dir


.PHONY: .show-summary-profiles-csv-file
.show-summary-profiles-csv-file:
	@find $(MAKBET_PROFILES_CSV_DIR) -name "*.csv" -exec head -1 {} \; | sort -u
	@find $(MAKBET_PROFILES_CSV_DIR) -name "*.csv" -exec tail -1 {} \; | sort


.PHONY: .show-env-vars
.show-env-vars:
	@echo "Listing all available MAKBET_* env variables:"
	@env | grep --color=never -P '^MAKBET_[0-9A-Z_]*='


.PHONY: makbet-clean
makbet-clean:
	@-rm -rf $(MAKBET_DOT_DIR)
	@-rm -rf $(MAKBET_EVENTS_DIR)
	@-rm -rf $(MAKBET_PROFILES_DIR)


.PHONY: makbet-version
makbet-version:
	@echo ""
	@echo "makbet version $(MAKBET_VERSION)                                              "
	@echo ""


.PHONY: makbet-help
makbet-help: main-help
	@echo ""
	@echo "All makbet's special targets defined in $(MAKBET_PATH)/makbet.mk:             "
	@echo ""
	@echo "  .show-makbet-dir                - Show entire content of makbet's internal  "
	@echo "                                    dir (\$$MAKBET_PATH/.makbet/).            "
	@echo "  .show-dot-dir                   - Show entire content of makbet's internal  "
	@echo "                                    \"dot\" dir (\$$MAKBET_PATH/.makbet/dot/)."
	@echo "                                    This target requires MAKBET_DOT=1.        "
	@echo "  .show-summary-dot-file          - Show the content of results dot file. This"
	@echo "                                    target requires MAKBET_DOT=1.             "
	@echo "  .show-events-dir                - Show entire content of makbet's           "
	@echo "                                    \$$MAKBET_PATH/.makbet/events/ internal   "
	@echo "                                    dir including all sub-dirs.               "
	@echo "  .show-events-cfg-dir            - Show entire content of makbet's           "
	@echo "                                    \$$MAKBET_PATH/.makbet/events/cfg/        "
	@echo "                                    internal dir.                             "
	@echo "  .show-events-csv-dir            - Show entire content of makbet's           "
	@echo "                                    \$$MAKBET_PATH/.makbet/events/csv/        "
	@echo "                                    internal dir. This target requires        "
	@echo "                                    MAKBET_CSV=1.                             "
	@echo "  .show-summary-events-csv-file   - Show the content of events summary csv    "
	@echo "                                    file. This target requires MAKBET_CSV=1.  "
	@echo "  .show-profiles-dir              - Show entire content of makbet's           "
	@echo "                                    \$$MAKBET_PATH/.makbet/profiles/ internal "
	@echo "                                    dir including all sub-dirs.               "
	@echo "  .show-profiles-cfg-dir          - Show entire content of makbet's           "
	@echo "                                    \$$MAKBET_PATH/.makbet/profiles/cfg/      "
	@echo "                                    internal dir. This target requires        "
	@echo "                                    MAKBET_PROFILES=1.                        "
	@echo "  .show-profiles-csv-dir          - Show entire content of makbet's           "
	@echo "                                    \$$MAKBET_PATH/.makbet/profiles/csv/      "
	@echo "                                    internal dir. This target requires        "
	@echo "                                    MAKBET_PROFILES=1 and MAKBET_CSV=1.       "
	@echo "  .show-summary-profiles-csv-file - Show the content of profiles summary csv  "
	@echo "                                    file. This target requires MAKBET_CSV=1   "
	@echo "                                    and MAKBET_PROFILES=1.                    "
	@echo "  .show-env-vars                  - Show all available MAKBET_* environment   "
	@echo "                                    variables.                                "
	@echo ""
	@echo "  Examples:                                                                   "
	@echo "           make .show-env-vars                                                "
	@echo "           make .show-makbet-dir                                              "
	@echo "           make .show-summary-profiles-csv-file MAKBET_CSV=1 MAKBET_PROFILES=1"
	@echo ""
	@exit 0


.PHONY: main-help
main-help: makbet-version
	@echo "  \"What's done, is done.\" - William Shakespeare, Macbeth.                   "
	@echo ""
	@echo "Usage: make [TARGET]                                                          "
	@echo ""
	@echo "All makbet's basic targets defined in $(MAKBET_PATH)/makbet.mk:               "
	@echo ""
	@echo "  help                            - Show main makbet's help message as first  "
	@echo "                                    then append the help messages of all tasks"
	@echo "                                    defined in scenario's Makefile. This is   "
	@echo "                                    the default target.                       "
	@echo "  scenario-help                   - Show only scenario's help message (it is  "
	@echo "                                    generated dynamically based on all tasks  "
	@echo "                                    defined in scenario's Makefile file).     "
	@echo "  makbet-help                     - Show main makbet's help message (same as  "
	@echo "                                    \"make help\" above) then append extended "
	@echo "                                    help message."
	@echo "                                    containing all special makbet's targets.  "
	@echo "  makbet-clean                    - Clean entire makbet's internal dir        "
	@echo "                                    (\$$MAKBET_PATH/.makbet/).                "
	@echo "  makbet-version                  - Print makbet's version only.              "
	@echo ""
	@echo "  Examples:                                                                   "
	@echo "           make                                                               "
	@echo "           make help                                                          "
	@echo "           make scenario-help                                                 "
	@echo "           make makbet-help                                                   "
	@echo "           make makbet-clean                                                  "
	@echo "           make makbet-version                                                "


# This is scenario-help target (the whole scenario-specific help message).
# If execution directory is MAKBET_PATH then the only allowed makefile at
# this level is Makefile -> makbet.mk symlink.
# Therefore scenario-help target is empty here. This is not valid in scenario's
# directory where help message will be generated dynamically based on all tasks
# defined in scenario's Makefile file.
.PHONY: scenario-help
scenario-help::
	@#


# This is makbet's main help target (see also the DEFAULT_GOAL at the top).
.PHONY: help
help: main-help scenario-help


# The end

# This file is a part of makbet - mak(efile) b(ased) e(xtraordinary) (t)ool.
# Do not change it, unless you know what you are doing.
#
# "What's done, is done." - William Shakespeare, Macbeth.


#
# Check MAKBET_PATH environment variable.
#
ifndef MAKBET_PATH
  $(error [ERROR]: MAKBET_PATH is not defined)
else
  # Set the SHELL variable as soon as MAKBET_PATH is defined.
  SHELL=/bin/bash

  MAKBET_CACHE_DIR := $(MAKBET_PATH)/.cache
  MAKBET_CORE_DIR := $(MAKBET_PATH)/core
  MAKBET_SCENARIO_PATH := $(realpath $(firstword $(MAKEFILE_LIST)))
endif

#
# Define default target for GNU make tool.  This target is made
# in case make command is run without options.
#
.DEFAULT_GOAL := help

#
# Task counter per scenario.
#
MAKBET_TASK_COUNTER := 0

#
# Count all valid tasks in scenario file.
#
MAKBET_TASK_TOTAL := $(shell \
  $(MAKBET_CORE_DIR)/__count_tasks $(MAKBET_SCENARIO_PATH) \
)

#
# Handle makbet's version.
#
MAKBET_VERSION := $(shell \
  $(MAKBET_CORE_DIR)/__get_makbet_version \
)

#
# Define all internal makbet dirs.
#
MAKBET_DOT_DIR := $(MAKBET_CACHE_DIR)/dot
MAKBET_EVENTS_DIR := $(MAKBET_CACHE_DIR)/events
MAKBET_EVENTS_CFG_DIR := $(MAKBET_EVENTS_DIR)/cfg
MAKBET_EVENTS_CSV_DIR := $(MAKBET_EVENTS_DIR)/csv
MAKBET_PROF_DIR := $(MAKBET_CACHE_DIR)/prof
MAKBET_PROF_CFG_DIR := $(MAKBET_PROF_DIR)/cfg
MAKBET_PROF_CSV_DIR := $(MAKBET_PROF_DIR)/csv

#
# Handle CLI input: MAKBET_VERBOSE option.
#
ifndef MAKBET_VERBOSE
  export MAKBET_VERBOSE := 0
endif
ifeq ($(MAKBET_VERBOSE), 0)
  _v := 0
  _v1 := 0
  _q := @
else ifeq ($(MAKBET_VERBOSE), 1)
  _v := 1
  _v1 := 1
  _q := @
else ifeq ($(MAKBET_VERBOSE), 2)
  _v := 2
  _v1 := 1
  _q :=
else
  $(error [ERROR]: Wrong input for MAKBET_VERBOSE option!  Expected value: {0|1|2} (found MAKBET_VERBOSE=$(MAKBET_VERBOSE)))
endif

#
# Handle CLI input: MAKBET_PROF option.
#
ifndef MAKBET_PROF
  MAKBET_PROF := 0
endif
ifeq ($(MAKBET_PROF), 0)
  _p := 0
else ifeq ($(MAKBET_PROF), 1)
  _p := 1
else
  $(error [ERROR]: Wrong input for MAKBET_PROF option!  Expected value: {0|1} (found MAKBET_PROF=$(MAKBET_PROF)))
endif

#
# Handle CLI input: MAKBET_DOT option.
#
ifndef MAKBET_DOT
  MAKBET_DOT := 0
endif
ifeq ($(MAKBET_DOT), 0)
  _d := 0
else ifeq ($(MAKBET_DOT), 1)
  _d := 1
else
  $(error [ERROR]: Wrong input for MAKBET_DOT option!  Expected value: {0|1} (found MAKBET_DOT=$(MAKBET_DOT)))
endif

#
# Handle CLI input: MAKBET_CSV, MAKBET_CSV_SEP, MAKBET_EVENTS_CSV_HEADER
# and MAKBET_PROF_CSV_HEADER options.
#
ifndef MAKBET_CSV
  MAKBET_CSV := 0
endif
ifeq ($(MAKBET_CSV), 0)
  _c := 0
  MAKBET_CSV_SEP :=
  MAKBET_EVENTS_CSV_HEADER :=
  MAKBET_PROF_CSV_HEADER :=
else ifeq ($(MAKBET_CSV), 1)
  _c := 1
  ifndef MAKBET_CSV_SEP
    MAKBET_CSV_SEP := ;
  endif
  ifndef MAKBET_EVENTS_CSV_HEADER
    MAKBET_EVENTS_CSV_HEADER := TASK_ID;TASK_NAME;TASK_DEPS;TASK_CMD;TASK_CMD_OPTS;TASK_EVENT_TYPE;TASK_DATE_TIME_[STARTED|TERMINATED];
  endif
  ifndef MAKBET_PROF_CSV_HEADER
    MAKBET_PROF_CSV_HEADER := TASK_ID;TASK_NAME;TASK_DEPS;TASK_CMD;TASK_CMD_OPTS;TASK_DATE_TIME_STARTED;TASK_DATE_TIME_TERMINATED;TASK_DURATION;
  endif
else
  $(error [ERROR]: Wrong input for MAKBET_CSV option!  Expected value: {0|1} (found MAKBET_CSV=$(MAKBET_CSV)))
endif

#
# Create makbet's internals dir structure as fast as possible.
#
# $MAKBET_PATH/
# └── .cache/
#     ├── dot/
#     ├── events/
#     │   ├── cfg/
#     │   └── csv/
#     └── prof/
#         ├── cfg/
#         └── csv/
#
# Usually it means - as soon as makbet.mk file was successfully included
# and all provided CLI options were processed without errors.
#
$(shell mkdir -p $(MAKBET_DOT_DIR))
$(shell mkdir -p $(MAKBET_EVENTS_CFG_DIR))
$(shell mkdir -p $(MAKBET_EVENTS_CSV_DIR))
$(shell mkdir -p $(MAKBET_PROF_CFG_DIR))
$(shell mkdir -p $(MAKBET_PROF_CSV_DIR))

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
  $(info MAKBET_CACHE_DIR = $(MAKBET_CACHE_DIR))
  $(info )
  $(info MAKBET_CORE_DIR = $(MAKBET_CORE_DIR))
  $(info )
  $(info MAKBET_SCENARIO_PATH = $(MAKBET_SCENARIO_PATH))
  $(info )
  $(info MAKBET_VERBOSE = $(MAKBET_VERBOSE))
  $(info )
  $(info MAKBET_DOT = $(MAKBET_DOT))
  $(info MAKBET_DOT_DIR = $(MAKBET_DOT_DIR))
  $(info )
  $(info MAKBET_CSV = $(MAKBET_CSV))
  $(info MAKBET_CSV_SEP = $(MAKBET_CSV_SEP))
  $(info )
  $(info MAKBET_PROF = $(MAKBET_PROF))
  $(info MAKBET_PROF_DIR = $(MAKBET_PROF_DIR))
  $(info MAKBET_PROF_CFG_DIR = $(MAKBET_PROF_CFG_DIR))
  $(info MAKBET_PROF_CSV_DIR = $(MAKBET_PROF_CSV_DIR))
  $(info MAKBET_PROF_CSV_HEADER = $(MAKBET_PROF_CSV_HEADER))
  $(info )
  $(info MAKBET_EVENTS_DIR = $(MAKBET_EVENTS_DIR))
  $(info MAKBET_EVENTS_CFG_DIR = $(MAKBET_EVENTS_CFG_DIR))
  $(info MAKBET_EVENTS_CSV_DIR = $(MAKBET_EVENTS_CSV_DIR))
  $(info MAKBET_EVENTS_CSV_HEADER = $(MAKBET_EVENTS_CSV_HEADER))
  $(info )
endif

#
# Definition of TASK_template macro.
#
# Where:
# $(1) - TASK_NAME - The name of the task.
# $(2) - TASK_DESCR - Task description string.
# $(3) - TASK_DEPS - All task dependencies.
# $(4) - TASK_CMD - Task command.
# $(5) - TASK_CMD_OPTS - Input options for TASK_CMD above.
#
define TASK_template =

# Increment the MAKBET_TASK_COUNTER variable.
$(eval MAKBET_TASK_COUNTER=$(shell echo $$(($(MAKBET_TASK_COUNTER)+1))))

.PHONY: $(1)
$(1): $(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg $(foreach d,$(3),$(MAKBET_EVENTS_CFG_DIR)/$(d).terminated.cfg)

$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg: $(foreach d,$(3),$(MAKBET_EVENTS_CFG_DIR)/$(d).terminated.cfg)
	@#
	@# Print additional information if MAKBET_VERBOSE=1 or MAKBET_VERBOSE=2.
	$(_q)if (( $(_v) >= 1 )) ; \
	then \
		$(MAKBET_CORE_DIR)/__print_task_details \
			"$(strip $(MAKBET_TASK_COUNTER))" \
			"$(strip $(1))" \
			"$(strip $(3))" \
			"$(strip $(4))" \
			"$(strip $(5))" ; \
	fi
	@#
	@# Save STARTED event file in $(MAKBET_EVENTS_CFG_DIR) dir.
	$(_q)$(MAKBET_CORE_DIR)/__save_task_event \
		"$(strip $(MAKBET_TASK_COUNTER))" \
		"$(strip $(1))" \
		"$(strip $(3))" \
		"$(strip $(4))" \
		"$(strip $(5))" \
		"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).started.cfg" \
		"STARTED"
	@#
	@# Run the TASK_CMD with TASK_CMD_OPTS input options.
	$(_q)$(4) $(5)
	@#
	@# Save TERMINATED event file in $(MAKBET_EVENTS_CFG_DIR) dir.
	$(_q)$(MAKBET_CORE_DIR)/__save_task_event \
		"$(strip $(MAKBET_TASK_COUNTER))" \
		"$(strip $(1))" \
		"$(strip $(3))" \
		"$(strip $(4))" \
		"$(strip $(5))" \
		"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg" \
		"TERMINATED"
	@#
	@# Save *.dot file in .cache/dot/ dir if MAKBET_DOT=1.
	$(_q)if (( $(_d) == 1 )) ; \
	then \
		$(MAKBET_CORE_DIR)/__save_dot_file \
			"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg" \
			"$(MAKBET_DOT_DIR)/$(strip $(1)).dot" ; \
	fi
	@#
	@# Compute time difference (task duration) if MAKBET_PROF=1.
	$(_q)if (( $(_p) == 1 )) ; \
	then \
		$(MAKBET_CORE_DIR)/__save_task_profile \
			"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).started.cfg" \
			"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg" \
			"$(MAKBET_PROF_CFG_DIR)/$(strip $(1)).cfg" ; \
	fi
	@#
	@# Convert profile *.cfg file to -> profile *.csv file
	@# if MAKBET_CSV=1 and MAKBET_PROF=1.
	$(_q)if (( $(_c) == 1 )) && (( $(_p) == 1 )); \
	then \
		$(MAKBET_CORE_DIR)/__convert_cfg2csv \
			"$(MAKBET_PROF_CFG_DIR)/$(strip $(1)).cfg" \
			"$(MAKBET_PROF_CSV_DIR)/$(strip $(1)).csv" \
			"$(MAKBET_PROF_CSV_HEADER)" \
			"$(MAKBET_CSV_SEP)" ; \
	fi
	@#
	@# Convert *.started.cfg file to -> *.started.csv file
	@# if MAKBET_CSV=1.
	$(_q)if (( $(_c) == 1 )) ; \
	then \
		$(MAKBET_CORE_DIR)/__convert_cfg2csv \
			"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).started.cfg" \
			"$(MAKBET_EVENTS_CSV_DIR)/$(strip $(1)).started.csv" \
			"$(MAKBET_EVENTS_CSV_HEADER)" \
			"$(MAKBET_CSV_SEP)" ; \
	fi
	@#
	@# Convert *.terminated.cfg file to -> *.terminated.csv file
	@# if MAKBET_CSV=1.
	$(_q)if (( $(_c) == 1 )) ; \
	then \
		$(MAKBET_CORE_DIR)/__convert_cfg2csv \
			"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg" \
			"$(MAKBET_EVENTS_CSV_DIR)/$(strip $(1)).terminated.csv" \
			"$(MAKBET_EVENTS_CSV_HEADER)" \
			"$(MAKBET_CSV_SEP)" ; \
	fi

# Add entry to scenario-help target.
.PHONY: scenario-help
scenario-help::
	@echo '  $(strip $(1))'
	@echo '    - Id.:   $(MAKBET_TASK_COUNTER)'
	@echo '    - Descr: $(strip $(2))'
	@echo '    - Deps:  $(strip $(3))'
	@echo '    - Cmd:   $(strip $(4))'
	@echo '    - Opts:  $(strip $(5))'
	@echo ''

# If MAKBET_VERBOSE=2 print task's command path (if any) immediately
# after TASK_template macro evaluation.
$(if $(_q),,
  $(if $(strip $(4)), \
    $(info [INFO]: Created task $(strip $(1)) <- $(strip $(4))), \
    $(info [INFO]: Created task $(strip $(1)) <- empty task) \
  )
)

endef


.PHONY: .show-cache-dir
.show-cache-dir:
	@-tree -apugsfF $(MAKBET_CACHE_DIR)


.PHONY: .show-dot-dir
.show-dot-dir:
	@-tree -apugsfF $(MAKBET_DOT_DIR)


.PHONY: .show-merged-dot-results
.show-merged-dot-results:
	@echo ""
	@echo "digraph {"
	@echo ""
	@echo  "// This file has been generated by makbet $(MAKBET_VERSION)"
	@echo  "// Generation date: $$(date)"
	@echo  "// Scenario file: $(MAKBET_SCENARIO_PATH)"
	@echo ""
	@echo "// Graph title."
	@echo "labelloc=\"t\";"
	@echo "label=\"Scenario file: $(MAKBET_SCENARIO_PATH)\\n\\n\\n\\n\";"
	@echo ""
	@echo "// Node options."
	@echo "node [shape=box];"
	@echo ""
	@cat $(MAKBET_DOT_DIR)/*.dot
	@echo ""
	@echo "}"
	@echo ""
	@echo ""
	@echo "// End of file"
	@echo ""


.PHONY: .show-events-cfg-dir
.show-events-cfg-dir:
	@-tree -apugsfF $(MAKBET_EVENTS_CFG_DIR)


.PHONY: .show-events-csv-dir
.show-events-csv-dir:
	@-tree -apugsfF $(MAKBET_EVENTS_CSV_DIR)


.PHONY: .show-events-dir
.show-events-dir: .show-events-cfg-dir .show-events-csv-dir


.PHONY: .show-merged-csv-events
.show-merged-csv-events:
	@find $(MAKBET_EVENTS_CSV_DIR) -name "*.csv" -exec head -1 {} \; | sort -u
	@find $(MAKBET_EVENTS_CSV_DIR) -name "*.csv" -exec tail -1 {} \; | sort
	@echo ""


.PHONY: .show-prof-cfg-dir
.show-prof-cfg-dir:
	@tree -apugsfF $(MAKBET_PROF_CFG_DIR)


.PHONY: .show-prof-csv-dir
.show-prof-csv-dir:
	@tree -apugsfF $(MAKBET_PROF_CSV_DIR)


.PHONY: .show-prof-dir
.show-prof-dir: .show-prof-cfg-dir .show-prof-csv-dir


.PHONY: .show-merged-csv-profiles
.show-merged-csv-profiles:
	@find $(MAKBET_PROF_CSV_DIR) -name "*.csv" -exec head -1 {} \; | sort -u
	@find $(MAKBET_PROF_CSV_DIR) -name "*.csv" -exec tail -1 {} \; | sort
	@echo ""


.PHONY: .show-env-vars
.show-env-vars:
	@echo "All MAKBET_* env vars available during processing makbet.mk file:"
	@env | grep --color=never -P '^MAKBET_[0-9A-Z_]*=' | sort


.PHONY: makbet-clean
makbet-clean:
	@-rm -rf $(MAKBET_DOT_DIR)
	@-rm -rf $(MAKBET_EVENTS_DIR)
	@-rm -rf $(MAKBET_PROF_DIR)


.PHONY: makbet-version
makbet-version:
	@echo ""
	@echo "makbet $(MAKBET_VERSION)                                                      "
	@echo ""


.PHONY: makbet-help
makbet-help: main-help
	@echo ""
	@echo "All makbet's special targets defined in $(MAKBET_PATH)/makbet.mk:             "
	@echo ""
	@echo "    .show-cache-dir              - Show entire content of makbet's internal   "
	@echo "                                   \".cache/\" dir.                           "
	@echo "    .show-dot-dir                - Show entire content of makbet's internal   "
	@echo "                                   \".cache/dot/\" dir (this target requires  "
	@echo "                                   prior MAKBET_DOT=1 usage).                 "
	@echo "    .show-merged-dot-results     - Show merged content of all dot files (this "
	@echo "                                   target requires prior MAKBET_DOT=1 usage). "
	@echo "    .show-events-dir             - Show entire content of makbet's internal   "
	@echo "                                   \".cache/events/\" dir including all       "
	@echo "                                   sub-dirs.                                  "
	@echo "    .show-events-cfg-dir         - Show entire content of makbet's internal   "
	@echo "                                   \".cache/events/cfg/\" dir.                "
	@echo "    .show-events-csv-dir         - Show entire content of makbet's internal   "
	@echo "                                   \".cache/events/csv/\" dir (this target    "
	@echo "                                   requires prior MAKBET_CSV=1 usage).        "
	@echo "    .show-merged-csv-events      - Show merged content of all event csv files "
	@echo "                                   (this target requires prior MAKBET_CSV=1   "
	@echo "                                   usage).                                    "
	@echo "    .show-prof-dir               - Show entire content of makbet's internal   "
	@echo "                                   \".cache/prof/\" dir including all         "
	@echo "                                   sub-dirs.                                  "
	@echo "    .show-prof-cfg-dir           - Show entire content of makbet's internal   "
	@echo "                                   \".cache/prof/cfg/\" dir (this target      "
	@echo "                                   requires prior MAKBET_PROF=1 usage).       "
	@echo "    .show-prof-csv-dir           - Show entire content of makbet's internal   "
	@echo "                                   \".cache/prof/csv/\" dir (this target      "
	@echo "                                   requires prior MAKBET_PROF=1 and           "
	@echo "                                   MAKBET_CSV=1 usage).                       "
	@echo "    .show-merged-csv-profiles    - Show merged content of all profile csv     "
	@echo "                                   files (this target requires prior          "
	@echo "                                   MAKBET_CSV=1 and MAKBET_PROF=1 usage).     "
	@echo "    .show-env-vars               - Show all MAKBET_* environment variables    "
	@echo "                                   available during processing makbet.mk file."
	@echo ""
	@echo "Mandatory variables:                                                          "
	@echo ""
	@echo "    MAKBET_PATH                  - Mandatory env variable which is required by"
	@echo "                                   makbet.mk file.  It should point to main   "
	@echo "                                   makbet's directory (the directory where the"
	@echo "                                   makbet.mk file is stored).                 "
	@echo ""
	@echo "Optional variables:                                                           "
	@echo ""
	@echo "    MAKBET_VERBOSE               - Optional cli/env variable for controlling  "
	@echo "                                   verbosity.  Allowed value: 0 or 1 or 2.    "
	@echo "                                   The default value is 0.                    "
	@echo "    MAKBET_DOT                   - Optional cli/env variable for enabling (1) "
	@echo "                                   or disabling (0) dot files generation.     "
	@echo "                                   Allowed value: 0 or 1.  The default value  "
	@echo "                                   is 0.  For more details please see         "
	@echo "                                   description of \".show-merged-dot-results\""
	@echo "                                   and \".show-dot-dir\" targets above.       "
	@echo "    MAKBET_CSV                   - Optional cli/env variable for enabling (1) "
	@echo "                                   or disabling (0) csv files generation.     "
	@echo "                                   Allowed value: 0 or 1.  The default value  "
	@echo "                                   is 0.  For more details please see         "
	@echo "                                   description of \".show-events-csv-dir\",   "
	@echo "                                   \".show-merged-csv-events\", and           "
	@echo "                                   \".show-prof-csv-dir\" targets above.      "
	@echo "    MAKBET_PROF                  - Optional cli/env variable for enabling (1) "
	@echo "                                   or disabling (0) profile files generation. "
	@echo "                                   Allowed value: 0 or 1.  The default value  "
	@echo "                                   is 0.  For more details please see         "
	@echo "                                   description of \".show-prof-dir\",         "
	@echo "                                   \".show-merged-csv-profiles\",             "
	@echo "                                   \".show-prof-cfg-dir\", and                "
	@echo "                                   \".show-prof-csv-dir\" targets above.      "
	@echo ""
	@echo "Examples:                                                                     "
	@echo ""
	@echo "    make .show-env-vars                                                       "
	@echo "    make .show-cache-dir                                                      "
	@echo "    make .show-merged-csv-profiles MAKBET_CSV=1 MAKBET_PROF=1                 "
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
	@echo "    help                         - Show main makbet's help message as first   "
	@echo "                                   then append the help messages of all tasks "
	@echo "                                   defined in scenario's Makefile.  This is   "
	@echo "                                   the default target.                        "
	@echo "    scenario-help                - Show only scenario's help message (it is   "
	@echo "                                   generated dynamically based on all tasks   "
	@echo "                                   defined in scenario's Makefile file).      "
	@echo "    makbet-help                  - Show main makbet's help message (same as   "
	@echo "                                   \"make help\" above) then append extended  "
	@echo "                                   help message containing the list of all    "
	@echo "                                   special makbet's targets.                  "
	@echo "    makbet-clean                 - Clean entire makbet's internal \".cache/\" "
	@echo "                                   dir.                                       "
	@echo "    makbet-version               - Print makbet's version only.               "
	@echo ""
	@echo "Examples:                                                                     "
	@echo ""
	@echo "    make                                                                      "
	@echo "    make help                                                                 "
	@echo "    make scenario-help                                                        "
	@echo "    make makbet-help                                                          "
	@echo "    make makbet-clean                                                         "
	@echo "    make makbet-version                                                       "


# This is scenario-help target which generates the whole scenario-specific
# help message.  If makbet.mk file (or symbolic link Makefile -> makbet.mk)
# will be passed as make input file then below scenario-help target will
# produce an empty output.  This is not valid for any other properly
# constructed makbet's scenario file.  For all such cases the help message
# will be generated dynamically based on all tasks defined in scenario's
# Makefile file.
.PHONY: scenario-help
scenario-help::
	@if [ "$(notdir $(MAKBET_SCENARIO_PATH))" != "makbet.mk" ] ; \
	then \
		if [ "$(MAKBET_TASK_TOTAL)" -gt "0" ] ; \
		then \
			echo "" ; \
			echo "Found $(MAKBET_TASK_TOTAL) valid task(s) defined in $(MAKBET_SCENARIO_PATH):" ; \
			echo "" ; \
		fi ; \
	fi


# This is makbet's default help target (see also the DEFAULT_GOAL at the top).
.PHONY: help
help: main-help scenario-help


# End of file

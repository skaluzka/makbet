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
  MAKBET_CACHE_DIR := $(MAKBET_PATH)/.cache
  MAKBET_CORE_DIR := $(MAKBET_PATH)/core
endif

#
# Default target.  This target will be called if make command will
# be invoked with no options.
#
.DEFAULT_GOAL := help

#
# Task counter per scenario.
#
MAKBET_TASK_COUNTER := 0

#
# Total task counter per scenario.
#
MAKBET_TASK_TOTAL := $(shell \
  grep -c TASK_template $(realpath $(firstword $(MAKEFILE_LIST))) \
)

#
# Handling makbet's version.
#
MAKBET_VERSION := $(shell $(MAKBET_CORE_DIR)/__get_makbet_version)

#
# All internal makbet dirs.
#
MAKBET_DOT_DIR := $(MAKBET_CACHE_DIR)/dot
MAKBET_EVENTS_DIR := $(MAKBET_CACHE_DIR)/events
MAKBET_EVENTS_CFG_DIR := $(MAKBET_EVENTS_DIR)/cfg
MAKBET_EVENTS_CSV_DIR := $(MAKBET_EVENTS_DIR)/csv
MAKBET_PROF_DIR := $(MAKBET_CACHE_DIR)/prof
MAKBET_PROF_CFG_DIR := $(MAKBET_PROF_DIR)/cfg
MAKBET_PROF_CSV_DIR := $(MAKBET_PROF_DIR)/csv

#
# Handling CLI input: MAKBET_VERBOSE option.
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
  $(error [ERROR]: Wrong value for MAKBET_VERBOSE option (MAKBET_VERBOSE=$(MAKBET_VERBOSE)).  Allowed values: 0, 1 or 2 only)
endif

#
# Handling CLI input: MAKBET_PROF option.
#
ifndef MAKBET_PROF
  MAKBET_PROF := 0
endif
ifeq ($(MAKBET_PROF), 0)
  _p := 0
else ifeq ($(MAKBET_PROF), 1)
  _p := 1
else
  $(error [ERROR]: Wrong value for MAKBET_PROF option (MAKBET_PROF=$(MAKBET_PROF)).  Allowed values: 0 or 1 only)
endif

#
# Handling CLI input: MAKBET_DOT option.
#
ifndef MAKBET_DOT
  MAKBET_DOT := 0
endif
ifeq ($(MAKBET_DOT), 0)
  _d := 0
else ifeq ($(MAKBET_DOT), 1)
  _d := 1
else
  $(error [ERROR]: Wrong value for MAKBET_DOT option (MAKBET_DOT=$(MAKBET_DOT)).  Allowed values: 0 or 1 only)
endif

#
# Handling CLI input: MAKBET_CSV, MAKBET_CSV_SEP, MAKBET_EVENTS_CSV_HEADER
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
  $(error [ERROR]: Wrong value for MAKBET_CSV option (MAKBET_CSV=$(MAKBET_CSV)).  Allowed values: 0 or 1 only)
endif

#
# Create makbet's internals as fast as possible.
#
# .
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
# and all provided CLI options were processed without any error.
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

# Incrementing the MAKBET_TASK_COUNTER variable.
$(eval MAKBET_TASK_COUNTER=$(shell echo $$(($(MAKBET_TASK_COUNTER)+1))))

.PHONY: $(1)
$(1): $(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg $(foreach d,$(3),$(MAKBET_EVENTS_CFG_DIR)/$(d).terminated.cfg)

$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg: $(foreach d,$(3),$(MAKBET_EVENTS_CFG_DIR)/$(d).terminated.cfg)
	@#
	@# Printing additional information if MAKBET_VERBOSE=1 or MAKBET_VERBOSE=2.
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
	@# Saving STARTED event file in $(MAKBET_EVENTS_CFG_DIR) dir.
	$(_q)$(MAKBET_CORE_DIR)/__save_task_event \
		"$(strip $(MAKBET_TASK_COUNTER))" \
		"$(strip $(1))" \
		"$(strip $(3))" \
		"$(strip $(4))" \
		"$(strip $(5))" \
		"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).started.cfg" \
		"STARTED" ;
	@#
	@# Running the TASK_CMD with TASK_CMD_OPTS input options.
	$(_q)$(4) $(5)
	@#
	@# Saving TERMINATED event file in $(MAKBET_EVENTS_CFG_DIR) dir.
	$(_q)$(MAKBET_CORE_DIR)/__save_task_event \
		"$(strip $(MAKBET_TASK_COUNTER))" \
		"$(strip $(1))" \
		"$(strip $(3))" \
		"$(strip $(4))" \
		"$(strip $(5))" \
		"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg" \
		"TERMINATED" ;
	@#
	@# Saving *.dot file in .cache/dot/ dir if MAKBET_DOT=1.
	$(_q)if (( $(_d) == 1 )) ; \
	then \
		$(MAKBET_CORE_DIR)/__save_dot_file \
			"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg" \
			"$(MAKBET_DOT_DIR)/$(strip $(1)).dot" ; \
	fi
	@#
	@# Computing time difference (task duration) if MAKBET_PROF=1.
	$(_q)if (( $(_p) == 1 )) ; \
	then \
		$(MAKBET_CORE_DIR)/__save_task_profile \
			"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).started.cfg" \
			"$(MAKBET_EVENTS_CFG_DIR)/$(strip $(1)).terminated.cfg" \
			"$(MAKBET_PROF_CFG_DIR)/$(strip $(1)).cfg" ; \
	fi
	@#
	@# Converting profile *.cfg file to -> profile *.csv file
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
	@# Converting *.started.cfg file to -> *.started.csv file
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
	@# Converting *.terminated.cfg file to -> *.terminated.csv file
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

# If MAKBET_VERBOSE=2 printing task's command path (if any) immediately
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


.PHONY: .show-summary-dot-file
.show-summary-dot-file:
	@echo ""
	@echo "digraph {"
	@echo ""
	@echo  "// This file has been generated by makbet $(MAKBET_VERSION)"
	@echo  "// Generation date: $$(date)"
	@echo  "// Input: $(realpath $(firstword $(MAKEFILE_LIST)))"
	@echo ""
	@echo "// Graph title."
	@echo "labelloc=\"t\";"
	@echo "label=\"$(realpath $(firstword $(MAKEFILE_LIST)))\\n\\n\"";
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


.PHONY: .show-summary-events-csv-file
.show-summary-events-csv-file:
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


.PHONY: .show-summary-prof-csv-file
.show-summary-prof-csv-file:
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
	@echo "  .show-cache-dir                - Show entire content of makbet's internal   "
	@echo "                                   cache dir (\$$MAKBET_CACHE_DIR).           "
	@echo "  .show-dot-dir                  - Show entire content of makbet's internal   "
	@echo "                                   \"dot\" dir (\$$MAKBET_DOT_DIR).  This     "
	@echo "                                   target requires MAKBET_DOT=1.              "
	@echo "  .show-summary-dot-file         - Show the content of results dot file.      "
	@echo "                                   This target requires MAKBET_DOT=1.         "
	@echo "  .show-events-dir               - Show entire content of makbet's internal   "
	@echo "                                   \"events\" dir (\$$MAKBET_EVENTS_DIR)      "
	@echo "                                   including all sub-dirs.                    "
	@echo "  .show-events-cfg-dir           - Show entire content of makbet's internal   "
	@echo "                                   \"events/cfg\" (\$$MAKBET_EVENTS_CFG_DIR)  "
	@echo "                                   dir.                                       "
	@echo "  .show-events-csv-dir           - Show entire content of makbet's internal   "
	@echo "                                   \"events/csv\" (\$$MAKBET_EVENTS_CSV_DIR)  "
	@echo "                                   dir.  This target requires MAKBET_CSV=1.   "
	@echo "  .show-summary-events-csv-file  - Show the content of events summary csv     "
	@echo "                                   file.  This target requires MAKBET_CSV=1.  "
	@echo "  .show-prof-dir                 - Show entire content of makbet's internal   "
	@echo "                                   \"prof\" dir (\$$MAKBET_PROF_DIR) including"
	@echo "                                   all sub-dirs.                              "
	@echo "  .show-prof-cfg-dir             - Show entire content of makbet's internal   "
	@echo "                                   \"prof/cfg\" dir (\$$MAKBET_PROF_CFG_DIR). "
	@echo "                                   This target requires MAKBET_PROF=1.        "
	@echo "  .show-prof-csv-dir             - Show entire content of makbet's internal   "
	@echo "                                   \"prof/csv\" dir (\$$MAKBET_PROF_CSV_DIR). "
	@echo "                                   This target requires MAKBET_PROF=1 and     "
	@echo "                                   MAKBET_CSV=1.                              "
	@echo "  .show-summary-prof-csv-file    - Show the content of prof summary csv file. "
	@echo "                                   This target requires MAKBET_CSV=1 and      "
	@echo "                                   MAKBET_PROF=1.                             "
	@echo "  .show-env-vars                 - Show all MAKBET_* environment variables    "
	@echo "                                   available during processing makbet.mk file."
	@echo ""
	@echo "  Examples:                                                                   "
	@echo "           make .show-env-vars                                                "
	@echo "           make .show-cache-dir                                               "
	@echo "           make .show-summary-prof-csv-file MAKBET_CSV=1 MAKBET_PROF=1        "
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
	@echo "  help                           - Show main makbet's help message as first   "
	@echo "                                   then append the help messages of all tasks "
	@echo "                                   defined in scenario's Makefile.  This is   "
	@echo "                                   the default target.                        "
	@echo "  scenario-help                  - Show only scenario's help message (it is   "
	@echo "                                   generated dynamically based on all tasks   "
	@echo "                                   defined in scenario's Makefile file).      "
	@echo "  makbet-help                    - Show main makbet's help message (same as   "
	@echo "                                   \"make help\" above) then append extended  "
	@echo "                                   help message containing the list of all    "
	@echo "                                   special makbet's targets.                  "
	@echo "  makbet-clean                   - Clean entire makbet's internal cache dir   "
	@echo "                                   (\$$MAKBET_CACHE_DIR).                     "
	@echo "  makbet-version                 - Print makbet's version only.               "
	@echo ""
	@echo "  Examples:                                                                   "
	@echo "           make                                                               "
	@echo "           make help                                                          "
	@echo "           make scenario-help                                                 "
	@echo "           make makbet-help                                                   "
	@echo "           make makbet-clean                                                  "
	@echo "           make makbet-version                                                "


# This is scenario-help target which generates the whole scenario-specific
# help message.  If makbet.mk file (or symbolic link Makefile -> makbet.mk)
# will be passed as make input file then below scenario-help target will
# produce an empty output.  This is not valid for any other properly
# constructed makbet's scenario file.  For all such cases the help message
# will be generated dynamically based on all tasks defined in scenario's
# Makefile file.
.PHONY: scenario-help
scenario-help::
	@echo ""
	@if [ "$(notdir $(realpath $(firstword $(MAKEFILE_LIST))))" != "makbet.mk" ] ; \
	then \
		echo "All targets ($(MAKBET_TASK_TOTAL)) defined in $(realpath $(firstword $(MAKEFILE_LIST))):" ; \
	fi
	@echo ""


# This is makbet's main help target (see also the DEFAULT_GOAL at the top).
.PHONY: help
help: main-help scenario-help


# End of file

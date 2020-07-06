# This is a toolchain/advanced/Makefile file.

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

WORK_DIR := /tmp/makbet/examples/toolchain/advanced

DOXYGEN_DIR := $(WORK_DIR)/doxygen
GIT_DIR := $(WORK_DIR)/git
KCOV_DIR := $(WORK_DIR)/kcov
MAKE_DIR := $(WORK_DIR)/make
PYTHON_DIR := $(WORK_DIR)/python

DOXYGEN_VER := Release_1_8_18.zip
GIT_VER := v2.27.0.zip
KCOV_VER := 38.zip
MAKE_VER := make-4.3.tar.gz
PYTHON_VER := Python-3.9.0b4.tar.xz

DOXYGEN_ZIP := $(DOXYGEN_DIR)/$(DOXYGEN_VER)
GIT_ZIP := $(GIT_DIR)/$(GIT_VER)
KCOV_ZIP := $(KCOV_DIR)/$(KCOV_VER)
MAKE_TGZ := $(MAKE_DIR)/$(MAKE_VER)
PYTHON_TXZ := $(PYTHON_DIR)/$(PYTHON_VER)

GITHUB_URL := https://github.com

DOXYGEN_URL := $(GITHUB_URL)/doxygen/doxygen/archive/$(DOXYGEN_VER)
GIT_URL := $(GITHUB_URL)/git/git/archive/$(GIT_VER)
KCOV_URL := $(GITHUB_URL)/SimonKagstrom/kcov/archive/$(KCOV_VER)
MAKE_URL := http://ftp.gnu.org/gnu/make/$(MAKE_VER)
PYTHON_URL := https://www.python.org/ftp/python/3.9.0/$(PYTHON_VER)

CREATE_DIRS := $(MAKBET_TASKS_DIR)/common/create-dir-structure.sh
DOWNLOAD := $(MAKBET_TASKS_DIR)/common/download-file.sh
UNPACK_ZIP := $(MAKBET_TASKS_DIR)/common/uncompress-zip-file.sh
UNPACK_TGZ := $(MAKBET_TASKS_DIR)/common/uncompress-tgz-file.sh
UNPACK_TXZ := $(MAKBET_TASKS_DIR)/common/uncompress-txz-file.sh
CHECK_DIRS := $(MAKBET_TASKS_DIR)/common/check-dirs.sh

DOXYGEN_UNPACK_DIR := $(DOXYGEN_DIR)/doxygen-Release_1_8_18
GIT_UNPACK_DIR := $(GIT_DIR)/git-2.27.0
KCOV_UNPACK_DIR := $(KCOV_DIR)/kcov-38
MAKE_UNPACK_DIR := $(MAKE_DIR)/make-4.3
PYTHON_UNPACK_DIR := $(PYTHON_DIR)/Python-3.9.0b4

BUILD_DOXYGEN := $(MAKBET_PATH)/examples/toolchain/tasks/build-doxygen.sh
BUILD_GIT := $(MAKBET_PATH)/examples/toolchain/tasks/build-git.sh
BUILD_KCOV := $(MAKBET_PATH)/examples/toolchain/tasks/build-kcov.sh
BUILD_MAKE := $(MAKBET_PATH)/examples/toolchain/tasks/build-make.sh
BUILD_PYTHON := $(MAKBET_PATH)/examples/toolchain/tasks/build-python.sh

CHECK_FILES := $(MAKBET_TASKS_DIR)/common/check-files.sh

DOXYGEN_BIN := $(DOXYGEN_UNPACK_DIR)/build/bin/doxygen
GIT_BIN := $(GIT_UNPACK_DIR)/git
KCOV_BIN := $(KCOV_UNPACK_DIR)/build/src/kcov
MAKE_BIN := $(MAKE_UNPACK_DIR)/make
PYTHON_BIN := $(PYTHON_UNPACK_DIR)/python

EXEC_CMD := $(MAKBET_TASKS_DIR)/common/exec-cmd.sh


#
# All tasks required to run scenario from toolchain/advanced/Makefile file.
#

.PHONY: scenario-help
scenario-help::
	@echo ""
	@echo "All targets defined in $(CURDIR)/$(firstword $(MAKEFILE_LIST)):"
	@echo ""

$(eval $(call TASK_template, \
	clean, \
	, \
	rm, \
		-rfv \
		$(WORK_DIR) \
))

$(eval $(call TASK_template, \
	INIT, \
	, \
	, \
	\
))

$(eval $(call TASK_template, \
	prepare-workdir-structure, \
	INIT, \
	$(CREATE_DIRS), $(DOXYGEN_DIR) $(GIT_DIR) $(KCOV_DIR) $(MAKE_DIR) $(PYTHON_DIR) \
))

$(eval $(call TASK_template, \
	fetch-doxygen-src, \
	prepare-workdir-structure, \
	$(DOWNLOAD), $(DOXYGEN_URL) $(DOXYGEN_ZIP) \
))

$(eval $(call TASK_template, \
	fetch-git-src, \
	prepare-workdir-structure, \
	$(DOWNLOAD), $(GIT_URL) $(GIT_ZIP) \
))

$(eval $(call TASK_template, \
	fetch-kcov-src, \
	prepare-workdir-structure, \
	$(DOWNLOAD), $(KCOV_URL) $(KCOV_ZIP) \
))

$(eval $(call TASK_template, \
	fetch-make-src, \
	prepare-workdir-structure, \
	$(DOWNLOAD), $(MAKE_URL) $(MAKE_TGZ) \
))

$(eval $(call TASK_template, \
	fetch-python-src, \
	prepare-workdir-structure, \
	$(DOWNLOAD), $(PYTHON_URL) $(PYTHON_TXZ) \
))

$(eval $(call TASK_template, \
	unpack-doxygen-src, \
	fetch-doxygen-src, \
	$(UNPACK_ZIP), $(DOXYGEN_ZIP) $(DOXYGEN_DIR)/ \
))

$(eval $(call TASK_template, \
	unpack-git-src, \
	fetch-git-src, \
	$(UNPACK_ZIP), $(GIT_ZIP) $(GIT_DIR)/ \
))

$(eval $(call TASK_template, \
	unpack-kcov-src, \
	fetch-kcov-src, \
	$(UNPACK_ZIP), $(KCOV_ZIP) $(KCOV_DIR)/ \
))

$(eval $(call TASK_template, \
	unpack-make-src, \
	fetch-make-src, \
	$(UNPACK_TGZ), $(MAKE_TGZ) $(MAKE_DIR)/ \
))

$(eval $(call TASK_template, \
	unpack-python-src, \
	fetch-python-src, \
	$(UNPACK_TXZ), $(PYTHON_TXZ) $(PYTHON_DIR)/ \
))

$(eval $(call TASK_template, \
	check-all-src-dirs, \
	unpack-doxygen-src unpack-git-src unpack-kcov-src unpack-make-src unpack-python-src, \
	$(CHECK_DIRS), $(DOXYGEN_UNPACK_DIR)/ $(GIT_UNPACK_DIR)/ $(KCOV_UNPACK_DIR)/ $(MAKE_UNPACK_DIR)/ $(PYTHON_UNPACK_DIR)/ \
))

$(eval $(call TASK_template, \
	build-doxygen, \
	check-all-src-dirs, \
	$(BUILD_DOXYGEN), $(DOXYGEN_UNPACK_DIR)/ \
))

$(eval $(call TASK_template, \
	build-git, \
	build-doxygen, \
	$(BUILD_GIT), $(GIT_UNPACK_DIR)/ \
))

$(eval $(call TASK_template, \
	build-kcov, \
	build-git, \
	$(BUILD_KCOV), $(KCOV_UNPACK_DIR)/ \
))

$(eval $(call TASK_template, \
	build-make, \
	build-kcov, \
	$(BUILD_MAKE), $(MAKE_UNPACK_DIR)/ \
))

$(eval $(call TASK_template, \
	build-python, \
	build-make, \
	$(BUILD_PYTHON), $(PYTHON_UNPACK_DIR)/ \
))

$(eval $(call TASK_template, \
	check-build-binaries, \
	build-doxygen build-git build-kcov build-make, \
	$(CHECK_FILES), $(DOXYGEN_BIN) $(GIT_BIN) $(KCOV_BIN) $(MAKE_BIN) $(PYTHON_BIN) \
))

$(eval $(call TASK_template, \
	print-doxygen-version, \
	build-doxygen, \
	$(EXEC_CMD), $(DOXYGEN_BIN) --version \
))

$(eval $(call TASK_template, \
	print-git-version, \
	build-git, \
	$(EXEC_CMD), $(GIT_BIN) --version \
))

$(eval $(call TASK_template, \
	print-kcov-version, \
	build-kcov, \
	$(EXEC_CMD), $(KCOV_BIN) --version \
))

$(eval $(call TASK_template, \
	print-make-version, \
	build-make, \
	$(EXEC_CMD), $(MAKE_BIN) --version \
))

$(eval $(call TASK_template, \
	print-python-version, \
	build-python, \
	$(EXEC_CMD), $(PYTHON_BIN) -V \
))

$(eval $(call TASK_template, \
	build-all, \
	build-doxygen build-git build-kcov build-make build-python, \
	,,\
))

.PHONY: print-all-versions
print-all-versions: \
	build-all \
	print-doxygen-version \
	print-git-version \
	print-kcov-version \
	print-make-version \
	print-python-version

.PHONY: all
all: \
	print-all-versions


# The end

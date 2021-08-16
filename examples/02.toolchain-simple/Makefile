# This is Makefile file for "02.toolchain-simple" example scenario.

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
# All global variables required by "02.toolchain-simple" scenario.
#

WORK_DIR := /tmp/makbet/examples/02.toolchain-simple

#
# All tasks required to run "02.toolchain-simple" scenario.
#

#
# Task "@01-INIT" - an entry point for "02.toolchain-simple" scenario.
#
$(eval $(call TASK_template, \
	@01-INIT, "Entry point", \
))

$(eval $(call TASK_template, \
	clean, "Remove $(WORK_DIR) dir", \
	, \
	rm, -rfv $(WORK_DIR) \
))

$(eval $(call TASK_template, \
	prepare-workdir-structure, "Prepare initial dir structure", \
	@01-INIT, \
	$(MAKBET_TASKS_DIR)/common/create-dir-structure, \
		$(WORK_DIR)/doxygen \
		$(WORK_DIR)/git \
		$(WORK_DIR)/kcov \
		$(WORK_DIR)/make \
		$(WORK_DIR)/python \
))

$(eval $(call TASK_template, \
	fetch-doxygen-src, "Fetch doxygen sources", \
	prepare-workdir-structure, \
	$(MAKBET_TASKS_DIR)/common/download-file, \
		https://github.com/doxygen/doxygen/archive/Release_1_9_1.zip \
		$(WORK_DIR)/doxygen/Release_1_9_1.zip \
))

$(eval $(call TASK_template, \
	fetch-git-src, "Fetch git sources", \
	prepare-workdir-structure, \
	$(MAKBET_TASKS_DIR)/common/download-file, \
		https://github.com/git/git/archive/v2.32.0.zip \
		$(WORK_DIR)/git/v2.32.0.zip \
))

$(eval $(call TASK_template, \
	fetch-kcov-src, "Fetch kcov sources", \
	prepare-workdir-structure, \
	$(MAKBET_TASKS_DIR)/common/download-file, \
		https://github.com/SimonKagstrom/kcov/archive/38.zip \
		$(WORK_DIR)/kcov/38.zip \
))

$(eval $(call TASK_template, \
	fetch-make-src, "Fetch GNU Make sources", \
	prepare-workdir-structure, \
	$(MAKBET_TASKS_DIR)/common/download-file, \
		http://ftp.gnu.org/gnu/make/make-4.3.tar.gz \
		$(WORK_DIR)/make/make-4.3.tar.gz \
))

$(eval $(call TASK_template, \
	fetch-python-src, "Fetch python sources", \
	prepare-workdir-structure, \
	$(MAKBET_TASKS_DIR)/common/download-file, \
		https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tar.xz \
		$(WORK_DIR)/python/Python-3.9.6.tar.xz \
))

$(eval $(call TASK_template, \
	unpack-doxygen-src, "Unpack doxygen sources", \
	fetch-doxygen-src, \
	$(MAKBET_TASKS_DIR)/common/uncompress-zip-file, \
		$(WORK_DIR)/doxygen/Release_1_9_1.zip \
		$(WORK_DIR)/doxygen/ \
))

$(eval $(call TASK_template, \
	unpack-git-src, "Unpack git sources", \
	fetch-git-src, \
	$(MAKBET_TASKS_DIR)/common/uncompress-zip-file, \
		$(WORK_DIR)/git/v2.32.0.zip \
		$(WORK_DIR)/git/ \
))

$(eval $(call TASK_template, \
	unpack-kcov-src, "Unpack kcov sources",  \
	fetch-kcov-src, \
	$(MAKBET_TASKS_DIR)/common/uncompress-zip-file, \
		$(WORK_DIR)/kcov/38.zip \
		$(WORK_DIR)/kcov/ \
))

$(eval $(call TASK_template, \
	unpack-make-src, "Unpack GNU Make sources", \
	fetch-make-src, \
	$(MAKBET_TASKS_DIR)/common/uncompress-tgz-file, \
		$(WORK_DIR)/make/make-4.3.tar.gz \
		$(WORK_DIR)/make/ \
))

$(eval $(call TASK_template, \
	unpack-python-src, "Unpack python sources", \
	fetch-python-src, \
	$(MAKBET_TASKS_DIR)/common/uncompress-txz-file, \
		$(WORK_DIR)/python/Python-3.9.6.tar.xz \
		$(WORK_DIR)/python/ \
))

$(eval $(call TASK_template, \
	check-all-src-dirs, "Check all source code dirs", \
	unpack-doxygen-src unpack-git-src unpack-kcov-src unpack-make-src unpack-python-src, \
	$(MAKBET_TASKS_DIR)/common/check-dirs, \
		$(WORK_DIR)/doxygen/doxygen-Release_1_9_1/ \
		$(WORK_DIR)/git/git-2.32.0/ \
		$(WORK_DIR)/kcov/kcov-38/ \
		$(WORK_DIR)/make/make-4.3/ \
		$(WORK_DIR)/python/Python-3.9.6/ \
))

$(eval $(call TASK_template, \
	build-doxygen, "Build doxygen inside its source dir", \
	check-all-src-dirs, \
	$(MAKBET_PATH)/examples/lib/tasks/build-scripts/build-doxygen, \
		$(WORK_DIR)/doxygen/doxygen-Release_1_9_1/ \
))

$(eval $(call TASK_template, \
	build-git, "Build git inside its source dir", \
	build-doxygen, \
	$(MAKBET_PATH)/examples/lib/tasks/build-scripts/build-git, \
		$(WORK_DIR)/git/git-2.32.0/ \
))

$(eval $(call TASK_template, \
	build-kcov, "Build kcov inside its source dir", \
	build-git, \
	$(MAKBET_PATH)/examples/lib/tasks/build-scripts/build-kcov, \
		$(WORK_DIR)/kcov/kcov-38/ \
))

$(eval $(call TASK_template, \
	build-make, "Build GNU Make inside its source dir", \
	build-kcov, \
	$(MAKBET_PATH)/examples/lib/tasks/build-scripts/build-make, \
		$(WORK_DIR)/make/make-4.3/ \
))

$(eval $(call TASK_template, \
	build-python, "Build python inside its source dir", \
	build-make, \
	$(MAKBET_PATH)/examples/lib/tasks/build-scripts/build-python, \
		$(WORK_DIR)/python/Python-3.9.6/ \
))

$(eval $(call TASK_template, \
	check-build-binaries, "Check the presence of all built binaries", \
	build-doxygen build-git build-kcov build-make, \
	$(MAKBET_TASKS_DIR)/common/check-files, \
		$(WORK_DIR)/doxygen/doxygen-Release_1_9_1/build/bin/doxygen \
		$(WORK_DIR)/git/git-2.32.0/git \
		$(WORK_DIR)/kcov/kcov-38/build/src/kcov \
		$(WORK_DIR)/make/make-4.3/make \
		$(WORK_DIR)/python/Python-3.9.6/python \
))

$(eval $(call TASK_template, \
	print-doxygen-version, "Print version of doxygen from source dir", \
	build-doxygen, \
	$(MAKBET_TASKS_DIR)/common/exec-cmd, \
		$(WORK_DIR)/doxygen/doxygen-Release_1_9_1/build/bin/doxygen \
		--version \
))

$(eval $(call TASK_template, \
	print-git-version, "Print version of git from source dir", \
	build-git, \
	$(MAKBET_TASKS_DIR)/common/exec-cmd, \
		$(WORK_DIR)/git/git-2.32.0/git \
		--version \
))

$(eval $(call TASK_template, \
	print-kcov-version, "Print version of kcov from source dir", \
	build-kcov, \
	$(MAKBET_TASKS_DIR)/common/exec-cmd, \
		$(WORK_DIR)/kcov/kcov-38/build/src/kcov \
		--version \
))

$(eval $(call TASK_template, \
	print-make-version, "Print version of GNU Make from source dir", \
	build-make, \
	$(MAKBET_TASKS_DIR)/common/exec-cmd, \
		$(WORK_DIR)/make/make-4.3/make \
		--version \
))

$(eval $(call TASK_template, \
	print-python-version, "Print version of python from source dir", \
	build-python, \
	$(MAKBET_TASKS_DIR)/common/exec-cmd, \
		$(WORK_DIR)/python/Python-3.9.6/python \
		-V \
))

$(eval $(call TASK_template, \
	build-all, "Checkpoint for all build-* tasks", \
	build-doxygen build-git build-kcov build-make build-python, \
))

$(eval $(call TASK_template, \
	print-all-versions, "Checkpoint for all print-*-version tasks", \
		build-all \
		print-doxygen-version \
		print-git-version \
		print-kcov-version \
		print-make-version \
		print-python-version, \
))

#
# Task "all" - the ultimate goal for "02.toolchain-simple" scenario.
#
$(eval $(call TASK_template, \
	all, "Run task all", \
	print-all-versions, \
))

# Note:
# Target ALL is defined as a regular makefile target which is also
# allowed, but all such targets will be not visible in automatically
# generated help message.  So in fact it can be treated as a poor
# implementation of hidden (secret) target.
.PHONY: ALL
ALL: \
	print-all-versions


# EOF

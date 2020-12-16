# This is Makefile file for "04.ping-dns-servers" example scenario.

#
# Include mandatory makbet.mk file.
#
ifndef MAKBET_PATH
  $(error [ERROR]: MAKBET_PATH is not defined)
else
  include $(MAKBET_PATH)/makbet.mk
endif

#
# All tasks required to run "04.ping-dns-servers" scenario.
#

#
# Task "@01-INIT" - an entry point for "04.ping-dns-servers" scenario.
#
$(eval $(call TASK_template, \
	@01-INIT, "Entry point", \
))

$(eval $(call TASK_template, \
	ping1111, "Ping 1.1.1.1 dns server", \
	@01-INIT, \
	ping, -c10 1.1.1.1 \
))

$(eval $(call TASK_template, \
	ping8844, "Ping 8.8.4.4 dns server", \
	@01-INIT, \
	ping, -c4 8.8.4.4 \
))

$(eval $(call TASK_template, \
	ping8888, "Ping 8.8.8.8 dns server", \
	@01-INIT, \
	ping, -c4 8.8.8.8 \
))

#
# Task "ping-all" - the ultimate goal for "04.ping-dns-servers" scenario.
#
$(eval $(call TASK_template, \
	ping-all, "Ping all dns servers", \
	ping1111 ping8844 ping8888, \
))

#
# Task "all" - the ultimate goal for "04.ping-dns-servers" scenario.
#
$(eval $(call TASK_template, \
	all, "Ping all dns servers", \
	ping1111 ping8844 ping8888, \
))


# End of file

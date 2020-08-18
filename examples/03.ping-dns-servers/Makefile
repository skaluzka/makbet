# This is Makefile file for "03.ping-dns-servers" example scenario.

#
# Include mandatory makbet.mk file.
#
ifndef MAKBET_PATH
  $(error MAKBET_PATH is not defined)
else
  include $(MAKBET_PATH)/makbet.mk
endif

#
# All tasks required to run scenario from 03.ping-dns-servers/Makefile file.
#

# Entry point.
$(eval $(call TASK_template, \
	INIT, "Entry point", \
))

$(eval $(call TASK_template, \
	ping1111, "Ping 1.1.1.1 dns server", \
	INIT, \
	ping, -c10 1.1.1.1 \
))

$(eval $(call TASK_template, \
	ping8844, "Ping 8.8.4.4 dns server", \
	INIT, \
	ping, -c4 8.8.4.4 \
))

$(eval $(call TASK_template, \
	ping8888, "Ping 8.8.8.8 dns server", \
	INIT, \
	ping, -c4 8.8.8.8 \
))

# Checkpoint task "ping-all".
$(eval $(call TASK_template, \
	ping-all, "Ping all dns servers", \
	ping1111 ping8844 ping8888, \
))

# Checkpoint task "all".
$(eval $(call TASK_template, \
	all, "Ping all dns servers", \
	ping1111 ping8844 ping8888, \
))


# End of file

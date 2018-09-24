################################################################################
#
# fake-hwclock
#
################################################################################

define FAKE_HWCLOCK_BUILD_CMDS
endef

define FAKE_HWCLOCK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/bin $(FAKE_HWCLOCK_PKGDIR)/fake-hwclock
	$(INSTALL) -m 0644 -D $(FAKE_HWCLOCK_PKGDIR)/fake-hwclock.cron $(TARGET_DIR)/etc/cron.d/fake-hwclock
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/etc/init.d $(FAKE_HWCLOCK_PKGDIR)/S??fake-hwclock
endef

$(eval $(generic-package))

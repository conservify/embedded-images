################################################################################
#
# wifi-ap-helpers
#
################################################################################

define WIFI_AP_HELPERS_BUILD_CMDS
endef

define WIFI_AP_HELPERS_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/var/lib/wifi
	$(INSTALL) -m 0644 -t $(TARGET_DIR)/var/lib/wifi $(WIFI_AP_HELPERS_PKGDIR)/wifi/*.conf
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/var/lib/wifi $(WIFI_AP_HELPERS_PKGDIR)/wifi/*.sh
endef

$(eval $(generic-package))

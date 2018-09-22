################################################################################
#
# wifi-ap-helpers
#
################################################################################

define WIFI_AP_HELPERS_BUILD_CMDS
endef

define WIFI_AP_HELPERS_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 wifi $(TARGET_DIR)/var/lib/wifi
endef

$(eval $(generic-package))

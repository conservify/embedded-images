################################################################################
#
# wireguard-quick
#
################################################################################

define WIREGUARD_QUICK_BUILD_CMDS
endef

define WIREGUARD_QUICK_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 wg-quick $(TARGET_DIR)/bin
endef

$(eval $(generic-package))

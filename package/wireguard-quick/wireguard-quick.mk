################################################################################
#
# wireguard-quick
#
################################################################################

define WIREGUARD_QUICK_BUILD_CMDS
endef

define WIREGUARD_QUICK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/bin $(WIREGUARD_QUICK_PKGDIR)/wg-quick
endef

$(eval $(generic-package))

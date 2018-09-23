################################################################################
#
# conservify-network
#
################################################################################

define CONSERVIFY_NETWORK_BUILD_CMDS
endef

define CONSERVIFY_NETWORK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/etc/init.d $(CONSERVIFY_NETWORK_PKGDIR)/S41*
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/local/bin
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/usr/local/bin $(CONSERVIFY_NETWORK_PKGDIR)/network-finder
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/usr/local/bin $(CONSERVIFY_NETWORK_PKGDIR)/network-watcher
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/etc/network/online
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/etc/network/online $(CONSERVIFY_NETWORK_PKGDIR)/S01wireguard
endef

$(eval $(generic-package))

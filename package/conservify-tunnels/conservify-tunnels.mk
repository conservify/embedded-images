################################################################################
#
# conservify-tunnels
#
################################################################################

define CONSERVIFY_TUNNELS_BUILD_CMDS
endef

define CONSERVIFY_TUNNELS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/usr/local/bin $(CONSERVIFY_TUNNELS_PKGDIR)/ssh-tunnel
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/usr/local/bin $(CONSERVIFY_TUNNELS_PKGDIR)/rsyslog-tunnel
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/etc/init.d $(CONSERVIFY_TUNNELS_PKGDIR)/S??*
endef

$(eval $(generic-package))

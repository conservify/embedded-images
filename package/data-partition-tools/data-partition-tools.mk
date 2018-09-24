################################################################################
#
# data-partition-tools
#
################################################################################

define DATA_PARTITION_TOOLS_BUILD_CMDS
endef

define DATA_PARTITION_TOOLS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/bin $(DATA_PARTITION_TOOLS_PKGDIR)/create-data-partition.sh
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/etc/init.d $(DATA_PARTITION_TOOLS_PKGDIR)/S??data-partition
endef

$(eval $(generic-package))

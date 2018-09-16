################################################################################
#
# bow-tools
#
################################################################################

BOW_TOOLS_VERSION = master
BOW_TOOLS_SITE =  $(call github,Conservify,glacier,$(BOW_TOOLS_VERSION))
BOW_TOOLS_LICENSE_FILES = README.org

define BOW_TOOLS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) GOARCH=arm -C $(@D) clean go-binaries
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/psn-adc
endef

define BOW_TOOLS_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/bin
	$(INSTALL) -D -m 0755 $(@D)/build/linux-arm/* $(TARGET_DIR)/usr/local/bin
	$(INSTALL) -D -m 0755 $(@D)/psn-adc/AdcDemo $(TARGET_DIR)/usr/local/bin
endef

$(eval $(generic-package))

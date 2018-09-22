################################################################################
#
# jenkins-agent
#
################################################################################

define JENKINS_AGENT_BUILD_CMDS
endef

define JENKINS_AGENT_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/var/lib/jenkins
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/home/jenkins
	$(INSTALL) -m 0644 -t $(TARGET_DIR)/var/lib/jenkins $(JENKINS_AGENT_PKGDIR)/agent.jar
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/etc/init.d $(JENKINS_AGENT_PKGDIR)/S??jenkins-agent
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/usr/local/bin $(JENKINS_AGENT_PKGDIR)/jenkins-agent
endef

$(eval $(generic-package))

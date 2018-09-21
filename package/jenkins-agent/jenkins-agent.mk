################################################################################
#
# jenkins-agent
#
################################################################################

define JENKINS_AGENT_BUILD_CMDS
endef

define JENKINS_AGENT_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/var/lib/jenkins
	$(INSTALL) -d -m 0644 agent.jar $(TARGET_DIR)/var/lib/jenkins
	$(INSTALL) -d -m 0755 S??jenkins-agent $(TARGET_DIR)/etc/init.d
	$(INSTALL) -d -m 0755 jenkins-agent $(TARGET_DIR)/usr/local/bin
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/home/jenkins
endef

$(eval $(generic-package))

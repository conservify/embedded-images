################################################################################
#
# initramfs-readonly
#
################################################################################

INITRAMFS_READONLY_VERSION = master
INITRAMFS_READONLY_SITE = $(call github,raspberrypi,target_fs,$(INITRAMFS_READONLY_VERSION))
INITRAMFS_READONLY_DEPENDENCIES = rpi-firmware rpi-wifi-firmware

define INITRAMFS_READONLY_BUILD_CMDS
	rm -f $(@D)/init
	rm -f $(@D)/etc/mdev.conf

	cp $(INITRAMFS_READONLY_PKGDIR)/init $(@D)
	chmod 755 $(@D)/init

  $(INSTALL) -m 0755 -d $(@D)/boot
  $(INSTALL) -m 0755 -d $(@D)/mnt/root-ro
  $(INSTALL) -m 0755 -d $(@D)/mnt/root-rw
  $(INSTALL) -m 0755 -d $(@D)/rootfs/root-ro
  $(INSTALL) -m 0755 -d $(@D)/rootfs/root-rw
  $(INSTALL) -m 0755 -d $(@D)/lib/firmware/brcm
  $(INSTALL) -m 0644 -t $(@D)/lib/firmware/brcm/ $(TARGET_DIR)/lib/firmware/brcm/*

	(cd $(@D) && find . -name .git -a -type d -prune -o -name "initramfs.*" -type f -prune -o -print | cpio -o -H newc > $(@D)/initramfs.cpio)
	gzip -c $(@D)/initramfs.cpio > $(@D)/initramfs.cpio.gz
endef

define INITRAMFS_READONLY_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/mnt/root-ro
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/mnt/root-rw
	$(INSTALL) -m 0644 -t $(BINARIES_DIR) $(@D)/initramfs.cpio.gz
endef

$(eval $(generic-package))

################################################################################
#
# openjdk
#
# Please be aware that, when cross-compiling, the OpenJDK configure script will
# generally use 'target' where autoconf traditionally uses 'host'
#
################################################################################

OPENJDK_VERSION = jdk-10+46
OPENJDK_RELEASE = jdk10u
OPENJDK_PROJECT = jdk-updates
OPENJDK_VARIANT = client
OPENJDK_SOURCE = jdk-10.0.2+13.tar.bz2
OPENJDK_SITE = http://hg.openjdk.java.net/jdk-updates/jdk10u/archive

export DISABLE_HOTSPOT_OS_VERSION_CHECK=ok

OPENJDK_CONF_OPTS = \
	--with-jvm-interpreter=cpp \
	--with-jvm-variants=zero \
	--enable-openjdk-only \
	--with-stdc++lib=static \
	--with-jvm-variants=$(OPENJDK_VARIANT) \
	--with-freetype-include=$(STAGING_DIR)/usr/include/freetype2 \
	--with-freetype-lib=$(STAGING_DIR)/usr/lib \
	--with-freetype=$(STAGING_DIR)/usr/ \
	--with-debug-level=release \
	--openjdk-target=$(GNU_TARGET_NAME) \
	--with-sys-root=$(STAGING_DIR) \
	--with-tools-dir=$(HOST_DIR) \
	--disable-freetype-bundling \
	--enable-unlimited-crypto \
	--with-extra-cflags='-Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-implicit-fallthrough -I$(@D)/../uclibc-1.0.30/libpthread/nptl_db' \
	--with-extra-cxxflags='-Wno-implicit-fallthrough' \
	--with-x

OPENJDK_MAKE_OPTS = all CONF=linux-$(TARGET_ARCH)-normal-zero-release
OPENJDK_DEPENDENCIES = host-pkgconf fontconfig xlib_libXrender xlib_libXt xlib_libXext xlib_libXtst cups alsa-lib

OPENJDK_LICENSE = GPLv2+ with exception
OPENJDK_LICENSE_FILES = COPYING

define OPENJDK_CONFIGURE_CMDS
	chmod +x $(@D)/configure
	cd $(@D); ./configure $(OPENJDK_CONF_OPTS) OBJCOPY=$(TARGET_OBJCOPY) STRIP=$(TARGET_STRIP) CPP=$(TARGET_CPP) CXX=$(TARGET_CXX) CC=$(TARGET_CC) LD=$(TARGET_LD)
endef

define OPENJDK_BUILD_CMDS
	# LD is using CC because busybox -ld do not support -Xlinker -z hence linking using -gcc instead
	OBJCOPY=$(TARGET_OBJCOPY) STRIP=$(TARGET_STRIP) BUILD_CC=gcc BUILD_LD=ld CPP=$(TARGET_CPP) CXX=$(TARGET_CXX) CC=$(TARGET_CC) LD=$(TARGET_LD) make -C $(@D) jdk
endef

define HOST_OPENJDK_BUILD_CMDS
	# LD is using CC because busybox -ld do not support -Xlinker -z hence linking using -gcc instead
	OBJCOPY=$(HOST_OBJCOPY) STRIP=$(HOST_STRIP) BUILD_CC=gcc BUILD_LD=ld CPP=$(HOST_CPP) CXX=$(HOST_CXX) CC=$(HOST_CC) LD=$(HOST_LD) make -C $(@D) hotspot
endef

define HOST_OPENJDK_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/usr/lib/jvm/
endef

define OPENJDK_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/jvm/
	cp -aLrf $(@D)/build/*/jdk/* $(TARGET_DIR)/usr/lib/jvm/
	rm -f $(TARGET_DIR)/usr/lib/jvm/lib/libjsig.so
	rm -f $(TARGET_DIR)/usr/lib/jvm/lib/libjvm.so
	cp -arf $(@D)/build/*/jdk/lib/$(OPENJDK_VARIANT)/libjsig.so $(TARGET_DIR)/usr/lib/jvm/lib/
	cp -arf $(@D)/build/*/jdk/lib/$(OPENJDK_VARIANT)/libjvm.so $(TARGET_DIR)/usr/lib/jvm/lib/
endef

#openjdk configure is not based on automake
$(eval $(generic-package))
$(eval $(host-generic-package))

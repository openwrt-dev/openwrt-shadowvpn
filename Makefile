include $(TOPDIR)/rules.mk

PKG_NAME:=ShadowVPN
PKG_VERSION:=0.1.0
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE:=shadowvpn-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/clowwindy/ShadowVPN/releases/download/$(PKG_VERSION)
PKG_MAINTAINER:=clowwindy <clowwindy42@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/shadowvpn-$(PKG_VERSION)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ShadowVPN/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A fast, safe VPN based on libsodium
	URL:=https://github.com/clowwindy/ShadowVPN
endef

define Package/ShadowVPN
  $(call Package/ShadowVPN/Default)
endef

define Package/ShadowVPN/description
A fast, safe VPN based on libsodium
endef

define Package/ShadowVPN/conffiles
/etc/shadowvpn/client.conf
/etc/shadowvpn/client_up.sh
/etc/shadowvpn/client_down.sh
endef

define Package/ShadowVPN/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/shadowvpn.init $(1)/etc/init.d/shadowvpn
	$(INSTALL_DIR) $(1)/etc/shadowvpn
	$(INSTALL_CONF) ./files/client.conf $(1)/etc/shadowvpn/client.conf
	$(INSTALL_DATA) ./files/client_up.sh $(1)/etc/shadowvpn/client_up.sh
	$(INSTALL_DATA) ./files/client_down.sh $(1)/etc/shadowvpn/client_down.sh
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/shadowvpn $(1)/usr/bin
endef

$(eval $(call BuildPackage,ShadowVPN))
TARGET := iphone:clang:14.5:14.5

include $(THEOS)/makefiles/common.mk

THEOS_PACKAGE_SCHEME = rootless

BUNDLE_NAME = DMIPrefs

DMIPrefs_FILES =  DMIPRootListController.m
DMIPrefs_FRAMEWORKS = UIKit
DMIPrefs_PRIVATE_FRAMEWORKS = MobileCoreServices Preferences
DMIPrefs_EXTRA_FRAMEWORKS = AltList
DMIPrefs_INSTALL_PATH = /Library/PreferenceBundles
DMIPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/DMIPrefs.plist$(ECHO_END)

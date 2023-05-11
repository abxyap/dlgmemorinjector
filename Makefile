GO_EASY_ON_ME = 1
FINALPACKAGE=1
DEBUG=0

ARCHS := arm64 arm64e
TARGET := iphone:clang:16.4:14.5

THEOS_DEVICE_IP = 127.0.0.1 -p 2222

INSTALL_TARGET_PROCESSES = SpringBoard

THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DLGMemorInjector

DLGMemorInjector_EXTRA_FRAMEWORKS = AltList

DLGMemorInjector_FILES = DLGMemor/mem/mem_utils.c DLGMemor/mem/mem.c DLGMemor/mem/search_result.c DLGMemor/memui/DLGMem.m  DLGMemor/memui/DLGMemEntry.m DLGMemor/memui/category/UIWindow+DLGMemUI.m DLGMemor/memui/views/DLGMemUI.m DLGMemor/memui/views/DLGMemUIView.m DLGMemor/memui/views/DLGMemUIViewCell.m Tweak.x 
DLGMemorInjector_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += DMIPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk

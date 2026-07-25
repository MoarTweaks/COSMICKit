ARCHS = arm64
TARGET = iphone:clang:16.5:15.0
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

SUBPROJECTS += Modules/Connectivity

include $(THEOS_MAKE_PATH)/aggregate.mk

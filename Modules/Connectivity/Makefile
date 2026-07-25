ARCHS = arm64
TARGET = iphone:clang:16.5:15.0
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CCAAirplaneModule CCAWiFiModule CCAAirDropModule CCACellularDataModule CCABluetoothModule CCAHotspotModule CCAVPNModule

CCAAirplaneModule_FILES = CCAConnectivityModules.xm
CCAWiFiModule_FILES = CCAConnectivityModules.xm
CCAAirDropModule_FILES = CCAConnectivityModules.xm
CCACellularDataModule_FILES = CCAConnectivityModules.xm
CCABluetoothModule_FILES = CCAConnectivityModules.xm
CCAHotspotModule_FILES = CCAConnectivityModules.xm
CCAVPNModule_FILES = CCAConnectivityModules.xm

CCAAirplaneModule_RESOURCE_DIRS = Resources/CCAAirplaneModule
CCAWiFiModule_RESOURCE_DIRS = Resources/CCAWiFiModule
CCAAirDropModule_RESOURCE_DIRS = Resources/CCAAirDropModule
CCACellularDataModule_RESOURCE_DIRS = Resources/CCACellularDataModule
CCABluetoothModule_RESOURCE_DIRS = Resources/CCABluetoothModule
CCAHotspotModule_RESOURCE_DIRS = Resources/CCAHotspotModule
CCAVPNModule_RESOURCE_DIRS = Resources/CCAVPNModule

CCAAirplaneModule_INSTALL_PATH = /Library/ControlCenter/Bundles
CCAWiFiModule_INSTALL_PATH = /Library/ControlCenter/Bundles
CCAAirDropModule_INSTALL_PATH = /Library/ControlCenter/Bundles
CCACellularDataModule_INSTALL_PATH = /Library/ControlCenter/Bundles
CCABluetoothModule_INSTALL_PATH = /Library/ControlCenter/Bundles
CCAHotspotModule_INSTALL_PATH = /Library/ControlCenter/Bundles
CCAVPNModule_INSTALL_PATH = /Library/ControlCenter/Bundles

CCAAirplaneModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit
CCAWiFiModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit
CCAAirDropModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit
CCACellularDataModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit
CCABluetoothModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit
CCAHotspotModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit
CCAVPNModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit

CCAAirplaneModule_FRAMEWORKS = UIKit
CCAWiFiModule_FRAMEWORKS = UIKit
CCAAirDropModule_FRAMEWORKS = UIKit
CCACellularDataModule_FRAMEWORKS = UIKit
CCABluetoothModule_FRAMEWORKS = UIKit
CCAHotspotModule_FRAMEWORKS = UIKit
CCAVPNModule_FRAMEWORKS = UIKit CFNetwork

CCAAirplaneModule_CFLAGS = -fobjc-arc
CCAWiFiModule_CFLAGS = -fobjc-arc
CCAAirDropModule_CFLAGS = -fobjc-arc
CCACellularDataModule_CFLAGS = -fobjc-arc
CCABluetoothModule_CFLAGS = -fobjc-arc
CCAHotspotModule_CFLAGS = -fobjc-arc
CCAVPNModule_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

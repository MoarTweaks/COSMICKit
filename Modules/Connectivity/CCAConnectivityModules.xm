#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import <CFNetwork/CFNetwork.h>
#import <ControlCenterUIKit/CCUIToggleModule.h>
#import <ControlCenterUIKit/CCUIContentModuleContentViewController-Protocol.h>
#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>

typedef NS_ENUM(NSUInteger, CCAConnectivityKind) {
    CCAConnectivityKindAirplane,
    CCAConnectivityKindWiFi,
    CCAConnectivityKindAirDrop,
    CCAConnectivityKindCellular,
    CCAConnectivityKindBluetooth,
    CCAConnectivityKindHotspot,
    CCAConnectivityKindVPN,
};

@interface CCAConnectivityButtonViewController : CCUILabeledRoundButtonViewController <CCUIContentModuleContentViewController>
@end

@implementation CCAConnectivityButtonViewController
- (CGFloat)preferredExpandedContentHeight { return 67.0; }
- (CGFloat)preferredExpandedContentWidth { return 67.0; }
- (BOOL)providesOwnPlatter { return NO; }
- (BOOL)shouldBeginTransitionToExpandedContentModule { return NO; }
@end

static NSString *CCAIdentifierForKind(CCAConnectivityKind kind) {
    switch (kind) {
        case CCAConnectivityKindAirplane: return @"com.futur3sn0w.ccaster.connectivity.airplane";
        case CCAConnectivityKindWiFi: return @"com.futur3sn0w.ccaster.connectivity.wifi";
        case CCAConnectivityKindAirDrop: return @"com.futur3sn0w.ccaster.connectivity.airdrop";
        case CCAConnectivityKindCellular: return @"com.futur3sn0w.ccaster.connectivity.cellular";
        case CCAConnectivityKindBluetooth: return @"com.futur3sn0w.ccaster.connectivity.bluetooth";
        case CCAConnectivityKindHotspot: return @"com.futur3sn0w.ccaster.connectivity.hotspot";
        case CCAConnectivityKindVPN: return @"com.futur3sn0w.ccaster.connectivity.vpn";
    }
}

static NSString *CCATitleForKind(CCAConnectivityKind kind) {
    switch (kind) {
        case CCAConnectivityKindAirplane: return @"Airplane Mode";
        case CCAConnectivityKindWiFi: return @"Wi-Fi";
        case CCAConnectivityKindAirDrop: return @"AirDrop";
        case CCAConnectivityKindCellular: return @"Cellular Data";
        case CCAConnectivityKindBluetooth: return @"Bluetooth";
        case CCAConnectivityKindHotspot: return @"Personal Hotspot";
        case CCAConnectivityKindVPN: return @"VPN";
    }
}

static NSString *CCASymbolForKind(CCAConnectivityKind kind) {
    switch (kind) {
        case CCAConnectivityKindAirplane: return @"airplane";
        case CCAConnectivityKindWiFi: return @"wifi";
        case CCAConnectivityKindAirDrop: return @"airdrop";
        case CCAConnectivityKindCellular: return @"antenna.radiowaves.left.and.right";
        case CCAConnectivityKindBluetooth: return @"bluetooth";
        case CCAConnectivityKindHotspot: return @"personalhotspot";
        case CCAConnectivityKindVPN: return @"network";
    }
}

static UIImage *CCAIconForKind(CCAConnectivityKind kind) {
    UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithPointSize:28.0 weight:UIImageSymbolWeightSemibold];
    UIImage *image = [UIImage systemImageNamed:CCASymbolForKind(kind) withConfiguration:configuration];
    return image ?: [UIImage systemImageNamed:@"switch.2" withConfiguration:configuration];
}

static id CCASharedInstance(NSString *className) {
    Class cls = NSClassFromString(className);
    SEL shared = @selector(sharedInstance);
    return [cls respondsToSelector:shared] ? ((id (*)(id, SEL))objc_msgSend)(cls, shared) : nil;
}

static id CCADynamicCall0(id target, NSArray<NSString *> *selectors) {
    for (NSString *selectorName in selectors) {
        SEL selector = NSSelectorFromString(selectorName);
        if ([target respondsToSelector:selector]) return ((id (*)(id, SEL))objc_msgSend)(target, selector);
    }
    return nil;
}

static BOOL CCADynamicBool0(id target, NSArray<NSString *> *selectors, BOOL fallback) {
    for (NSString *selectorName in selectors) {
        SEL selector = NSSelectorFromString(selectorName);
        if ([target respondsToSelector:selector]) return ((BOOL (*)(id, SEL))objc_msgSend)(target, selector);
    }
    return fallback;
}

static BOOL CCADynamicSetBool(id target, NSArray<NSString *> *selectors, BOOL value) {
    for (NSString *selectorName in selectors) {
        SEL selector = NSSelectorFromString(selectorName);
        if (![target respondsToSelector:selector]) continue;
        NSMethodSignature *signature = [target methodSignatureForSelector:selector];
        const char *returnType = signature.methodReturnType;
        if (returnType && (returnType[0] == @encode(BOOL)[0] || returnType[0] == @encode(bool)[0])) {
            BOOL accepted = ((BOOL (*)(id, SEL, BOOL))objc_msgSend)(target, selector, value);
            if (accepted) return YES;
            continue;
        }
        ((void (*)(id, SEL, BOOL))objc_msgSend)(target, selector, value);
        return YES;
    }
    return NO;
}

static id CCARadiosPreferences(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dlopen("/System/Library/PrivateFrameworks/Preferences.framework/Preferences", RTLD_LAZY);
    });
    Class cls = NSClassFromString(@"RadiosPreferences");
    return cls ? [cls new] : nil;
}

static BOOL CCAAirplaneEnabled(void) {
    id radios = CCARadiosPreferences();
    return CCADynamicBool0(radios, @[@"airplaneMode", @"isAirplaneMode"], NO);
}

static BOOL CCASetAirplaneEnabled(BOOL enabled) {
    return CCADynamicSetBool(CCARadiosPreferences(), @[@"setAirplaneMode:"], enabled);
}

static id CCAWiFiManager(void) {
    id manager = CCASharedInstance(@"SBWiFiManager");
    if (!manager) manager = CCASharedInstance(@"WiFiManager");
    return manager;
}

static NSString *CCAWiFiNetworkName(void) {
    id manager = CCAWiFiManager();
    id name = CCADynamicCall0(manager, @[@"currentNetworkName", @"networkName"]);
    return [name isKindOfClass:[NSString class]] ? name : nil;
}

static BOOL CCAWiFiEnabled(void) {
    id manager = CCAWiFiManager();
    return CCADynamicBool0(manager, @[@"wiFiEnabled", @"isWiFiEnabled", @"enabled", @"isEnabled", @"powered"], CCAWiFiNetworkName().length > 0);
}

static BOOL CCASetWiFiEnabled(BOOL enabled) {
    id manager = CCAWiFiManager();
    return CCADynamicSetBool(manager, @[@"setWiFiEnabled:", @"setEnabled:", @"setPowered:"], enabled);
}

static BOOL CCABluetoothEnabled(void) {
    id manager = CCASharedInstance(@"BluetoothManager");
    return CCADynamicBool0(manager, @[@"enabled", @"powered"], NO);
}

static BOOL CCASetBluetoothEnabled(BOOL enabled) {
    id manager = CCASharedInstance(@"BluetoothManager");
    BOOL changed = NO;
    for (NSString *selectorName in @[@"setPowered:", @"setEnabled:"]) {
        SEL selector = NSSelectorFromString(selectorName);
        if (![manager respondsToSelector:selector]) continue;
        BOOL accepted = ((BOOL (*)(id, SEL, BOOL))objc_msgSend)(manager, selector, enabled);
        changed = changed || accepted;
    }
    return changed;
}

static NSString *CCABluetoothDeviceName(void) {
    NSArray *devices = CCADynamicCall0(CCASharedInstance(@"BluetoothManager"), @[@"connectedDevices"]);
    for (id device in devices) {
        NSString *name = CCADynamicCall0(device, @[@"name"]);
        if (name.length) return name;
    }
    return nil;
}

static NSString *CCAAirDropState(void) {
    NSString *value = (__bridge_transfer NSString *)CFPreferencesCopyAppValue(CFSTR("DiscoverableMode"), CFSTR("com.apple.sharingd"));
    if ([value isEqualToString:@"Everyone"]) return @"Everyone";
    if ([value isEqualToString:@"Contacts Only"] || [value isEqualToString:@"Contacts"]) return @"Contacts";
    return @"Off";
}

static BOOL CCAHotspotEnabled(void) {
    id manager = CCASharedInstance(@"SBTetheringController");
    return CCADynamicBool0(manager, @[@"isPersonalHotspotEnabled", @"personalHotspotEnabled", @"tetheringEnabled"], NO);
}

static BOOL CCASetHotspotEnabled(BOOL enabled) {
    id manager = CCASharedInstance(@"SBTetheringController");
    return CCADynamicSetBool(manager, @[@"setPersonalHotspotEnabled:", @"setTetheringEnabled:"], enabled);
}

static BOOL CCACellularEnabled(void) {
    id manager = CCASharedInstance(@"CoreTelephonyClient");
    return CCADynamicBool0(manager, @[@"cellularDataEnabled", @"isCellularDataEnabled"], NO);
}

static BOOL CCASetCellularEnabled(BOOL enabled) {
    id manager = CCASharedInstance(@"CoreTelephonyClient");
    return CCADynamicSetBool(manager, @[@"setCellularDataEnabled:"], enabled);
}

static BOOL CCAVPNEnabled(void) {
    NSDictionary *settings = (__bridge_transfer NSDictionary *)CFNetworkCopySystemProxySettings();
    NSArray *scoped = settings[@"__SCOPED__"] ? [settings[@"__SCOPED__"] allKeys] : nil;
    for (NSString *key in scoped) if ([key.lowercaseString containsString:@"tap"] || [key.lowercaseString containsString:@"tun"] || [key.lowercaseString containsString:@"ipsec"] || [key.lowercaseString containsString:@"ppp"]) return YES;
    return NO;
}

static NSString *CCAStatusForKind(CCAConnectivityKind kind) {
    switch (kind) {
        case CCAConnectivityKindAirplane: return CCAAirplaneEnabled() ? @"On" : @"Off";
        case CCAConnectivityKindWiFi: return CCAWiFiNetworkName() ?: (CCAWiFiEnabled() ? @"On" : @"Off");
        case CCAConnectivityKindAirDrop: return CCAAirDropState();
        case CCAConnectivityKindCellular: return CCACellularEnabled() ? @"On" : @"Off";
        case CCAConnectivityKindBluetooth: return CCABluetoothDeviceName() ?: (CCABluetoothEnabled() ? @"On" : @"Off");
        case CCAConnectivityKindHotspot: return CCAHotspotEnabled() ? @"On" : @"Off";
        case CCAConnectivityKindVPN: return CCAVPNEnabled() ? @"On" : @"Off";
    }
}

static BOOL CCAStateForKind(CCAConnectivityKind kind) {
    switch (kind) {
        case CCAConnectivityKindAirplane: return CCAAirplaneEnabled();
        case CCAConnectivityKindWiFi: return CCAWiFiEnabled();
        case CCAConnectivityKindAirDrop: return ![CCAAirDropState() isEqualToString:@"Off"];
        case CCAConnectivityKindCellular: return CCACellularEnabled();
        case CCAConnectivityKindBluetooth: return CCABluetoothEnabled();
        case CCAConnectivityKindHotspot: return CCAHotspotEnabled();
        case CCAConnectivityKindVPN: return CCAVPNEnabled();
    }
}

static BOOL CCAToggleKind(CCAConnectivityKind kind, BOOL enabled) {
    switch (kind) {
        case CCAConnectivityKindAirplane: return CCASetAirplaneEnabled(enabled);
        case CCAConnectivityKindWiFi: return CCASetWiFiEnabled(enabled);
        case CCAConnectivityKindCellular: return CCASetCellularEnabled(enabled);
        case CCAConnectivityKindBluetooth: return CCASetBluetoothEnabled(enabled);
        case CCAConnectivityKindHotspot: return CCASetHotspotEnabled(enabled);
        case CCAConnectivityKindAirDrop:
        case CCAConnectivityKindVPN:
            return NO;
    }
}

@interface CCAConnectivityBaseModule : CCUIToggleModule
@property (nonatomic, assign) CCAConnectivityKind kind;
@property (nonatomic, strong) UIViewController<CCUIContentModuleContentViewController> *ownedContentViewController;
- (instancetype)initWithKind:(CCAConnectivityKind)kind;
@end

@implementation CCAConnectivityBaseModule
- (instancetype)initWithKind:(CCAConnectivityKind)kind {
    if ((self = [super init])) {
        _kind = kind;
        [self refreshState];
    }
    return self;
}
- (UIViewController<CCUIContentModuleContentViewController> *)contentViewController {
    if (!self.ownedContentViewController) {
        CCAConnectivityButtonViewController *controller = [[CCAConnectivityButtonViewController alloc] initWithGlyphImage:CCAIconForKind(self.kind)
                                                                                                           highlightColor:self.selectedColor
                                                                                                            useLightStyle:NO];
        controller.toggleStateOnTap = NO;
        controller.labelsVisible = YES;
        UIControl *button = controller.button;
        if ([button isKindOfClass:[UIControl class]]) [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        self.ownedContentViewController = (UIViewController<CCUIContentModuleContentViewController> *)controller;
    }
    UIViewController<CCUIContentModuleContentViewController> *controller = self.ownedContentViewController;
    if (controller) {
        controller.view.accessibilityIdentifier = CCAIdentifierForKind(self.kind);
        controller.view.accessibilityLabel = CCATitleForKind(self.kind);
        controller.view.accessibilityValue = CCAStatusForKind(self.kind);
        if ([controller isKindOfClass:[CCUILabeledRoundButtonViewController class]]) {
            CCUILabeledRoundButtonViewController *buttonController = (CCUILabeledRoundButtonViewController *)controller;
            buttonController.glyphImage = CCAIconForKind(self.kind);
            buttonController.highlightColor = self.selectedColor;
            buttonController.title = CCATitleForKind(self.kind);
            buttonController.subtitle = CCAStatusForKind(self.kind);
            buttonController.glyphState = self.glyphState;
            buttonController.enabled = YES;
            buttonController.button.selected = CCAStateForKind(self.kind);
            buttonController.buttonContainer.buttonView.selected = CCAStateForKind(self.kind);
        }
    }
    return controller;
}
- (UIImage *)iconGlyph { return CCAIconForKind(self.kind); }
- (UIImage *)selectedIconGlyph { return CCAIconForKind(self.kind); }
- (UIColor *)selectedColor { return UIColor.systemBlueColor; }
- (BOOL)isSelected { return CCAStateForKind(self.kind); }
- (BOOL)selected { return [self isSelected]; }
- (void)setSelected:(BOOL)selected {
    BOOL changed = CCAToggleKind(self.kind, selected);
    if (changed) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self refreshState];
            UIViewController *controller = self.contentViewController;
            controller.view.accessibilityValue = CCAStatusForKind(self.kind);
        });
    }
    [super setSelected:CCAStateForKind(self.kind)];
}
- (void)buttonTapped:(__unused UIControl *)button {
    if (self.kind == CCAConnectivityKindAirDrop) {
        UIViewController *controller = self.contentViewController;
        SEL transition = @selector(shouldBeginTransitionToExpandedContentModule);
        if ([controller respondsToSelector:transition]) ((BOOL (*)(id, SEL))objc_msgSend)(controller, transition);
        return;
    }
    [self setSelected:!CCAStateForKind(self.kind)];
}
- (void)refreshState {
    [super setSelected:CCAStateForKind(self.kind)];
    UIViewController *controller = self.contentViewController;
    controller.view.accessibilityLabel = CCATitleForKind(self.kind);
    controller.view.accessibilityValue = CCAStatusForKind(self.kind);
    if ([controller isKindOfClass:[CCUILabeledRoundButtonViewController class]]) {
        CCUILabeledRoundButtonViewController *buttonController = (CCUILabeledRoundButtonViewController *)controller;
        buttonController.title = CCATitleForKind(self.kind);
        buttonController.subtitle = CCAStatusForKind(self.kind);
        buttonController.glyphState = self.glyphState;
        buttonController.glyphImage = CCAIconForKind(self.kind);
        buttonController.highlightColor = self.selectedColor;
        buttonController.button.selected = CCAStateForKind(self.kind);
        buttonController.buttonContainer.buttonView.selected = CCAStateForKind(self.kind);
    }
}
- (NSString *)glyphState {
    return self.selected ? @"on" : @"off";
}
@end

@interface CCAAirplaneModule : CCAConnectivityBaseModule @end
@implementation CCAAirplaneModule
- (instancetype)init { return [super initWithKind:CCAConnectivityKindAirplane]; }
@end

@interface CCAWiFiModule : CCAConnectivityBaseModule @end
@implementation CCAWiFiModule
- (instancetype)init { return [super initWithKind:CCAConnectivityKindWiFi]; }
@end

@interface CCAAirDropModule : CCAConnectivityBaseModule @end
@implementation CCAAirDropModule
- (instancetype)init { return [super initWithKind:CCAConnectivityKindAirDrop]; }
@end

@interface CCACellularDataModule : CCAConnectivityBaseModule @end
@implementation CCACellularDataModule
- (instancetype)init { return [super initWithKind:CCAConnectivityKindCellular]; }
@end

@interface CCABluetoothModule : CCAConnectivityBaseModule @end
@implementation CCABluetoothModule
- (instancetype)init { return [super initWithKind:CCAConnectivityKindBluetooth]; }
@end

@interface CCAHotspotModule : CCAConnectivityBaseModule @end
@implementation CCAHotspotModule
- (instancetype)init { return [super initWithKind:CCAConnectivityKindHotspot]; }
@end

@interface CCAVPNModule : CCAConnectivityBaseModule @end
@implementation CCAVPNModule
- (instancetype)init { return [super initWithKind:CCAConnectivityKindVPN]; }
@end

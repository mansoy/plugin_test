#import "TxDeviceIdPlugin.h"
#if __has_include(<tx_device_id/tx_device_id-Swift.h>)
#import <tx_device_id/tx_device_id-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tx_device_id-Swift.h"
#endif

@implementation TxDeviceIdPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTxDeviceIdPlugin registerWithRegistrar:registrar];
}
@end

#import "FlutterPaypalPlugin.h"
#import "TPaypalHandler.h"


NSString *const registerPaypal = @"registerPayPal";
NSString *const sendPaypal = @"sendPayPal";

@interface FlutterPaypalPlugin ()

@property (nonatomic, strong) TPaypalHandler *paypalHandler;


@end

@implementation FlutterPaypalPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"com.xzkj/flutter_paypal"
                                     binaryMessenger:[registrar messenger]];
    FlutterPaypalPlugin* instance = [[FlutterPaypalPlugin alloc] initWithOtherHandler];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithOtherHandler
{
    self = [super init];
    if (self) {
        _paypalHandler = [[TPaypalHandler alloc] init];
    }
    return self;
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    if ([registerPaypal isEqualToString:call.method]) {
        // 注册贝宝
        [_paypalHandler registerWithCall:call result:result];
    }
    else  if([sendPaypal isEqualToString:call.method]) {
         // 发起支付
        [_paypalHandler paymentWithCall:call result:result];
    }
    else  if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }else {
        result(FlutterMethodNotImplemented);
    }
    
}

@end

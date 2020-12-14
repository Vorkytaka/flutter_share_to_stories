#import "FlutterShareToStoriesPlugin.h"

@implementation FlutterShareToStoriesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_share_to_stories"
            binaryMessenger:[registrar messenger]];
  FlutterShareToStoriesPlugin* instance = [[FlutterShareToStoriesPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

}

@end

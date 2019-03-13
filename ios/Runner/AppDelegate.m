#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "VideoViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    FlutterViewController *controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel *videoChannel = [FlutterMethodChannel methodChannelWithName:@"menu.flutter.io/video" binaryMessenger:controller];
    [videoChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {

//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
//        imgView.image = [UIImage imageNamed:@"emoji_heart_eye.png"];
//        [controller.view addSubview:imgView];
        
        VideoViewController *videoVC = [[VideoViewController alloc] initWithNibName:NSStringFromClass([VideoViewController class]) bundle:[NSBundle mainBundle]];
        
        videoVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [controller presentViewController:videoVC animated:YES completion:nil];
        
        result(@"success");
    }];
    
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


- (void)setVideoSignedCookie {
    
}

@end

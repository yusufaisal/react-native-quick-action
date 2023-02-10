//
//  RNQuickAction.m
//  RNQuickAction
//
//  Created by Jordan Byron on 9/26/15.
//  Copyright © 2015 react-native. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(RNShortcuts, RCTEventEmitter)

RCT_EXTERN_METHOD(
    setShortcuts:(NSArray *)shortcutItems
    resolve:(RCTPromiseResolveBlock)resolve
    reject:(RCTPromiseRejectBlock)
)

RCT_EXPORT_METHOD(isSupported:(RCTResponseSenderBlock)callback)
{
    BOOL supported = NO;
       NSString *systemVersion = [UIDevice currentDevice].systemVersion;
       if (systemVersion.doubleValue >= 13.0) {
           supported = YES;
       } else { 
           supported = [[UIApplication sharedApplication].delegate.window.rootViewController.traitCollection forceTouchCapability] == UIForceTouchCapabilityAvailable;
       }
       callback(@[[NSNull null], [NSNumber numberWithBool:supported]]);
}

RCT_EXPORT_METHOD(clearShortcutItems)
{
    [UIApplication sharedApplication].shortcutItems = nil;
}

@end

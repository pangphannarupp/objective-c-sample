//
//  ApplicationPlugin.m
//  sample
//
//  Created by Pang Phanna on 28/3/23.
//

#import <stdlib.h>
#import <Foundation/Foundation.h>
#import "ApplicationPlugin.h"
#import "Util.h"

@implementation ApplicationPlugin

- (void)execute:(NSDictionary *)param {
    NSLog(@"ApplicationPlugin => param => %@", param);
    
    NSString *type = [param objectForKey:@"type"];
    
    if([type isEqual:@"app_info"]) {
        [self getAppInfo];
    } else if([type isEqual:@"exit"]) {
        [self exit];
    } else if([type isEqual:@"open_app_setting"]) {
        [self openAppSetting];
    } else {
        
    }
}

-(void)getAppInfo {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *appBuildVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    NSString *region = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    // Get the current device
    UIDevice *device = [UIDevice currentDevice];
    NSString *osVersion = [device systemVersion];
    NSString *modelName = [device model];
    NSString *localizedModel = [device localizedModel];
    NSLog(@"Localized Model: %@", localizedModel);
    
    Util *util = [[Util alloc] init];
    [util showDialog:self.viewController message:@{
        @"result": @YES,
        @"app_name": appName,
        @"app_version": appVersion,
        @"app_build_version": appBuildVersion,
        @"app_id": bundleID,
        @"language": language,
        @"region": region,
        @"os": @"iOS",
        @"os_version": osVersion,
        @"model": localizedModel,
    }];
}

-(void)exit {
    exit(0);
}

-(void)openAppSetting {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end

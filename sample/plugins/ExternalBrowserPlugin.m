//
//  ExternalBrowserPlugin.m
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import "ExternalBrowserPlugin.h"

@implementation ExternalBrowserPlugin

- (void)execute:(NSDictionary *)param {
    NSLog(@"ExternalBrowserPlugin => param => %@", param);
    
    NSString *urlString = [param objectForKey:@"url"];
    if(urlString == nil) {
        self.util = [[Util alloc] init];
        [self.util showDialog:self.viewController message:@{
            @"result": @NO,
            @"errorCode": @"-1",
            @"errorMessage": @"No parameter",
        }];
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];

    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

@end

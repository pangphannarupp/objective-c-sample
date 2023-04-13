//
//  Util.m
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "DialogPlugin.h"

@implementation Util

- (void)showDialog:(UIViewController *)viewController message:(NSDictionary *)message {
    DialogPlugin *plugin = [[DialogPlugin alloc] init];
    plugin.viewController = viewController;
    NSDictionary *param = @{
        @"type": @"alert",
        @"title": @"Result",
        @"message": [NSString stringWithFormat:@"%@", message]
    };
    [plugin execute: param];
}

@end

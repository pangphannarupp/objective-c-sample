//
//  ToastPlugin.m
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import "ToastPlugin.h"

@implementation ToastPlugin

- (void)execute:(NSDictionary *)param {
    NSLog(@"ToastPlugin => param => %@", param);
    
    NSString *message = [param objectForKey: @"message"];
    if(message == nil) message = @"";
    
    // Create a new alert controller
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];

    // Set the duration of the toast message (in seconds)
    double duration = 1.0;

    // Show the alert controller
    [self.viewController presentViewController:alert animated:YES completion:nil];

    // Dismiss the alert controller after the specified duration
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

@end

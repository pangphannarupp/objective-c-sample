//
//  BiometricPlugin.m
//  sample
//
//  Created by Pang Phanna on 22/3/23.
//

#import <Foundation/Foundation.h>
#import "BiometricPlugin.h"
#import "Util.h"

@implementation BiometricPlugin

//Util *util;

- (void)execute:(NSDictionary *)param {
    NSLog(@"BiometricPlugin => param => %@", param);
    
    Util *util = [[Util alloc] init];
    // Create a local authentication context
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    // Check if the device supports biometric authentication
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        // Prompt the user for biometric authentication
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:@"Authenticate with your biometrics"
                            reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                // Biometric authentication succeeded
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Perform some action after successful authentication
                    NSLog(@"successful authentication");
                    [util showDialog: self.viewController message:@{
                        @"result": @YES,
                    }];
                });
            } else {
                // Biometric authentication failed
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Display an error message to the user
                    NSLog(@"error message to the user");
                    [util showDialog: self.viewController message:@{
                        @"result": @NO,
                        @"errorCode": @"-1",
                        @"errorMessage": @"authentication failed"
                    }];
                });
            }
        }];
    } else {
        // Biometric authentication is not available
        dispatch_async(dispatch_get_main_queue(), ^{
            // Display an error message to the user
            NSLog(@"authentication is not available");
            [util showDialog: self.viewController message:@{
                @"result": @NO,
                @"errorCode": @"-2",
                @"errorMessage": @"authentication is not available"
            }];
        });
    }
}

@end

//
//  BiometricPlugin.m
//  sample
//
//  Created by 임재욱 on 22/3/23.
//

#import <Foundation/Foundation.h>
#import "BiometricPlugin.h"

@implementation BiometricPlugin

- (void) execute {
    NSLog(@"execute BiometricPlugin");
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
                });
            } else {
                // Biometric authentication failed
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Display an error message to the user
                    NSLog(@"error message to the user");
                });
            }
        }];
    } else {
        // Biometric authentication is not available
        dispatch_async(dispatch_get_main_queue(), ^{
            // Display an error message to the user
            NSLog(@"error message to the user");
        });
    }
}

@end

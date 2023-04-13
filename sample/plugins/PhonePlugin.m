//
//  PhonePlugin.m
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import "PhonePlugin.h"

@implementation PhonePlugin

- (void)execute:(NSDictionary *)param {
    NSLog(@"PhonePlugin => param => %@", param);
    
    self.util = [[Util alloc] init];
    
    NSString *type = [param objectForKey:@"type"];
    
    if([type isEqual:@"call"]) {
        NSString *number = [param objectForKey:@"number"];
        if(number != nil) {
            [self call:number];
        } else {
            [self.util showDialog:self.viewController message:@{
                @"result": @NO,
                @"errorCode": @"-1",
                @"errorMessage": @"Wrong parameter",
            }];
        }
    } else if([type isEqual:@"sms"]) {
        NSString *number = [param objectForKey:@"number"];
        if(number != nil) {
            NSString *message = [param objectForKey:@"message"];
            if(message == nil) message = @"";
            [self sms:number message:message];
        } else {
            [self.util showDialog:self.viewController message:@{
                @"result": @NO,
                @"errorCode": @"-1",
                @"errorMessage": @"Wrong parameter",
            }];
        }
    } else {
        [self.util showDialog:self.viewController message:@{
            @"result": @NO,
            @"errorCode": @"-2",
            @"errorMessage": @"No implementation",
        }];
    }
}

-(void)call:(NSString *)number {
    NSString *phoneNumber = number;
    NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
    [[UIApplication sharedApplication] openURL:phoneURL options:@{} completionHandler:nil];
}

-(void)sms:(NSString *)number message:(NSString *)message {
    // Check if SMS is available on the device
    if([MFMessageComposeViewController canSendText]) {
        // Create a new message composer view controller
        MFMessageComposeViewController *messageComposer = [[MFMessageComposeViewController alloc] init];
        // Set the message body
        messageComposer.body = message;
        // Set the recipients
        messageComposer.recipients = @[number]; // Replace with the phone number of the recipient
        // Set the delegate
        messageComposer.messageComposeDelegate = self;
        // Present the message composer view controller
        [self.viewController presentViewController:messageComposer animated:YES completion:nil];
    } else {
        [self.util showDialog:self.viewController message:@{
            @"result": @NO,
            @"errorCode": @"-3",
            @"errorMessage": @"Cannot open messager",
        }];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    NSLog(@"result => %ld", (long)result);
    
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
    if(result == 0) {
        [self.util showDialog:self.viewController message:@{
            @"result": @NO,
            @"errorCode": @"-4",
            @"errorMessage": @"User cancels",
        }];
    } else if(result == 1) {
        [self.util showDialog:self.viewController message:@{
            @"result": @YES,
        }];
    }
}



@end

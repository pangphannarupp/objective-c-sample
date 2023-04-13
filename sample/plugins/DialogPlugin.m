//
//  DialogPlugin.m
//  sample
//
//  Created by Pang Phanna on 22/3/23.
//

#import <Foundation/Foundation.h>
#import "DialogPlugin.h"

@implementation DialogPlugin

UIActivityIndicatorView *activityIndicator;

- (void)execute:(NSDictionary *)param {
    NSLog(@"DialogPlugin => param => %@", param);
    
    NSString *type = [param objectForKey:@"type"];
    
    if([type isEqual:@"alert"]) {
        NSString *title = [param objectForKey:@"title"];
        NSString *message = [param objectForKey:@"message"];
        NSString *okText = [param objectForKey:@"ok_text"];
        if(title == nil) title = @"";
        if(message == nil) message = @"";
        if(okText == nil) okText = @"OK";
        [self alert:title message:message okText:okText];
    } else if([type isEqual:@"confirm"]) {
        NSString *title = [param objectForKey:@"title"];
        NSString *message = [param objectForKey:@"message"];
        NSString *confirmText = [param objectForKey:@"confirm_text"];
        NSString *cancelText = [param objectForKey:@"cancel_text"];
        if(title == nil) title = @"";
        if(message == nil) message = @"";
        if(confirmText == nil) confirmText = @"OK";
        if(cancelText == nil) cancelText = @"Cancel";
        [self confirm: title message:message confirmText:confirmText cancelText:cancelText];
    } else if([type isEqual:@"loading"]) {
        [self loading];
    } else if([type isEqual:@"hide_loading"]) {
        [self hideLoading];
    } else if([type isEqual:@"download"]) {
        
    } else {
        
    }
    
    
}

-(void)alert:(NSString *)title message:(NSString *)message okText:(NSString *)okText {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:okText style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"OK");
    }];
    [alert addAction:defaultAction];

    [self.viewController presentViewController:alert animated:YES completion:nil];
}

-(void)confirm:(NSString *)title message:(NSString *)message confirmText:(NSString *)confirmText cancelText:(NSString *)cancelText {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        NSLog(@"Cancel");
    }];
    [alert addAction:cancelAction];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmText style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"Confirm");
    }];
    [alert addAction:confirmAction];

    [self.viewController presentViewController:alert animated:YES completion:nil];
}

-(void)loading {
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = self.viewController.view.center;
    [self.viewController.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
}

-(void)hideLoading {
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
}

-(void)initDownload {
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"" message:@"Downloading..." preferredStyle:UIAlertControllerStyleAlert];
    
    UIView *alertView = alertCtr.view;
    self.progressbarView = [[UIProgressView alloc] initWithFrame:CGRectZero];
    self.progressbarView.translatesAutoresizingMaskIntoConstraints = false;
    [alertView addSubview:self.progressbarView];
    
    
    NSLayoutConstraint *bottomConstraint = [self.progressbarView.bottomAnchor constraintEqualToAnchor:alertView.bottomAnchor];
    [bottomConstraint setActive:YES];
    bottomConstraint.constant = -10;
    
    [[self.progressbarView.leftAnchor constraintEqualToAnchor:alertView.leftAnchor constant:10] setActive:YES];
    [[self.progressbarView.rightAnchor constraintEqualToAnchor:alertView.rightAnchor constant:-10] setActive:YES];
    
    [self.viewController presentViewController:alertCtr animated:true completion:nil];
}

-(void)setDownloadProgress:(float)progress {
    self.progressbarView.progress = progress;
}

-(void)hideDownload {
    [self.viewController dismissViewControllerAnimated:NO completion:nil];
}

@end

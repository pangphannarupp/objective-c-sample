//
//  SharePlugin.m
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import "SharePlugin.h"

@implementation SharePlugin

- (void)execute:(NSDictionary *)param {
    NSLog(@"SharePlugin => param => %@", param);
    
    NSString *type = [param objectForKey:@"type"];
    
    if([type isEqual:@"text"]) {
        NSString *text = [param objectForKey:@"text"];
        if(text != nil) {
            [self shareText:text];
        }
    } else if([type isEqual:@"link"]) {
        NSString *url = [param objectForKey:@"url"];
        if(url != nil) {
            [self shareLink:url];
        }
    } else if([type isEqual:@"image"]) {
        NSString *path = [param objectForKey:@"path"];
        if(path != nil) {
            [self shareImage:path];
        }
    } else if([type isEqual:@"file"]) {
        NSString *path = [param objectForKey:@"path"];
        if(path != nil) {
            [self shareFile:path];
        }
    } else {
        
    }
}

-(void)shareText:(NSString *)text {
    // Create a new activity view controller
    NSArray *activityItems = @[text];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];

    // Exclude some activity types (optional)
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];

    // Present the activity view controller
    [self.viewController presentViewController:activityVC animated:YES completion:nil];
}

-(void)shareLink:(NSString *) url {
    // Create a new activity view controller
    NSURL *urlToShare = [NSURL URLWithString:url];
    NSArray *activityItems = @[urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];

    // Exclude some activity types (optional)
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];

    // Present the activity view controller
    [self.viewController presentViewController:activityVC animated:YES completion:nil];
}

-(void)shareImage:(NSString *) path {
    // Create the activity view controller
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    NSArray *items = @[image];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];

    // Present the activity view controller
    [self.viewController presentViewController:activityVC animated:YES completion:nil];
}

-(void)shareFile:(NSString *) path {
    // Create the activity view controller
    NSURL *url = [NSURL fileURLWithPath:path];
    NSArray *items = @[url];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];

    // Present the activity view controller
    [self.viewController presentViewController:activityVC animated:YES completion:nil];
}

@end

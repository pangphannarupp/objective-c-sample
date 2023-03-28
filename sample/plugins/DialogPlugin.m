//
//  DialogPlugin.m
//  sample
//
//  Created by 임재욱 on 22/3/23.
//

#import <Foundation/Foundation.h>
#import "DialogPlugin.h"

@implementation DialogPlugin

- (void) execute {
    NSLog(@"execute DialogPlugin");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title" message:@"Message" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];

    [self.viewController presentViewController:alert animated:YES completion:nil];
}

@end

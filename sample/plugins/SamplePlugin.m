//
//  SamplePlugin.m
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import "SamplePlugin.h"

@implementation SamplePlugin

- (void)execute:(NSDictionary *)param {
    NSLog(@"SamplePlugin => param => %@", param);
    
    NSString *type = [param objectForKey:@"type"];
    
    if([type isEqual:@"item"]) {
        
    } else {
        
    }
}

@end

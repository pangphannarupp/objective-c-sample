//
//  PluginDelegate.m
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import "PluginDelegate.h"

@implementation PluginDelegate : NSObject

-(void)onSuccess:(id)result{
    NSLog(@"%@", result);
}

-(void)onFail:(id)result{
    NSLog(@"%@", result);
}

@end

//
//  PluginDelegate.h
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import <Foundation/Foundation.h>


@protocol PluginDelegate <NSObject>

- (void)onSuccess:(id)result;
- (void)onFail:(id)result;

@end

//
//  PluginModel.m
//  sample
//
//  Created by Pang Phanna on 22/3/23.
//

#import <Foundation/Foundation.h>
#import "PluginModel.h"

@implementation PluginModel

- (instancetype)initWithName:(NSString *)pluginName pluginClass:(Plugin *)pluginClass screen:(UIViewController *)screen param:(NSDictionary *)param {
    self = [super init];
    if (self) {
        _pluginName = pluginName;
        _pluginClass = pluginClass;
        _screen = screen;
        _param = param;
    }
    return self;
}

@end

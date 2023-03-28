//
//  PluginModel.m
//  sample
//
//  Created by 임재욱 on 22/3/23.
//

#import <Foundation/Foundation.h>
#import "PluginModel.h"

@implementation PluginModel

- (instancetype)initWithName:(NSString *)pluginName pluginClass:(Plugin *)pluginClass {
    self = [super init];
    if (self) {
        _pluginName = pluginName;
        _pluginClass = pluginClass;
    }
    return self;
}

@end

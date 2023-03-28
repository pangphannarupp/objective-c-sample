//
//  PluginModel.h
//  sample
//
//  Created by 임재욱 on 22/3/23.
//

#import <UIKit/UIKit.h>
#import "Plugin.h"

@interface PluginModel : NSObject

@property (nonatomic, strong) NSString *pluginName;
@property (nonatomic, strong) Plugin *pluginClass;

- (instancetype)initWithName:(NSString *)pluginName pluginClass:(Plugin *)pluginClass;

@end

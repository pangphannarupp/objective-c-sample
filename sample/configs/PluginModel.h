//
//  PluginModel.h
//  sample
//
//  Created by Pang Phanna on 22/3/23.
//

#import <UIKit/UIKit.h>
#import "Plugin.h"

@interface PluginModel : NSObject

@property (nonatomic, strong) NSString *pluginName;
@property (nonatomic, strong) Plugin *pluginClass;
@property (nonatomic, strong) UIViewController *screen;
@property (nonatomic, strong) NSDictionary *param;

- (instancetype)initWithName:(NSString *)pluginName pluginClass:(Plugin *)pluginClass screen:(UIViewController *)screen param:(NSDictionary *)param;

@end

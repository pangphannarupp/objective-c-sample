//
//  Plugin.h
//  sample
//
//  Created by Pang Phanna on 22/3/23.
//

#import <UIKit/UIKit.h>
#import "PluginDelegate.h"
#import "Util.h"

@interface Plugin : NSObject

@property (nonatomic, strong) Util *util;
@property (nonatomic, strong) UIViewController *viewController;
@property(nonatomic, weak)id <PluginDelegate> delegate;

//- (instancetype)setViewController:(NSString *)pluginName pluginClass:(Plugin *)pluginClass;
- (void) execute:(NSDictionary *)param;

@end

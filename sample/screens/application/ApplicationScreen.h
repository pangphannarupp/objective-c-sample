//
//  ApplicationScreen.h
//  sample
//
//  Created by Pang Phanna on 28/3/23.
//

#import <UIKit/UIKit.h>
#import "ApplicationPlugin.h"

@interface ApplicationScreen: UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) ApplicationPlugin *plugin;

@end

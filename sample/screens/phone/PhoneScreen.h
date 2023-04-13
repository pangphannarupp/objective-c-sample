//
//  PhoneScreen.h
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import <Foundation/Foundation.h>
#import "PhonePlugin.h"

@interface PhoneScreen : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) PhonePlugin *plugin;

@end

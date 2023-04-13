//
//  ShareScreen.h
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import <Foundation/Foundation.h>
#import "SharePlugin.h"

@interface ShareScreen : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) SharePlugin *plugin;

@end

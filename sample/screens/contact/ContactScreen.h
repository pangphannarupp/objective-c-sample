//
//  ContactScreen.h
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import <Foundation/Foundation.h>
#import "ContactPlugin.h"

@interface ContactScreen : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) ContactPlugin *plugin;

@end

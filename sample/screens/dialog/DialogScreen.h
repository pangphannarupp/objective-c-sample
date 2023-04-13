//
//  DialogScreen.h
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DialogPlugin.h"

@interface DialogScreen : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) DialogPlugin *plugin;

@end


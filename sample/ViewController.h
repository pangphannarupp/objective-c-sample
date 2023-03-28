//
//  ViewController.h
//  sample
//
//  Created by 임재욱 on 22/3/23.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *pluginList;

@end


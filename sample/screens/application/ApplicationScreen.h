//
//  ApplicationScreen.h
//  sample
//
//  Created by 임재욱 on 28/3/23.
//

#import <UIKit/UIKit.h>

@interface ApplicationScreen: UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *itemList;

@end

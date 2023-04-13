//
//  ApplicationScreen.m
//  sample
//
//  Created by Pang Phanna on 28/3/23.
//

#import <Foundation/Foundation.h>
#import "ApplicationScreen.h"

@implementation ApplicationScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.plugin = [[ApplicationPlugin alloc] init];
    
    self.title = @"Application";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create the table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.itemList = @[
        @"App Info",
        @"Exit",
        @"Open App Setting"
    ];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.itemList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    switch(indexPath.row) {
        case 0:
            [param setValue: @"app_info" forKey: @"type"];
        break;
        case 1:
            [param setValue: @"exit" forKey: @"type"];
        break;
        case 2:
            [param setValue: @"open_app_setting" forKey: @"type"];
        break;
        default:
        break;
    }
    self.plugin.viewController = self;
    [self.plugin execute: param];
}

@end

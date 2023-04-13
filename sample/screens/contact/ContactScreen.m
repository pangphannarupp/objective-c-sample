//
//  ContactScreen.m
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import "ContactScreen.h"

@implementation ContactScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.plugin = [[ContactPlugin alloc] init];
    
    self.title = @"Contact";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create the table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.itemList = @[
        @"Get",
        @"Open",
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
            [param setValue: @"get" forKey: @"type"];
            break;
        case 1:
            [param setValue: @"open" forKey: @"type"];
            break;
        default:
            break;
    }
    self.plugin.viewController = self;
    [self.plugin execute: param];
}

@end

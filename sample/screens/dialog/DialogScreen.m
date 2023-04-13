//
//  DialogScreen.m
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import "DialogScreen.h"

@implementation DialogScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.plugin = [[DialogPlugin alloc] init];
    
    self.title = @"Dialog";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create the table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.itemList = @[
        @"Alert",
        @"Confirm",
        @"Loading",
        @"Hide Loading",
        @"Download"
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
            [param setValue: @"alert" forKey: @"type"];
            [param setValue: @"Add data successfully" forKey: @"message"];
        break;
        case 1:
            [param setValue: @"confirm" forKey: @"type"];
            [param setValue: @"Do you want to remove this data?" forKey: @"message"];
        break;
        case 2:
            [param setValue: @"loading" forKey: @"type"];
        break;
        case 3:
            [param setValue: @"hide_loading" forKey: @"type"];
        break;
        case 4:
            [param setValue: @"download" forKey: @"type"];
        break;
        default:
        break;
    }
    self.plugin.viewController = self;
    [self.plugin execute: param];
}


@end

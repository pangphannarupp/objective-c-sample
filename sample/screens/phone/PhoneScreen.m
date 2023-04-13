//
//  PhoneScreen.m
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import "PhoneScreen.h"

@implementation PhoneScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.plugin = [[PhonePlugin alloc] init];
    
    self.title = @"Phone";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create the table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.itemList = @[
        @"Call",
        @"SMS",
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
            [param setValue: @"call" forKey: @"type"];
            [param setValue: @"093980226" forKey: @"number"];
            break;
        case 1:
            [param setValue: @"sms" forKey: @"type"];
            [param setValue: @"093980226" forKey: @"number"];
            [param setValue: @"Hello" forKey: @"message"];
            break;
        default:
            break;
    }
    self.plugin.viewController = self;
    [self.plugin execute: param];
}

@end

//
//  ShareScreen.m
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import "ShareScreen.h"

@implementation ShareScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.plugin = [[SharePlugin alloc] init];
    
    self.title = @"Share";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create the table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.itemList = @[
        @"Text",
        @"Link",
//        @"Image",
//        @"File",
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
            [param setValue: @"text" forKey: @"type"];
            [param setValue: @"Hello Text" forKey: @"text"];
            break;
        case 1:
            [param setValue: @"link" forKey: @"type"];
            [param setValue: @"https://youtube.com" forKey: @"url"];
            break;
        case 2:
            [param setValue: @"image" forKey: @"type"];
            [param setValue: @"/private/var/mobile/Containers/Data/Application/87917D42-770F-44C2-8BF1-FAB811816189/tmp/D2F22351-127F-4508-BDF5-86AF45835D93.png" forKey: @"path"];
            break;
        case 3:
            [param setValue: @"file" forKey: @"type"];
            [param setValue: @"/private/var/mobile/Containers/Data/Application/54B4CBC9-97AE-4918-9423-44FA5D0AD6B9/tmp/phanna.app.sample-Inbox/book.pdf" forKey: @"path"];
            break;
        default:
            break;
    }
    self.plugin.viewController = self;
    [self.plugin execute: param];
}

@end

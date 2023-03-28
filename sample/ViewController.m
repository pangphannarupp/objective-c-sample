//
//  ViewController.m
//  sample
//
//  Created by 임재욱 on 22/3/23.
//

#import "ViewController.h"
#import "configs/PluginModel.h"
#import "BiometricPlugin.h"
#import "CameraPlugin.h"
#import "DialogPlugin.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create the table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.pluginList = @[
        [[PluginModel alloc] initWithName: @"Applicatoin" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Biometric" pluginClass: [[BiometricPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Bluetooth" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Camera" pluginClass: [[CameraPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Contact" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Dialog" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Download" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Encrypt & Decrypt" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"External Browser" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"External Map Viewer" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"File Browser" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"GPS" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Image Viewer" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Internal Browser" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"MP3 Player" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Network Information" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Orientation" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Phone" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"QR" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Sample" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Screenshot" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Share" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Shortcut" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Speech Recognizer" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Storage" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Toast Message" pluginClass: [[DialogPlugin alloc] init]],
        [[PluginModel alloc] initWithName: @"Web Content" pluginClass: [[DialogPlugin alloc] init]],
    ];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pluginList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    PluginModel *model = self.pluginList[indexPath.row];
    cell.textLabel.text = [model pluginName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PluginModel *model = self.pluginList[indexPath.row];
    Plugin *plugin = [model pluginClass];
    plugin.viewController = self;
    [plugin execute];
}

@end

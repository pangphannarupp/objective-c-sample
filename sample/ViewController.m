//
//  ViewController.m
//  sample
//
//  Created by Pang Phanna on 22/3/23.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewController = self;
    
    self.title = @"Objective-C";
    
    // Create the table view
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.pluginList = @[
        [[PluginModel alloc]
         initWithName: @"Application"
         pluginClass: nil
         screen: [[ApplicationScreen alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Biometric"
         pluginClass: [[BiometricPlugin alloc] init]
         screen: nil
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Bluetooth"
         pluginClass: nil
         screen: [[UIViewController alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Camera"
         pluginClass: [[CameraPlugin alloc] init]
         screen: nil
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Contact"
         pluginClass: nil
         screen: [[ContactScreen alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Dialog"
         pluginClass: nil
         screen: [[DialogScreen alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Download"
         pluginClass: [[DownloadPlugin alloc] init]
         screen: nil
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Encrypt & Decrypt"
         pluginClass: nil
         screen: [[UIViewController alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"External Browser"
         pluginClass: [[ExternalBrowserPlugin alloc] init]
         screen: nil
         param: @{
            @"url": @"https://youtube.com"
        }],
        [[PluginModel alloc]
         initWithName: @"External Map Viewer"
         pluginClass: [[DialogPlugin alloc] init]
         screen: nil
         param: nil],
        [[PluginModel alloc]
         initWithName: @"File Browser"
         pluginClass: [[FileBrowserPlugin alloc] init]
         screen: nil
         param: nil],
        [[PluginModel alloc]
         initWithName: @"GPS"
         pluginClass: [[GPSPlugin alloc] init]
         screen: nil
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Image Browser"
         pluginClass: [[ImageBrowserPlugin alloc] init]
         screen: nil
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Image Viewer"
         pluginClass: nil
         screen: [[UIViewController alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Internal Browser"
         pluginClass: nil
         screen: [[UIViewController alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"MP3 Player"
         pluginClass: nil
         screen: [[UIViewController alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Network Information"
         pluginClass: [[DialogPlugin alloc] init]
         screen: nil
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Orientation"
         pluginClass: nil
         screen: [[UIViewController alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Phone"
         pluginClass: nil
         screen: [[PhoneScreen alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"QR"
         pluginClass: nil
         screen: [[QRScannerScreen alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Sample"
         pluginClass: nil
         screen: [[SampleScreen alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Screenshot"
         pluginClass: [[DialogPlugin alloc] init]
         screen: nil
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Share"
         pluginClass: nil
         screen: [[ShareScreen alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Shortcut"
         pluginClass: nil
         screen: [[UIViewController alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Speech Recognizer"
         pluginClass: nil
         screen: [[UIViewController alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Storage"
         pluginClass: nil
         screen: [[UIViewController alloc] init]
         param: nil],
        [[PluginModel alloc]
         initWithName: @"Toast Message"
         pluginClass: [[ToastPlugin alloc] init]
         screen: nil
         param: @{
            @"message": @"សួស្ដី Objective-C!"
        }],
//        [[PluginModel alloc]
//         initWithName: @"Web Content"
//         pluginClass: nil
//         screen: [[UIViewController alloc] init]
//         param: nil],
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
    if(model.screen) {
        // Create the root view controller
        UIViewController *rootViewController = [model screen];
        // Create the navigation controller and set its root view controller
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
        
        // Customize the appearance of the navigation bar
        NSDictionary *titleAttributes = @{ NSForegroundColorAttributeName: [UIColor blackColor],
                                            NSFontAttributeName: [UIFont systemFontOfSize:18.0] };
        navigationController.navigationBar.titleTextAttributes = titleAttributes;
        // Create a custom back button with an image
        UIImage *backButtonImage = [UIImage imageNamed:@"icon_back"];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:backButtonImage forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        backButton.frame = CGRectMake(0, 0, 40, 40);
        // Create a bar button item with the custom button
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        // Set the left bar button item of the navigation item
        navigationController.navigationItem.leftBarButtonItem = backButtonItem;
        
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.viewController presentViewController: navigationController animated: YES completion: nil];
    } else {
        Plugin *plugin = [model pluginClass];
        plugin.viewController = self;
        [plugin execute: [model param]];
    }
}

- (void)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

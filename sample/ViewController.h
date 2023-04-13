//
//  ViewController.h
//  sample
//
//  Created by Pang Phanna on 22/3/23.
//

#import <UIKit/UIKit.h>
#import "PluginDelegate.h"
#import "configs/PluginModel.h"
//Plugin
#import "BiometricPlugin.h"
#import "CameraPlugin.h"
#import "ContactPlugin.h"
#import "DialogPlugin.h"
#import "DownloadPlugin.h"
#import "ExternalBrowserPlugin.h"
#import "FileBrowserPlugin.h"
#import "GPSPlugin.h"
#import "ImageBrowserPlugin.h"
#import "ToastPlugin.h"
//Screen
#import "ApplicationScreen.h"
#import "ContactScreen.h"
#import "DialogScreen.h"
#import "PhoneScreen.h"
#import "QRScannerScreen.h"
#import "SampleScreen.h"
#import "ShareScreen.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *pluginList;
@property (nonatomic, strong) UIViewController *viewController;

@end


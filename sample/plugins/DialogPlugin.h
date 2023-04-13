//
//  DialogPlugin.h
//  sample
//
//  Created by Pang Phanna on 22/3/23.
//

#import <UIKit/UIKit.h>
#import "Plugin.h"

@interface DialogPlugin : Plugin

@property (nonatomic, strong) UIProgressView *progressbarView;
-(void)initDownload;
-(void)setDownloadProgress:(float)progress;
-(void)hideDownload;

@end

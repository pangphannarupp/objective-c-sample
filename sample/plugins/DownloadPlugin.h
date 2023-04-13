//
//  DownloadPlugin.h
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import <Foundation/Foundation.h>
#import "Plugin.h"

@interface DownloadPlugin : Plugin <NSURLSessionDelegate>

@property (nonatomic, strong) UIProgressView *progressbarView;

@end

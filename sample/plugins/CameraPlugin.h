//
//  CameraPlugin.h
//  sample
//
//  Created by Pang Phanna on 22/3/23.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "Plugin.h"

@interface CameraPlugin : Plugin <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

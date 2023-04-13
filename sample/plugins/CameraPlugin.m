//
//  CameraPlugin.m
//  sample
//
//  Created by Pang Phanna on 22/3/23.
//

#import <Foundation/Foundation.h>
#import "CameraPlugin.h"
#import "Util.h"

@implementation CameraPlugin

//Util *util;

- (void)execute:(NSDictionary *)param {
    NSLog(@"CameraPlugin => param => %@", param);
//    util = [[Util alloc] init];
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self.viewController presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    // Get the path of the image
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [[NSUUID UUID] UUIDString]]];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:path atomically:YES];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
    Util *util = [[Util alloc] init];
    [util showDialog: self.viewController message:@{
        @"result": @YES,
        @"path": path,
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
    Util *util = [[Util alloc] init];
    [util showDialog: self.viewController message:@{
        @"result": @NO,
        @"errorCode": @"-1",
        @"errorMessage": @"User cancel.",
    }];
}

@end

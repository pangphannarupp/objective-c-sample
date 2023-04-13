//
//  ImageBrowserPlugin.m
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import "ImageBrowserPlugin.h"
#import "SharePlugin.h"

@implementation ImageBrowserPlugin

- (void)execute:(NSDictionary *)param {
    NSLog(@"ImageBrowserPlugin => param => %@", param);
    
    self.util = [[Util alloc] init];
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.viewController presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSURL *url = (NSURL *)[info objectForKey:UIImagePickerControllerImageURL];
    NSString *path = [url path];
    NSLog(@"Selected image path: %@", path);
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
    Util *util = [[Util alloc] init];
    [util showDialog: self.viewController message:@{
        @"result": @YES,
        @"path": path,
    }];
    
//    self.viewController.view.translatesAutoresizingMaskIntoConstraints = NO;
//    SharePlugin *plugin = [[SharePlugin alloc] init];
//    plugin.viewController = self.viewController;
//    [plugin execute:@{
//        @"type": @"image",
//        @"path": path,
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.util showDialog: self.viewController message:@{
        @"result": @NO,
        @"errorCode": @"-1",
        @"errorMessage": @"User cancel.",
    }];
}

@end

//
//  FileBrowserPlugin.m
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import "FileBrowserPlugin.h"
#import "SharePlugin.h"

@implementation FileBrowserPlugin

- (void)execute:(NSDictionary *)param {
    NSLog(@"FileBrowserPlugin => param => %@", param);
    
    self.util = [[Util alloc] init];
    
    UIDocumentPickerViewController *documentPickerVC = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.item"] inMode:UIDocumentPickerModeImport];
    documentPickerVC.delegate = self;
    documentPickerVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.viewController presentViewController:documentPickerVC animated:YES completion:nil];
    
}

#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    // Use the selected file URL here
    NSData *data = [[url path] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithUTF8String:[data bytes]];
    NSLog(@"url => %@", path);
    
    [self.util showDialog: self.viewController message:@{
        @"result": @YES,
        @"path": [url path],
    }];
    
//    SharePlugin *plugin = [[SharePlugin alloc] init];
//    plugin.viewController = self.viewController;
//    [plugin execute:@{
//        @"type": @"file",
//        @"path": path,
//    }];
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    [self.util showDialog: self.viewController message:@{
        @"result": @NO,
        @"errorCode": @"-1",
        @"errorMessage": @"User cancel.",
    }];
}

@end

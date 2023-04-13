//
//  DownloadPlugin.m
//  sample
//
//  Created by Pang Phanna on 12/4/23.
//

#import "DownloadPlugin.h"
#import "DialogPlugin.h"
#import "Util.h"

@implementation DownloadPlugin

DialogPlugin *plugin;

- (void)execute:(NSDictionary *)param {
    NSLog(@"DownloadPlugin => param => %@", param);
    
    plugin = [[DialogPlugin alloc] init];
    plugin.viewController = self.viewController;
    
    //    //download the file in a seperate thread.
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        NSLog(@"Downloading Started");
    //        NSString *urlToDownload = @"http://ebook.bmoon.club/uploads/83234_1_Longman_Grammar_Practice_for_Elementary.pdf";
    //        NSURL *url = [NSURL URLWithString:urlToDownload];
    //        NSData *urlData = [NSData dataWithContentsOfURL:url];
    //        NSString *fileName = [urlToDownload lastPathComponent];
    //        NSLog(@"urlData %@", urlData);
    //        if (urlData) {
    //            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //            NSString *documentsDirectory = [paths objectAtIndex:0];
    //
    //            NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    //
    //            //saving is done on main thread
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                [urlData writeToFile:filePath atomically:YES];
    //                NSLog(@"File Saved !");
    //            });
    //        }
    //
    //    });
    
    // Create a NSURLSession object with a delegate
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    // Create a NSURLSessionDownloadTask with the URL to download
    NSURL *url = [NSURL URLWithString:@"http://ebook.bmoon.club/uploads/83234_1_Longman_Grammar_Practice_for_Elementary.pdf"];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    
    // Start the download
    [downloadTask resume];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addProgressBarView];
//        [plugin initDownload];
    });
}

// Implement the NSURLSessionDownloadDelegate methods to receive progress updates and handle completion
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // Handle completion
    NSLog(@"Download completed");
//    NSLog(@"location => %@", [location baseURL]);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController dismissViewControllerAnimated:NO completion:nil];
//        [plugin hideDownload];
        
//        Util *util = [[Util alloc] init];
//        [util showDialog:self.viewController message: @{
//            @"result": @YES,
////            @"path": [location baseURL],
//        }];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // Calculate progress percentage
    float progress = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressbarView.progress = progress;
//        [plugin setDownloadProgress:progress];
    });
    
    // Update UI or log progress
    NSLog(@"Download progress: %@", [NSString stringWithFormat:@"%.0f%%", progress * 100]);
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // Handle errors
    NSLog(@"error => %@", error);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController dismissViewControllerAnimated:NO completion:nil];
//        [plugin hideDownload];
        
        Util *util = [[Util alloc] init];
        [util showDialog:self.viewController message: @{
            @"result": @NO,
            @"errorCode": [NSString stringWithFormat:@"%ld", (long)error.code],
            @"errorMessage": error.localizedDescription,
        }];
    });
}

-(void)addProgressBarView{
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"" message:@"Downloading..." preferredStyle:UIAlertControllerStyleAlert];
    
    UIView *alertView = alertCtr.view;
    self.progressbarView = [[UIProgressView alloc] initWithFrame:CGRectZero];
    self.progressbarView.translatesAutoresizingMaskIntoConstraints = false;
    [alertView addSubview:self.progressbarView];
    
    
    NSLayoutConstraint *bottomConstraint = [self.progressbarView.bottomAnchor constraintEqualToAnchor:alertView.bottomAnchor];
    [bottomConstraint setActive:YES];
    bottomConstraint.constant = -10;
    
    [[self.progressbarView.leftAnchor constraintEqualToAnchor:alertView.leftAnchor constant:10] setActive:YES];
    [[self.progressbarView.rightAnchor constraintEqualToAnchor:alertView.rightAnchor constant:-10] setActive:YES];
    
    [self.viewController presentViewController:alertCtr animated:true completion:nil];
}

@end

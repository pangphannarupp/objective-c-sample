//
//  QRScannerScreen.h
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface QRScannerScreen : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

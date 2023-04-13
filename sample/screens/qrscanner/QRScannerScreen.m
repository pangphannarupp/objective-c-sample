//
//  QRScannerScreen.m
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import "QRScannerScreen.h"

@implementation QRScannerScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a new AVCaptureSession object
    self.captureSession = [[AVCaptureSession alloc] init];
    // Create a new AVCaptureDevice object for the back camera
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Create a new AVCaptureDeviceInput object using the back camera
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    // Create a new AVCaptureMetadataOutput object to capture metadata
    self.output = [[AVCaptureMetadataOutput alloc] init];
    // Set the metadata output's delegate to the view controller
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // Add the metadata output to the session
    [self.captureSession addOutput:self.output];
    // Set the session's sessionPreset to AVCaptureSessionPresetHigh
    [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    // Set the session's input to the device input
    [self.captureSession addInput:self.input];
    // Create a new AVCaptureVideoPreviewLayer object
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    // Add the preview layer to your view
    CALayer *rootLayer = [[self view] layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth([[self view] frame]), CGRectGetHeight([[self view] frame]));
    [self.previewLayer setFrame:frame];
    [rootLayer insertSublayer:self.previewLayer atIndex:0];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Start the capture session
        [self.captureSession startRunning];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.captureSession stopRunning];
//    [self.previewLayer removeFromSuperlayer];
    for (AVCaptureInput *input in self.captureSession.inputs) {
        [self.captureSession removeInput:input];
    }
    for (AVCaptureOutput *output in self.captureSession.outputs) {
        [self.captureSession removeOutput:output];
    }
    self.input = nil;
    self.output = nil;
    self.previewLayer = nil;
    self.captureSession = nil;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // Loop through all the metadata objects returned by the scanner
    for (AVMetadataObject *metadataObject in metadataObjects) {
        // Check if the object is a QR code
        if ([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            // Cast the object to an AVMetadataMachineReadableCodeObject to get the actual content of the QR code
            AVMetadataMachineReadableCodeObject *readableObject = (AVMetadataMachineReadableCodeObject *)metadataObject;
            NSString *qrCode = readableObject.stringValue;
            NSLog(@"Scanned QR code: %@", qrCode);
            
            // Do something with the QR code (e.g., display it in a label)
            //self.qrCodeLabel.text = qrCode;
            
            // Stop scanning
            [self.captureSession stopRunning];
        }
    }
}

@end

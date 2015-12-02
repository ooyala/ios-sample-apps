/**
 * @class      QRScannerViewController QRScannerViewController.m "QRScannerViewController.m"
 * @brief      A QR scanner that can read embed code/pcode from a QR code
 * @details    two formats are supported 
 *             1. EmbedCode: e.g. Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1
 *             2. EmbedCode;pcode: e.g. Y1ZHB1ZDqfhCPjYYRbCEOz0GR8IsVRm1;R2d3I6s06RyB712DN0_2GsQS-R-Y
 * @date       11/16/15
 * @copyright  Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */


#import "QRScannerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRScannerViewController()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end


@implementation QRScannerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  // Initially make the captureSession object nil.
  _captureSession = nil;
}

- (void)viewDidAppear:(BOOL)animated {
  if ([self startReading]) {
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  [self stopReading];
}

#pragma mark - Private method implementation

- (BOOL)startReading {
  NSError *error;

  // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
  // as the media type parameter.
  AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

  // Get an instance of the AVCaptureDeviceInput class using the previous device object.
  AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];

  if (!input) {
    // If any error occurs, simply log the description of it and don't continue any more.
    NSLog(@"%@", [error localizedDescription]);
    return NO;
  }

  // Initialize the captureSession object.
  _captureSession = [[AVCaptureSession alloc] init];
  // Set the input device on the capture session.
  [_captureSession addInput:input];


  // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
  AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
  [_captureSession addOutput:captureMetadataOutput];

  // Create a new serial dispatch queue.
  dispatch_queue_t dispatchQueue;
  dispatchQueue = dispatch_queue_create("myQueue", NULL);
  [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
  [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];

  // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
  _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
  [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
  [_videoPreviewLayer setFrame:self.view.layer.bounds];
  [self.view.layer addSublayer:_videoPreviewLayer];


  // Start video capture.
  [_captureSession startRunning];

  return YES;
}


-(void)stopReading{
  if (self.captureSession) {
    [self.captureSession stopRunning];
    self.captureSession = nil;

    // Remove the video preview layer from the viewPreview view's layer.
    [self.videoPreviewLayer removeFromSuperlayer];
  }
}

- (void)loadVideoView {
  if (self.captureSession) {
    [self stopReading];
  }
  SampleAppPlayerViewController *controller = [(SampleAppPlayerViewController *)[[self.playerSelectionOption viewController] alloc] initWithPlayerSelectionOption:self.playerSelectionOption];
  [self.navigationController pushViewController:controller animated:YES];
}

- (void)processScanResults:(NSString *)results {
  NSArray *stringArray = [results componentsSeparatedByString:@";"];
  if (stringArray.count > 0) {
    self.playerSelectionOption.embedCode = stringArray[0];
  }

  if (stringArray.count > 1) {
    self.playerSelectionOption.pcode = stringArray[1];
  }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{

  // Check if the metadataObjects array is not nil and it contains at least one object.
  if (metadataObjects != nil && [metadataObjects count] > 0) {
    // Get the metadata object.
    AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
    if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
      // If the found metadata is equal to the QR code metadata then update the status label's text,
      // stop reading and change the bar button item's title and the flag's value.
      // Everything is done on the main thread.
      [self processScanResults:[metadataObj stringValue]];
      [self performSelectorOnMainThread:@selector(loadVideoView) withObject:nil waitUntilDone:NO];
    }
  }
}

@end

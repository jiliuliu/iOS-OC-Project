//
//  ARScanView.m
//  iOS-OC-Project
//
//  Created by 刘吉六 on 2018/3/22.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "ARScanView.h"

@interface ARScanView () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureMetadataOutput *captureMetadataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer  *videoPreviewLayer;

@property (nonatomic, strong) dispatch_queue_t sessionQueue;
@property (nonatomic, assign) AVAuthorizationStatus authorizationStatus;

/**
 *  敏感区域,如果不设置,则为全部扫描区域
 */
@property (nonatomic) CGRect interestArea;

@end


@implementation ARScanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sessionQueue = dispatch_queue_create( "session queue", DISPATCH_QUEUE_SERIAL );
        [self setupBackgroundLayer];
    }
    return self;
}

- (void)setupBackgroundLayer {
    self.backgroundLayer = [ARScanBackgroundLayer layer];
    [self.layer addSublayer:self.backgroundLayer];
    
    _interestArea = self.backgroundLayer.polygonBounds;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (newWindow) {
        [self start];
    } else {
        [self stop];
    }
}

- (void)start {
    if (self.captureSession) {
        [self.captureSession stopRunning];
        self.captureSession = nil;
        [self.layer.sublayers.firstObject removeFromSuperlayer];
    }
    
    [self requestAccessForAVMediaTypeVideo];
    
    dispatch_async(self.sessionQueue, ^{
        [self configureSession];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupVideoPreviewLayer];
        });
    });}

- (void)stop {
    [self.captureSession stopRunning];
    self.captureSession = nil;
    [self removeNotifications];
}

- (void)requestAccessForAVMediaTypeVideo {
    self.authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (self.authorizationStatus) {
        case AVAuthorizationStatusAuthorized:
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            dispatch_suspend(self.sessionQueue);
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    self.authorizationStatus = AVAuthorizationStatusAuthorized;
                }
                dispatch_resume(self.sessionQueue);
            }];
        }
            break;
        default:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *message = NSLocalizedString( @"AVCam doesn't have permission to use the camera, please change privacy settings", @"Alert message when the user has denied access to the camera" );
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"AVCam" message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString( @"OK", @"Alert OK button" ) style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancelAction];
                // Provide quick access to Settings.
                UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString( @"Settings", @"Alert button to open Settings" ) style:UIAlertActionStyleDefault handler:^( UIAlertAction *action ) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                }];
                [alertController addAction:settingsAction];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
            });
        }
            break;
    }
}

- (void)configureSession {
    if (self.authorizationStatus != AVAuthorizationStatusAuthorized) {
        return;
    }
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    [session beginConfiguration];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"设备输入初始化失败：%@", error);
        [session commitConfiguration];
        return;
    }
    
    if ([session canAddInput:input]) {
        [session addInput:input];
    } else {
        NSLog(@"设备输入添加会话失败");
        [session commitConfiguration];
        return;
    }
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    } else {
        NSLog(@"设备输出添加会话失败");
        [session commitConfiguration];
        return;
    }
    
    [output setMetadataObjectsDelegate:self queue:dispatch_queue_create(NULL, NULL)];
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    [session commitConfiguration];
    [self addNotifications];
    
    [session startRunning];
    _captureMetadataOutput = output;
    _captureSession = session;
}

- (void)setupVideoPreviewLayer {
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    previewLayer.frame = self.bounds;
    [self.layer insertSublayer:previewLayer atIndex:0];
    _videoPreviewLayer = previewLayer;
}

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationCenterEvent:)
                                                 name:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                               object:nil];
}

- (void)removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                  object:nil];
}

- (void)notificationCenterEvent:(NSNotification *)sender {
    if (self.interestArea.size.width && self.interestArea.size.height) {
        self.captureMetadataOutput.rectOfInterest = [self.videoPreviewLayer metadataOutputRectOfInterestForRect:self.interestArea];
    } else {
        self.captureMetadataOutput.rectOfInterest = CGRectMake(0, 0, 1, 1);
    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadata = metadataObjects.firstObject;
        NSString                            *result   = nil;
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadata.stringValue;
            if (_delegate && [_delegate respondsToSelector:@selector(QRCodeView:codeString:)]) {
                [_delegate QRCodeView:self codeString:result];
            }
        }
    }
}


@end

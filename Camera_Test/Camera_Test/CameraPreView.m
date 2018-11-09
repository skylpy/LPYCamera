//
//  CameraPreView.m
//  Camera_Test
//
//  Created by aaron on 2018/11/8.
//  Copyright © 2018年 aaron. All rights reserved.
//

#import "CameraPreView.h"

@implementation CameraPreView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [(AVCaptureVideoPreviewLayer *)self.layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        
    }
    return self;
}

- (AVCaptureSession *)captureSessionsion {
    return [(AVCaptureVideoPreviewLayer *)self.layer session];
}

- (void)setCaptureSessionsion:(AVCaptureSession *)captureSessionsion {
    
    [(AVCaptureVideoPreviewLayer *)self.layer setSession:captureSessionsion];
}
// 使该view的layer方法返回AVCaptureVideoPreviewLayer对象
+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}
@end

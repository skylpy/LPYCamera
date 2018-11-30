//
//  CameraViewController.m
//  Camera_Test
//
//  Created by aaron on 2018/11/8.
//  Copyright © 2018年 aaron. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LPYCameraView.h"


@interface CameraViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate,CCCameraViewDelegate>

{
    //会话session
    AVCaptureSession * _session;
    //设备输入
    AVCaptureDeviceInput * _deviceInput;
    
    //视频输出
    AVCaptureVideoDataOutput * _videoOutput;
    //帧图片输出
    AVCaptureStillImageOutput * _imageOutput;
    
}

@property (nonatomic,strong) LPYCameraView * cameraView;

@end

@implementation CameraViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)dealloc{
    NSLog(@"相机界面销毁了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //预览图层
    self.cameraView = [[LPYCameraView alloc] initWithFrame:self.view.bounds];
    self.cameraView.delegate = self;
    [self.view addSubview:self.cameraView];
    
    //初始化信息
    NSError * error;
    [self setupSession:&error];
    if (!error) {
        //设置AVCaptureVideoPreviewLayer 预览
        [self.cameraView.previewView setCaptureSessionsion:_session];
        //开始运行
        [self startCaptureSrssion];
    }
    
}

//配置信息
- (void)setupSession:(NSError **)error{
    
    //初始化_session
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetHigh;
    
    //配置输入信息
    [self setupSessionInputs:error];
    //配置输出信息
    [self setupSessionOutputs:error];
}

//输入
- (void)setupSessionInputs:(NSError **)error {
    
    // 视频输入
    AVCaptureDevice * videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput * videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];
    if (videoInput) {
        if ([_session canAddInput:videoInput]) {
            [_session addInput:videoInput];
        }
    }
    _deviceInput = videoInput;
    
    // 音频输入
    AVCaptureDevice * audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput * audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:error];
    if ([_session canAddInput:audioInput]) {
        [_session addInput:audioInput];
    }
    
}

//c输出
-(void)setupSessionOutputs:(NSError **)error {
    
    dispatch_queue_t quece = dispatch_queue_create("quece",DISPATCH_QUEUE_SERIAL );
    
    //视频输出
    AVCaptureVideoDataOutput * videoOut = [[AVCaptureVideoDataOutput alloc] init];
    [videoOut setAlwaysDiscardsLateVideoFrames:YES];
    [videoOut setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]}];
    [videoOut setSampleBufferDelegate:self queue:quece];
    if ([_session canAddOutput:videoOut]) {
        
        [_session addOutput:videoOut];
    }
    
    //音频输出
    AVCaptureAudioDataOutput * audioOut = [[AVCaptureAudioDataOutput alloc] init];
    [audioOut setSampleBufferDelegate:self queue:quece];
    if ([_session canAddOutput:audioOut]) {
        [_session addOutput:audioOut];
    }
    
    //帧图片输出
    AVCaptureStillImageOutput * imageOut = [[AVCaptureStillImageOutput alloc] init];
    imageOut.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    if ([_session canAddOutput:imageOut]) {
        [_session addOutput:imageOut];
    }

}

//
- (void)startCaptureSrssion {
    
    if (!_session.isRunning) {
        [_session startRunning];
    }
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
}

#define CCCameraViewDelegate
/// 闪光灯
-(void)flashLightAction:(LPYCameraView *)cameraView handle:(void(^)(NSError *error))handle{
    
}
/// 补光
-(void)torchLightAction:(LPYCameraView *)cameraView handle:(void(^)(NSError *error))handle{
    
}
/// 转换摄像头
-(void)swicthCameraAction:(LPYCameraView *)cameraView handle:(void(^)(NSError *error))handle{
    
}
/// 自动聚焦曝光
-(void)autoFocusAndExposureAction:(LPYCameraView *)cameraView handle:(void(^)(NSError *error))handle{
    
}
/// 聚焦
-(void)focusAction:(LPYCameraView *)cameraView point:(CGPoint)point handle:(void(^)(NSError *error))handle{
    
}
/// 曝光
-(void)exposAction:(LPYCameraView *)cameraView point:(CGPoint)point handle:(void(^)(NSError *error))handle{
    
}
/// 缩放
-(void)zoomAction:(LPYCameraView *)cameraView factor:(CGFloat)factor{
    
}

/// 取消
-(void)cancelAction:(LPYCameraView *)cameraView{
    
    [self.navigationController popViewControllerAnimated:YES];
}
/// 拍照
-(void)takePhotoAction:(LPYCameraView *)cameraView{
    
}
/// 停止录制视频
-(void)stopRecordVideoAction:(LPYCameraView *)cameraView{
    
}
/// 开始录制视频
-(void)startRecordVideoAction:(LPYCameraView *)cameraView{
    
}
/// 改变拍摄类型 1：拍照 2：视频
-(void)didChangeTypeAction:(LPYCameraView *)cameraView type:(NSInteger)type{
    
}

@end

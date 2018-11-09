//
//  CameraViewController.m
//  Camera_Test
//
//  Created by aaron on 2018/11/8.
//  Copyright © 2018年 aaron. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CameraPreView.h"

@interface CameraViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>

{
    //会话session
    AVCaptureSession * _session;
    //设备输入
    AVCaptureDeviceInput * _deviceInput;
    
    AVCaptureConnection * _videoCpnnection;
    AVCaptureConnection * _audioConnection;
    
    AVCaptureVideoDataOutput * _videoOutput;
    AVCaptureStillImageOutput * _imageOutput;
    
    BOOL _recording;
}

@property (nonatomic,strong) AVCaptureDevice * activeCamera;

@property (nonatomic,strong) AVCaptureDevice * inactiveCamera;


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
   
    CameraPreView * preView = [[CameraPreView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:preView];
    
    NSError * error;
    [self setupSession:&error];
    if (!error) {
        [preView setCaptureSessionsion:_session];
        [self startCaptureSrssion];
    }
    
}

- (void)setupSession:(NSError **)error{
    
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetHigh;
    
    [self setupSessionInputs:error];
    [self setupSessionOutputs:error];
}

//输入
- (void)setupSessionInputs:(NSError **)error {
    
    AVCaptureDevice * videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput * videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];
    if (videoInput) {
        if ([_session canAddInput:videoInput]) {
            [_session addInput:videoInput];
        }
    }
    _deviceInput = videoInput;
    
    AVCaptureDevice * audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput * audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:error];
    if ([_session canAddInput:audioInput]) {
        [_session addInput:audioInput];
    }
    
    
    
    
//    // 视频输入
//    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];
//    if (videoInput) {
//        if ([_session canAddInput:videoInput]){
//            [_session addInput:videoInput];
//        }
//    }
//    _deviceInput = videoInput;
//
//    // 音频输入
//    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
//    AVCaptureDeviceInput *audioIn = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:error];
//    if ([_session canAddInput:audioIn]){
//        [_session addInput:audioIn];
//    }
}

//c输出
-(void)setupSessionOutputs:(NSError **)error {
    
    dispatch_queue_t quece = dispatch_queue_create("quece",DISPATCH_QUEUE_SERIAL );
    
    AVCaptureVideoDataOutput * videoOut = [[AVCaptureVideoDataOutput alloc] init];
    [videoOut setAlwaysDiscardsLateVideoFrames:YES];
    [videoOut setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]}];
    [videoOut setSampleBufferDelegate:self queue:quece];
    if ([_session canAddOutput:videoOut]) {
        
        [_session addOutput:videoOut];
    }
    
    AVCaptureAudioDataOutput * audioOut = [[AVCaptureAudioDataOutput alloc] init];
    [audioOut setSampleBufferDelegate:self queue:quece];
    if ([_session canAddOutput:audioOut]) {
        [_session addOutput:audioOut];
    }
    
    AVCaptureStillImageOutput * imageOut = [[AVCaptureStillImageOutput alloc] init];
    imageOut.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    if ([_session canAddOutput:imageOut]) {
        [_session addOutput:imageOut];
    }
//    dispatch_queue_t captureQueue = dispatch_queue_create("com.cc.captureQueue", DISPATCH_QUEUE_SERIAL);
//
//    // 视频输出
//    AVCaptureVideoDataOutput *videoOut = [[AVCaptureVideoDataOutput alloc] init];
//    [videoOut setAlwaysDiscardsLateVideoFrames:YES];
//    [videoOut setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey: [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]}];
//    [videoOut setSampleBufferDelegate:self queue:captureQueue];
//    if ([_session canAddOutput:videoOut]){
//        [_session addOutput:videoOut];
//    }
//    _videoOutput = videoOut;
//    _videoCpnnection = [videoOut connectionWithMediaType:AVMediaTypeVideo];
//
//    // 音频输出
//    AVCaptureAudioDataOutput *audioOut = [[AVCaptureAudioDataOutput alloc] init];
//    [audioOut setSampleBufferDelegate:self queue:captureQueue];
//    if ([_session canAddOutput:audioOut]){
//        [_session addOutput:audioOut];
//    }
//    _audioConnection = [audioOut connectionWithMediaType:AVMediaTypeAudio];
//
//    // 静态图片输出
//    AVCaptureStillImageOutput *imageOutput = [[AVCaptureStillImageOutput alloc] init];
//    imageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
//    if ([_session canAddOutput:imageOutput]) {
//        [_session addOutput:imageOutput];
//    }
//    _imageOutput = imageOutput;
}

- (void)startCaptureSrssion {
    
    if (!_session.isRunning) {
        [_session startRunning];
    }
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
}

@end

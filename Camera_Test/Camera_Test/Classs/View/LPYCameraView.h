//
//  LPYCameraView.h
//  Camera_Test
//
//  Created by aaron on 2018/11/9.
//  Copyright © 2018年 aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraPreView.h"
NS_ASSUME_NONNULL_BEGIN
@class LPYCameraView;
@protocol CCCameraViewDelegate <NSObject>
@optional;

/// 闪光灯
-(void)flashLightAction:(LPYCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 补光
-(void)torchLightAction:(LPYCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 转换摄像头
-(void)swicthCameraAction:(LPYCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 自动聚焦曝光
-(void)autoFocusAndExposureAction:(LPYCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 聚焦
-(void)focusAction:(LPYCameraView *)cameraView point:(CGPoint)point handle:(void(^)(NSError *error))handle;
/// 曝光
-(void)exposAction:(LPYCameraView *)cameraView point:(CGPoint)point handle:(void(^)(NSError *error))handle;
/// 缩放
-(void)zoomAction:(LPYCameraView *)cameraView factor:(CGFloat)factor;

/// 取消
-(void)cancelAction:(LPYCameraView *)cameraView;
/// 拍照
-(void)takePhotoAction:(LPYCameraView *)cameraView;
/// 停止录制视频
-(void)stopRecordVideoAction:(LPYCameraView *)cameraView;
/// 开始录制视频
-(void)startRecordVideoAction:(LPYCameraView *)cameraView;
/// 改变拍摄类型 1：拍照 2：视频
-(void)didChangeTypeAction:(LPYCameraView *)cameraView type:(NSInteger)type;

@end
@interface LPYCameraView : UIView


@property(nonatomic, weak) id <CCCameraViewDelegate> delegate;

@property(nonatomic, strong, readonly) CameraPreView *previewView;

@property(nonatomic, assign, readonly) NSInteger type; // 1：拍照 2：视频

-(void)changeTorch:(BOOL)on;

-(void)changeFlash:(BOOL)on;
@end

NS_ASSUME_NONNULL_END

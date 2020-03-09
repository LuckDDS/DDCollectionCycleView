//
//  DDFaceFeature.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/4.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDFaceFeature.h"
//使用CIFaceFeature识别计算脸部特征点位置,转化为界面展示的坐标位置
@implementation DDFaceFeature
{
    size_t imgWidth;
    size_t imgHeight;
    float playerWidth;
    float playerHeight;
    
    
    //创建上下文
    CIContext *context;
    
    CIDetector *detector;
    
    CIImage * ciImg;
    
    CIFaceFeature *faceFeature;


}

+ (instancetype)buildFaceFeature{
    
    static DDFaceFeature *face = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        face = [[DDFaceFeature alloc]init];
    });
    return face;
}
- (instancetype)init
{
    
    self = [super init];
    if (self) {
        
        context = [CIContext contextWithOptions:nil];

    }
    return self;
}

- (CGPoint)caculateFaceFeatureWithBufferRef:(CVImageBufferRef)bufferRef withPlayerSize:(CGSize)playerSize withFaceFeatureType:(FaceFeatureType)faceFeatureType
{
    //1280
    imgHeight = CVPixelBufferGetWidth(bufferRef);
    //720
    imgWidth = CVPixelBufferGetHeight(bufferRef);
    //设置配置参数
    NSDictionary *param =  @{CIDetectorTracking:@(YES),CIDetectorAccuracyHigh:CIDetectorAccuracyHigh};
    //创建识别器
    [context clearCaches];
    
    detector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    CIImage *image = [[CIImage imageWithCVImageBuffer:bufferRef] imageByApplyingCGOrientation:kCGImagePropertyOrientationRight];
    
    NSArray *arr = [detector featuresInImage:image];
    
    for (int m = 0; m < arr.count; m ++) {
        
        faceFeature = arr[m];
        //因为是前置摄像头因此坐标需要反转才能找到真正的位置
        
    }
    
    
    if (arr.count > 0) {
        //标注脸部特征的位置(只是位置,没有具体的坐标)
        faceFeature = arr[0];
        switch (faceFeatureType) {
            case FaceFeatureMouth:
                return  [self caculateFaceFeatureLocation:CGPointMake(faceFeature.mouthPosition.x, faceFeature.mouthPosition.y)  withPlayerSize:playerSize];
                break;
            case FaceFeatureLeftEye:
                return  [self caculateFaceFeatureLocation:CGPointMake(faceFeature.rightEyePosition.x, faceFeature.rightEyePosition.y)  withPlayerSize:playerSize];
                break;
            case FaceFeatureRightEye:
                
                return  [self caculateFaceFeatureLocation:CGPointMake(faceFeature.leftEyePosition.x, faceFeature.leftEyePosition.y)  withPlayerSize:playerSize];
                break;
            default:
                return  CGPointMake(0, 0);;
                break;
        }
        return  CGPointMake(0, 0);
    }else{
        return CGPointMake(0, 0);
    }

}

- (CGPoint)caculateFaceFeatureLocation:(CGPoint)featureLocation  withPlayerSize:(CGSize)playerSize{
    
    playerHeight = playerSize.height;
    playerWidth = playerSize.width;
    float mouthX;
    float mouthY;
    if (imgHeight / imgWidth >= playerHeight / playerWidth) {
        //这里面证明裁剪的是上下
        //屏幕需要展示的像素高
        float needHeight = imgWidth * (playerHeight / playerWidth);
        //按比例调节
        mouthY = playerHeight - playerHeight * (featureLocation.y - (imgHeight - needHeight)/2) / needHeight;
        
        mouthX = playerWidth - playerWidth * (featureLocation.x / imgWidth);
        
    }else{
        //这里面裁剪的是左右
        //屏幕需要展示的像素宽
        float needWidth = imgHeight * (playerWidth / playerHeight);
        //按比例调节
        mouthX =  playerWidth - (featureLocation.x - (imgWidth - needWidth) / 2) / needWidth * playerWidth;
        
        mouthY = playerHeight - playerHeight * (featureLocation.y / imgHeight);
        
    }
    
    return CGPointMake(mouthX, mouthY);
}
@end

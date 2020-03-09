//
//  DDFaceFeature.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/4.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>
#define DDFACEFEATURE [DDFaceFeature buildFaceFeature]
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,FaceFeatureType) {
    FaceFeatureMouth = 0,
    FaceFeatureLeftEye,
    FaceFeatureRightEye,
    
};

@interface DDFaceFeature : NSObject

+ (instancetype)buildFaceFeature;
/**
 转换坐标
 @return 转换后的player的坐标
 */
//- (CGPoint)caculateFaceFeatureLocation:(CGPoint)featureLocation withOriginSize:(CGSize)originSize withPlayerSize:(CGSize)playerSize;

- (CGPoint)caculateFaceFeatureWithBufferRef:(CVImageBufferRef)bufferRef withPlayerSize:(CGSize)playerSize withFaceFeatureType:(FaceFeatureType)faceFeatureType;

@end

NS_ASSUME_NONNULL_END

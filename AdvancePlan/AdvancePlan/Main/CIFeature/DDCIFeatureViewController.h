//
//  DDCIFeatureViewController.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/2.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDRootViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, DDCIFeatureType){
    
    DDCIFeatureFace = 0,//人脸识别
    DDCIFeatureRectangle,//图形识别
    DDCIFeatureQRCode,//二维码
    DDCIFeatureText,//文字
    
};
@interface DDCIFeatureViewController : DDRootViewController

@property(nonatomic, assign) DDCIFeatureType featureType;

@end

NS_ASSUME_NONNULL_END

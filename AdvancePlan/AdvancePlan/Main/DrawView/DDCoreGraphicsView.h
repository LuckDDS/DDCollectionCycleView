//
//  DDCoreGraphicsView.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/4/9.
//  Copyright © 2020 www.dong.com 九天. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    CoreGraphicsDefault,
    CoreGraphicsLineType,
    CoreGraphicsArcType,
    CoreGraphicsClockType,
    CoreGraphicsAnimalType,
    CoreGraphicsScaleType,
    CoreGraphicsTranslateType,
    CoreGraphicsRotateType,
    CoreGraphicsCTMType
    
    
    
    
} CoreGraphicsType;

//typedef struct CoreGraphicsList{
//
//    int m;
//
//}CoreGraphicsType;

@interface DDCoreGraphicsView : UIView
@property (nonatomic, assign) CoreGraphicsType drawType;
@property (nonatomic, assign) float second;

@property (nonatomic, assign) float angle;

- (void)clearCanvas;


@end

NS_ASSUME_NONNULL_END

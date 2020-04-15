//
//  DDUIBezierPathTestView.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/4/14.
//  Copyright © 2020 www.dong.com 九天. All rights reserved.
//

#import "DDUIBezierPathTestView.h"

@implementation DDUIBezierPathTestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [self drawLine];
    [self drawArc];
}
- (void)drawLine{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 90)];
    [path addLineToPoint:CGPointMake(10, 160)];
    [path addLineToPoint:CGPointMake(200, 160)];
    [path closePath];
    path.lineWidth = 3;
    [[UIColor yellowColor] setFill];
    [path fill];
    [[UIColor redColor] set];
    [path stroke];
    
}

- (void)drawArc{
    //绘制了一个圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(200, 90, 50, 50)];
    path.lineWidth = 4;
    [[UIColor yellowColor] set];
    [path fill];
    [[UIColor redColor] set];
    [path stroke];
    //绘制了一个椭圆
    UIBezierPath *pathOval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(260, 90, 60, 40)];
    [[UIColor yellowColor] setFill];
    [pathOval fill];
    [[UIColor redColor] set];
    [pathOval stroke];
    //绘制了一个带切角的图像
    UIBezierPath *pathRound = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(330, 90, 60, 60) byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(20, 0)];
    [[UIColor yellowColor] set];
    [pathRound fill];
    [[UIColor redColor] set];
    [pathRound stroke];
    //绘制圆
    UIBezierPath * pathArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 220) radius:40 startAngle:0 endAngle:2*M_PI clockwise:0];
    [pathArc setLineWidth:3];
    [[UIColor yellowColor] setFill];
    [pathArc fill];
    [[UIColor redColor] set];
    [pathArc stroke];
    //绘制曲线
    UIBezierPath *pathCurve = [UIBezierPath bezierPath];
    [pathCurve moveToPoint:CGPointMake(100, 220)];
    [pathCurve addQuadCurveToPoint:CGPointMake(150, 240) controlPoint:CGPointMake(130, 200)];
    pathCurve.lineWidth = 3;
    [[UIColor redColor] set];
    [pathCurve stroke];
    
    
    UIBezierPath *otherPath = [UIBezierPath bezierPath];
    [otherPath moveToPoint:CGPointMake(30, 300)];
    [otherPath addLineToPoint:CGPointMake(50, 320)];
    [otherPath addLineToPoint:CGPointMake(90, 270)];
    [otherPath addQuadCurveToPoint:CGPointMake(180, 350) controlPoint:CGPointMake(150, 270)];
    [otherPath addLineToPoint:CGPointMake(300, 300)];
    [otherPath addArcWithCenter:CGPointMake(130, 250) radius:35 startAngle:0 endAngle:2*M_PI clockwise:0];
    [otherPath closePath];
    otherPath.lineWidth = 2;
    [[UIColor blackColor] set];
    [otherPath stroke];
    //拼接路径
    [otherPath appendPath:pathArc];
    CALayer * layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = CGPointMake(30, 300);
    layer.bounds = CGRectMake(0, 0, 8, 8);
    layer.cornerRadius = 4;
    [self.layer addSublayer:layer];

    CAKeyframeAnimation* keyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAni.repeatCount = NSIntegerMax;
    keyFrameAni.path = otherPath.CGPath;
    keyFrameAni.calculationMode = kCAAnimationCubic;
    keyFrameAni.duration = 3;
    keyFrameAni.beginTime = CACurrentMediaTime() + 1;
    [layer addAnimation:keyFrameAni forKey:@"keyFrameAnimation"];
    

}

@end

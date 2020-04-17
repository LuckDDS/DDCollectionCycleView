//
//  DDCGAffineTransformTestView.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/4/17.
//  Copyright © 2020 www.dong.com 九天. All rights reserved.
//

#import "DDCGAffineTransformTestView.h"

@implementation DDCGAffineTransformTestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{

    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //图像旋转
    //angle需要旋转的弧度,切记是坐标系的弧度,而且是从坐标系的原点旋转整个坐标系,并不只是单单旋转图形
    //CG_EXTERN void CGContextRotateCTM(CGContextRef cg_nullable c, CGFloat angle)
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGPoint points[] = {CGPointMake(0, 0),CGPointMake(rect.size.width, 0),CGPointMake(rect.size.width, rect.size.height),CGPointMake(0, rect.size.height)};
    CGContextAddLines(context, points, sizeof(points)/sizeof(points[0]));
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    //CGContextRotateCTM函数必须写在未设置坐标点之前
    //弧度的计算angle = M_PI/180*角度
    //CGContextRotateCTM(context, 0.2);
    //a,b,c,d共同控制的是旋转 公式:[cos(angle) sin(angle) -sin(angle) cos(angle) 0 0]
    //旋转是整个坐标系旋转
    CGAffineTransform transform = CGAffineTransformMake(cos(M_PI*0.17), sin(M_PI * 0.17), -sin(M_PI * 0.17),cos(M_PI*0.17), 0, 0);//旋转30度
    //实现沿Y轴对称
    //CGAffineTransform transform = CGAffineTransformMake(-1.0, 0, 0, 1, 200, 0);
    //实现沿X轴对称
//    CGAffineTransform transform = CGAffineTransformMake(1.0, 0, 0, -1.0, 0, 200);
    
    CGContextConcatCTM(context, transform);
    
    CGPoint points1[] = {CGPointMake(0, 50),CGPointMake(200, 50),CGPointMake(0, 200),CGPointMake(100, 0),CGPointMake(200, 170)};
    CGContextAddLines(context, points1, sizeof(points1)/sizeof(points1[0]));
    //CGContextRotateCTM(context, M_PI);放在add后面了是不起作用的
//    CGContextClosePath(context);
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextStrokePath(context);


    
    

}
@end

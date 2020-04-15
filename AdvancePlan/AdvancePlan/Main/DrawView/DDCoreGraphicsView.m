//
//  DDCoreGraphicsView.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/4/9.
//  Copyright © 2020 www.dong.com 九天. All rights reserved.
//

#import "DDCoreGraphicsView.h"

@implementation DDCoreGraphicsView
{
    CGRect myRect;
    CGContextRef context;
}

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
        //如果不调用initWithFrame:方法是不会走drawRect:
        //setNeedsDisplay
        
    }
    return self;
}

- (void)clearCanvas{
    CGContextClearRect(context, myRect);
}

- (void)drawRect:(CGRect)rect{
    myRect = rect;
    if (self.drawType == CoreGraphicsLineType) {
        [self drawLine:rect];
    }else if (self.drawType == CoreGraphicsArcType){
        [self drawArc:rect];
    }else if (self.drawType == CoreGraphicsClockType){
        [self drawClock];
    }else if (self.drawType == CoreGraphicsAnimalType){
        [self drawOther];
    }
}

- (void)drawClock{
    
    context = UIGraphicsGetCurrentContext();
    //先绘制表盘
    int radius = myRect.size.width/2-30;
    int centerX = myRect.size.width/2;
    int centerY = myRect.size.width/2;
    CGPoint center = CGPointMake(centerX, centerY);
    CGContextAddArc(context, centerX, centerY, radius, 0, M_PI*2, 0);
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor magentaColor].CGColor);
    //绘制刻度
    //指针之间的角度
    for (short m = 0; m < 60; m ++) {
        if (m % 5 == 0) {
            CGPoint myCenter = [self getPoint:m radius:radius center:center];
            CGContextMoveToPoint(context, myCenter.x, myCenter.y);
            CGPoint myCenterT;
            myCenterT = [self getPoint:m radius:radius-15 center:center];
            CGContextAddLineToPoint(context, myCenterT.x, myCenterT.y);

        }else{
            CGPoint myCenter = [self getPoint:m radius:radius center:center];
            CGContextSaveGState(context);
            CGContextSetLineWidth(context, 1);
            CGContextMoveToPoint(context, myCenter.x, myCenter.y);
            CGPoint myCenterT;
            myCenterT = [self getPoint:m radius:radius-8 center:center];
            CGContextAddLineToPoint(context, myCenterT.x, myCenterT.y);
            CGContextRestoreGState(context);
        }

    }
//    CGContextStrokePath(context);
    //绘制时针
//    CGContextSaveGState(context);
//    CGContextMoveToPoint(context, center.x, center.y);
//    CGContextAddLineToPoint(context, center.x, center.y-radius+50);
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextStrokePath(context);
//    CGContextRestoreGState(context);
    //绘制秒针
    CGContextMoveToPoint(context, center.x, center.y);
    CGPoint secondLineCenter = [self getPoint:self.second radius:radius- 40 center:center];
    CGContextAddLineToPoint(context, secondLineCenter.x, secondLineCenter.y);
    CGContextStrokePath(context);
    
    //绘制中心点
    CGContextAddArc(context, center.x, center.y, 3, 0, M_PI * 2, 0);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillPath(context);
    
}
//获取圆盘上的坐标
- (CGPoint)getPoint:(float)num radius:(int)radius center:(CGPoint)center{
//    NSLog(@"%d",num);
    CGFloat x2 = radius*cosf(num * 6 * M_PI/180);
    CGFloat y2 = radius*sinf(num * 6 * M_PI/180);
    return CGPointMake(center.x+x2, center.y+y2);
    
}

- (double)getAngle:(int)num{
        
    return M_PI/(180 / num);
}

- (void)drawArc:(CGRect)rect{
    //第一步永远都是获取画布
    context = UIGraphicsGetCurrentContext();
    //可以画弧可以画圆
    CGContextAddArc(context, 100, 100, 50, 0,2 * M_PI, 0);
    //用来画弧,但是需要设置currentPoint,CGContextMoveToPoint()
    //三个点组成了一个角然后再这个角中寻找半径为50的圆与两边的相切的位置,绘制弧,具体看图
    CGContextMoveToPoint(context, 200, 20);
    CGContextAddArcToPoint(context, 100, 100, 150, 150, 50);
    //设置画笔等相关属性
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 4);
    CGContextSetLineJoin(context, kCGLineJoinRound);//链接点的样式
    CGContextSetLineCap(context, kCGLineCapRound);//两端的样式
    CGContextDrawPath(context, kCGPathStroke);
    
}

- (void)drawLine:(CGRect)rect{
    //第一步永远都是获取画布
    context = UIGraphicsGetCurrentContext();
    //这是画一条线
//    CGContextMoveToPoint(context, 10, 10);
//    CGContextAddLineToPoint(context, rect.size.width/2, 80);
//    CGContextAddLineToPoint(context, rect.size.width-10, 10);
    //绘制多条线
    CGPoint points[] = {CGPointMake(10, 40),CGPointMake(30, 80),CGPointMake(100, 90),CGPointMake(234, 342),CGPointMake(334, 342)};
    CGContextAddLines(context, points, sizeof(points)/sizeof(points[0]));
    //设置画笔等相关属性
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor magentaColor].CGColor);
    CGContextSetLineWidth(context, 4);
    CGContextSetLineJoin(context, kCGLineJoinRound);//链接点的样式
    CGContextSetLineCap(context, kCGLineCapRound);//两端的样式
    CGColorRef color =CGColorCreateSRGB(0, 0, 1, 1);
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0, color);
    CGContextSaveGState(context);
//    CGContextStrokePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGColorRelease(color);
    //清空部分画布
    CGContextClearRect(context, CGRectMake(30, 10, 200, 200));

}

- (void)drawOther{
    
    context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, 40, 50, 30, -M_PI/2, 2*M_PI, 0);
    CGContextSetStrokeColorWithColor(context, [UIColor magentaColor].CGColor);
    CGContextStrokePath(context);
    //绘制扇形动画
    CGContextMoveToPoint(context, 120, 50);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);

    CGContextAddArc(context, 120, 50, 30, -M_PI_2,M_PI * self.angle / 60 * 1.2 - M_PI_2, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    CGContextStrokePath(context);
    
}


@end

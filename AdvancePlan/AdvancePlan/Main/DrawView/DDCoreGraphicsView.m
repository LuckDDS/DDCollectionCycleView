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
    }else if (self.drawType == CoreGraphicsScaleType){
        [self scale];
    }else if (self.drawType == CoreGraphicsRotateType){
        [self rotate];
    }else if(self.drawType == CoreGraphicsTranslateType){
        [self translate];
    }else if (self.drawType == CoreGraphicsCTMType){
        [self otherCTM];
    }
    
}

- (void)scale{
    //图像放大缩小操作
    //sx将坐标系中的的每个点的x的坐标乘以sx
    //sy将坐标系中的的每个点的y的坐标乘以sy
    //CG_EXTERN void CGContextScaleCTM(CGContextRef cg_nullable c, CGFloat sx, CGFloat sy)
    context = UIGraphicsGetCurrentContext();
    //CGContextScaleCTM函数必须写在未设置坐标点之前
    CGContextScaleCTM(context, 0.5, 1.0);
    CGPoint points[] = {CGPointMake(80, 200),CGPointMake(280, 200),CGPointMake(80, 400),CGPointMake(180, 130),CGPointMake(280, 400)};
    CGContextAddLines(context, points, sizeof(points)/sizeof(points[0]));
    //CGContextScaleCTM(context, 0.5, 0.5);放在add后面了是不起作用的
    CGContextClosePath(context);
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextStrokePath(context);
    
}

- (void)rotate{

    //图像旋转
    //angle需要旋转的弧度,切记是坐标系的弧度,而且是从坐标系的原点旋转整个坐标系,并不只是单单旋转图形
    //CG_EXTERN void CGContextRotateCTM(CGContextRef cg_nullable c, CGFloat angle)
    context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGPoint points[] = {CGPointMake(0, 0),CGPointMake(myRect.size.width, 0),CGPointMake(myRect.size.width, myRect.size.height),CGPointMake(0, myRect.size.height)};
    CGContextAddLines(context, points, sizeof(points)/sizeof(points[0]));
    CGContextClosePath(context);
    CGContextStrokePath(context);
    //CGContextRotateCTM函数必须写在未设置坐标点之前
    CGContextRotateCTM(context, M_PI/6);
    CGPoint points1[] = {CGPointMake(80, 200),CGPointMake(280, 200),CGPointMake(80, 400),CGPointMake(180, 130),CGPointMake(280, 400)};
    CGContextAddLines(context, points1, sizeof(points1)/sizeof(points1[0]));
    //CGContextRotateCTM(context, M_PI);放在add后面了是不起作用的
    CGContextClosePath(context);
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextStrokePath(context);

    
}

- (void)translate{
    //图像平移
    //tx横坐标平移的距离,ty纵坐标平移的距离
    //CGContextTranslateCTM(CGContextRef  _Nullable c, CGFloat tx, CGFloat ty);
    context = UIGraphicsGetCurrentContext();
    //CGContextTranslateCTM函数必须写在未设置坐标点之前
    CGContextTranslateCTM(context, 130, 0);
    CGPoint points[] = {CGPointMake(80, 200),CGPointMake(280, 200),CGPointMake(80, 400),CGPointMake(180, 130),CGPointMake(280, 400)};
    CGContextAddLines(context, points, sizeof(points)/sizeof(points[0]));
    //    CGContextTranslateCTM(context, 130, 0);放在add后面了是不起作用的
    CGContextClosePath(context);
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextStrokePath(context);
}

- (void)otherCTM{

    context = UIGraphicsGetCurrentContext();
    //设置画笔
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor magentaColor].CGColor);
    CGContextSetLineWidth(context, 2);
    //首先保存之前的坐标系,以及画布的状态
    CGContextSaveGState(context);
    //第一步缩放坐标系
    CGContextScaleCTM(context, 0.5, 0.5);
    
    //第二步旋转坐标系
    CGContextRotateCTM(context, 0.4);
    //第三步平移
    CGContextTranslateCTM(context, 200, 0);
    //绘制图形
    CGPoint points[] = {CGPointMake(0, 200),CGPointMake(200, 200),CGPointMake(0, 400),CGPointMake(100, 130),CGPointMake(200, 400)};
    CGContextAddLines(context, points, sizeof(points)/sizeof(points[0]));
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    //上面的三步可以使用下面的这个方法一步到位
    //CGAffineTransformMake控制图形的变化
    //a,d控制缩放的倍数
    //a,b,c,d共同控制的是旋转 公式:[cos(angle) sin(angle) -sin(angle) cos(angle) 0 0]
    //tx,ty控制的图像的偏移
    //CGAffineTransform transform = CGAffineTransformMake(CGFloat a, CGFloat b, CGFloat c, CGFloat d, CGFloat tx, CGFloat ty);
    //CGContextConcatCTM(CGContextRef  _Nullable c, CGAffineTransform transform);

    //绘制文字,文字的颜色什么的不受画笔设置的影响,需要单独设置
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, [UIColor colorWithRed:114/255.0f green:128/255.0f blue:137/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil];
    [@"未restore状态,文字随坐标系旋转,缩放,偏移" drawAtPoint:CGPointMake(0, 80) withAttributes:attrs];
    CGContextRestoreGState(context);
    NSDictionary *attrsOne = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil];
    [@"执行restore后,文字展示在正常的坐标系" drawAtPoint:CGPointMake(0, 80) withAttributes:attrsOne];
    CGContextStrokePath(context);

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
    //绘制的时候如果不想将线路连起来,需要每次规定线路,都得调用一次绘制即可,
    //CGContextBeginPath(CGContextRef  _Nullable c)//开启一个新的线路之前的路径被废弃,已经绘制的不受影响
    context = UIGraphicsGetCurrentContext();
    //设置样式
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGContextSetLineJoin(context, kCGLineJoinRound);//链接点的样式
    CGContextSetLineCap(context, kCGLineCapRound);//两端的样式
    //可以画弧,可以画圆
    //这个是绘制了一个圆
    CGContextAddArc(context, 60, 100, 50, 0,2 * M_PI, 0);
    CGContextStrokePath(context);
    //下面的三个圆是对应的三个点
    CGContextAddArc(context, 200, 20, 1, 0, 2*M_PI, 0);
    CGContextAddArc(context, 100, 100, 1, 0, 2*M_PI, 0);
    
    CGContextAddArc(context, 150, 150, 1, 0, 2*M_PI, 0);
    //先绘制和先保存状态谁先后,只要是还未重新设置画笔的状态就不会产生影响
    CGContextStrokePath(context);
    CGContextSaveGState(context);
    //重新设置画笔的粗细
    CGContextSetLineWidth(context, 4);
    //用来画弧,但是需要设置currentPoint,CGContextMoveToPoint()
    //三个点组成了一个角然后再这个角中寻找半径为50的圆与两边的相切的位置,绘制弧,具体看图
    CGContextMoveToPoint(context, 200, 20);
    CGContextAddArcToPoint(context, 100, 100, 150, 150, 50);
    CGContextDrawPath(context, kCGPathStroke);
    //为了测试CGContextSaveGState
    CGContextRestoreGState(context);
    CGContextAddArc(context, 350, 350, 40, 0, 2*M_PI, 0);
    CGContextStrokePath(context);
    
    
    //绘制椭圆
    CGContextAddEllipseInRect(context, CGRectMake(50, 300, 100, 60));
    CGContextStrokePath(context);
}

- (void)drawLine:(CGRect)rect{
    //第一步永远都是获取画布
    context = UIGraphicsGetCurrentContext();
    //这是画一条线
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddLineToPoint(context, rect.size.width/2, 80);
    CGContextAddLineToPoint(context, rect.size.width-10, 10);
    
    //一次添加多个点,绘制多条线,第一个点是d起点
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
//    CGContextClearRect(context, CGRectMake(30, 10, 200, 200));

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

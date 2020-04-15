//
//  DDCoreGraphicsViewController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/4/9.
//  Copyright © 2020 www.dong.com 九天. All rights reserved.
//

#import "DDCoreGraphicsViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "DDCoreGraphicsView.h"
@interface DDCoreGraphicsViewController ()

@end

@implementation DDCoreGraphicsViewController
{
    DDCoreGraphicsView *coreGraphicsView;
    CADisplayLink *displayLink;
    int w;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    w = 0;
    self.view.backgroundColor = [UIColor yellowColor];
    coreGraphicsView = [[DDCoreGraphicsView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    coreGraphicsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:coreGraphicsView];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 500, 100, 40)];
    btn.backgroundColor = [UIColor magentaColor];
    [btn setTitle:@"直线" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(draw) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    UIButton *btnT = [[UIButton alloc]initWithFrame:CGRectMake(110, 500, 100, 40)];
    btnT.backgroundColor = [UIColor magentaColor];
    [btnT setTitle:@"曲线" forState:(UIControlStateNormal)];
    [btnT addTarget:self action:@selector(drawT) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btnT];
    
    UIButton *btnClock = [[UIButton alloc]initWithFrame:CGRectMake(220, 500, 100, 40)];
    btnClock.backgroundColor = [UIColor magentaColor];
    [btnClock setTitle:@"钟表" forState:(UIControlStateNormal)];
    [btnClock addTarget:self action:@selector(beginAnimal) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btnClock];
    
    UIButton *btnAnimal = [[UIButton alloc]initWithFrame:CGRectMake(0, 550, 100, 40)];
    btnAnimal.backgroundColor = [UIColor magentaColor];
    [btnAnimal setTitle:@"模拟动画" forState:(UIControlStateNormal)];
    [btnAnimal addTarget:self action:@selector(drawAnimal) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btnAnimal];
    
    UIButton *buildBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 550, 100, 40)];
    buildBtn.backgroundColor = [UIColor magentaColor];
    [buildBtn setTitle:@"自行创建" forState:(UIControlStateNormal)];
    [buildBtn addTarget:self action:@selector(buildCanvas) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buildBtn];
    
    UIButton *stopClock = [[UIButton alloc]initWithFrame:CGRectMake(220, 550, 100, 40)];
    stopClock.backgroundColor = [UIColor magentaColor];
    [stopClock setTitle:@"停止" forState:(UIControlStateNormal)];
    [stopClock addTarget:self action:@selector(stopAnimal) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:stopClock];


    
    // Do any additional setup after loading the view.
}

- (void)buildCanvas{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.view.frame.size.width, self.view.frame.size.height), YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddArc(context, 100, 100, 50, 0, M_PI, 0);
    CGContextSetFillColorWithColor(context, [UIColor magentaColor].CGColor);
    CGContextSetLineWidth(context, 3);
    CGContextFillPath(context);
    CGContextStrokePath(context);
    [self.view.layer renderInContext:context];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView * imaV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    imaV.image = img;
    [self.view addSubview:imaV];
}


- (void)beginAnimal{
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawClock)];
    displayLink.preferredFramesPerSecond = 1;
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    NSCalendar * calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDate * date = [NSDate date];
    NSDateComponents * components = [[NSDateComponents alloc]init];
    NSInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    components = [calendar components:unitFlags fromDate:date];
    long second = components.second;
    w = (int)(second - 16);
    coreGraphicsView.second = w;
    coreGraphicsView.drawType = CoreGraphicsClockType;
    [coreGraphicsView setNeedsDisplay];
}

- (void)drawAnimal{
    coreGraphicsView.drawType = CoreGraphicsAnimalType;
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawAnimalView)];
    displayLink.preferredFramesPerSecond = 0;
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)drawAnimalView{
    if (w > 60) {
        [self stopAnimal];
        w = 0;
        return;
    }
    coreGraphicsView.angle = w;
    [coreGraphicsView setNeedsDisplay];
    w++;
}

- (void)stopAnimal{
    [displayLink setPaused:YES];
    [displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [displayLink invalidate];
    displayLink = nil;
}

- (void)draw{
    coreGraphicsView.drawType = CoreGraphicsLineType;
    [coreGraphicsView setNeedsDisplay];
}

- (void)drawT{
    coreGraphicsView.drawType = CoreGraphicsArcType;
    [coreGraphicsView setNeedsDisplay];
}

- (void)dealloc{
    NSLog(@"%@",@"dealloc");
}

- (void)drawClock{
    if (w > 59) {
        w = 1;
    }else{
        w++;
    }
    coreGraphicsView.second = w;
    coreGraphicsView.drawType = CoreGraphicsClockType;
    [coreGraphicsView setNeedsDisplay];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

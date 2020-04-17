//
//  DDUIBezierPathViewController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/4/9.
//  Copyright © 2020 www.dong.com 九天. All rights reserved.
//

#import "DDUIBezierPathViewController.h"
#import "DDUIBezierPathTestView.h"
@interface DDUIBezierPathViewController ()

@end
static int num = 0;
@implementation DDUIBezierPathViewController
{
    DDUIBezierPathTestView *bezierView;
    CAShapeLayer * layer;
    CAShapeLayer *m_layer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    bezierView = [[DDUIBezierPathTestView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:bezierView];
    [self bezierAnimal];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(170, 400, 100, 40)];
    btn.backgroundColor = [UIColor magentaColor];
    [btn setTitle:@"动画" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(animalTest) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    [self buildArcAnimal];
    [self buildLoad];
    [self testAnimal];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(290, 400, 100, 40)];
    btn1.backgroundColor = [UIColor magentaColor];
    [btn1 setTitle:@"动画1" forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(animalTestOne) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];

    // Do any additional setup after loading the view.
}

- (void)buildLoad{

    layer.lineWidth = 1;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addQuadCurveToPoint:CGPointMake(100, 0) controlPoint:CGPointMake(50, -80)];
    [path addQuadCurveToPoint:CGPointMake(80, 0) controlPoint:CGPointMake(100, 30)];
    [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(40, -60)];
    CAShapeLayer * subLayer = [CAShapeLayer layer];
    subLayer.frame = CGRectMake(0, 0, 100, 100);
    subLayer.backgroundColor = [UIColor yellowColor].CGColor;
    subLayer.path = path.CGPath;
    
    UIBezierPath * arcPath = [UIBezierPath bezierPath];
//    [arcPath moveToPoint:CGPointMake(0, 0)];
//    [arcPath addLineToPoint:CGPointMake(200, 300)];
//    [arcPath addLineToPoint:CGPointMake(150, 450)];
    [arcPath addArcWithCenter:CGPointMake(150, 200) radius:90 startAngle:0 endAngle:2*M_PI clockwise:1];
    
    CAKeyframeAnimation * keyFrameAnimal = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimal.duration = 5;
    keyFrameAnimal.path = arcPath.CGPath;
    keyFrameAnimal.repeatCount = 10;
    keyFrameAnimal.rotationMode = kCAAnimationRotateAuto;
    keyFrameAnimal.beginTime = CACurrentMediaTime() + 1;
    
    [subLayer addAnimation:keyFrameAnimal forKey:@""];
    [self.view.layer addSublayer:subLayer];

}

- (void)buildArcAnimal{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 100)];
    [path addCurveToPoint:CGPointMake(300, 100) controlPoint1:CGPointMake(100, 50) controlPoint2:CGPointMake(200, 150)];
    [path addLineToPoint:CGPointMake(280, 180)];
    [path addQuadCurveToPoint:CGPointMake(200, 180) controlPoint:CGPointMake(240, 230)];
    [path closePath];
    layer.path = path.CGPath;
    CAShapeLayer * subLayer = [CAShapeLayer layer];
    subLayer.frame = CGRectMake(20, 100, 5, 5);
    subLayer.backgroundColor = [UIColor blackColor].CGColor;
    subLayer.fillColor = [UIColor yellowColor].CGColor;
    subLayer.strokeColor = [UIColor magentaColor].CGColor;
    CAKeyframeAnimation * baseAnimal = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    baseAnimal.duration = 3;
    baseAnimal.calculationMode = kCAAnimationCubic;
    baseAnimal.repeatCount = 10;
    baseAnimal.path = path.CGPath;
    baseAnimal.beginTime = CACurrentMediaTime() + 1;
    [subLayer addAnimation:baseAnimal forKey:@"asd"];
    [layer addSublayer:subLayer];

}

- (void)bezierAnimal{
    UIBezierPath *animalPath =[self getAnimalOriginPath];
    layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 400, self.view.frame.size.width, self.view.frame.size.height);
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    layer.path = animalPath.CGPath;
    layer.lineWidth = 4;
    layer.fillColor = [UIColor magentaColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
}

- (UIBezierPath *)getAnimalOriginPath{
    UIBezierPath *animalPath = [UIBezierPath bezierPath];
    [animalPath moveToPoint:CGPointMake(30, 10)];
    [animalPath addLineToPoint:CGPointMake(100, 10)];
    [animalPath addLineToPoint:CGPointMake(150, 10)];
    [animalPath addLineToPoint:CGPointMake(150, 60)];
    [animalPath addLineToPoint:CGPointMake(150, 100)];
    [animalPath addLineToPoint:CGPointMake(100, 100)];
    [animalPath addLineToPoint:CGPointMake(30, 100)];
    [animalPath closePath];
    return animalPath;

}

- (UIBezierPath *)getAnimalPath{
    
    UIBezierPath *animalPath = [UIBezierPath bezierPath];
    [animalPath moveToPoint:CGPointMake(30, 10)];
    [animalPath addLineToPoint:CGPointMake(100, 40)];
    [animalPath addLineToPoint:CGPointMake(150, 10)];
    [animalPath addLineToPoint:CGPointMake(120, 60)];
    [animalPath addLineToPoint:CGPointMake(150, 100)];
    [animalPath addLineToPoint:CGPointMake(80, 70)];
    [animalPath addLineToPoint:CGPointMake(30, 100)];
    [animalPath closePath];
    return animalPath;
}
- (void)animalTest{
    UIBezierPath *animalPath;
    if (num%2 == 0) {
        animalPath = [self getAnimalOriginPath];
    }else{
        animalPath = [self getAnimalPath];
    }
    num++;
    
    CABasicAnimation * animal = [CABasicAnimation animationWithKeyPath:@"path"];
    animal.duration = 1;
    animal.removedOnCompletion = NO;
    animal.repeatCount = 0;
    layer.path = animalPath.CGPath;
    [layer addAnimation:animal forKey:@""];
    
}

- (void)testAnimal{

    UIBezierPath * m_path = [UIBezierPath bezierPath];
    
    [m_path addArcWithCenter:CGPointMake(100, 100) radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [m_path closePath];
    m_layer = [CAShapeLayer layer];
    m_layer.frame = CGRectMake(0, 150, 200, 200);
    m_layer.backgroundColor = [UIColor blackColor].CGColor;
    m_layer.fillColor = [UIColor magentaColor].CGColor;
    m_layer.strokeColor = [UIColor redColor].CGColor;
    m_layer.path = m_path.CGPath;
    [layer addSublayer:m_layer];
    
}

- (void)animalTestOne{

    CABasicAnimation *baseAnimal = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    baseAnimal.duration = 2;
    //byValue
    baseAnimal.fromValue = @(0);
    baseAnimal.toValue = @(2*M_PI);
    baseAnimal.removedOnCompletion = NO;//是否移除动画结束后的状态,和fillMode共同使用
    baseAnimal.repeatCount = MAXINTERP;
//    baseAnimal.autoreverses = YES;//是否按原动画回到之前的状态默认为No就会刷的一下就回去了
    baseAnimal.fillMode = kCAFillModeForwards;//fillMode结束后是否返回
    baseAnimal.beginTime = CACurrentMediaTime();
    [m_layer addAnimation:baseAnimal forKey:@""];
    
    //position和anchorPoint永远是重合的
    //position是中心点(center)相对于父层的位置坐标,anchorPoint是决定中心点(center)位置的
    //改变anchorPoint对图形的position没有影响,但是图形的位置会发生变化,因为图形的中心点的相对位置改变了,
    //改变position对图像的anchorPoint没有影响,但是图形相对于父层的位置会发生变化
    NSLog(@"%@",NSStringFromCGPoint(m_layer.position));
    NSLog(@"%@",NSStringFromCGPoint(m_layer.anchorPoint));

    m_layer.anchorPoint = CGPointMake(0, 0);
    m_layer.position = CGPointMake(300, 300);
    
    NSLog(@"%@",NSStringFromCGPoint(m_layer.position));
    NSLog(@"%@",NSStringFromCGPoint(m_layer.anchorPoint));
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

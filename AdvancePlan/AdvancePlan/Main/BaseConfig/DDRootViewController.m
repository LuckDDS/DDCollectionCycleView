//
//  DDRootViewController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/21.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDRootViewController.h"

@interface DDRootViewController ()<UIGestureRecognizerDelegate>

@end

@implementation DDRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer{
    
    if (self.navigationController.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
    
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

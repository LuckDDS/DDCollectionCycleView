//
//  DDKVOViewController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/19.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDKVOViewController.h"
#import "DDSingleton.h"
@interface DDKVOViewController ()

@end

@implementation DDKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    DDWebView * webView = [[DDWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [webView loadUrlWithName:@"kvo"];
//    [self.view addSubview:webView];
    DDSingleton *singleton = [DDSingleton instance];
    NSLog(@"%p,%p",singleton,&singleton);
    
    // Do any additional setup after loading the view.
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

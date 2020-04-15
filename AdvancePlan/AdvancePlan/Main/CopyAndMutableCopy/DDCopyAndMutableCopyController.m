//
//  DDCopyAndMutableCopyController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/23.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCopyAndMutableCopyController.h"
#import "DDCopyAndMutableTest.h"
@interface DDCopyAndMutableCopyController ()

@end

@implementation DDCopyAndMutableCopyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DDWebView * webView = [[DDWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [webView loadUrlWithName:@"copyAndMutableCopy"];

    [self.view addSubview:webView];
    

    DDCopyAndMutableTest* obj = [[DDCopyAndMutableTest alloc]init];
    obj.strCopy = @"111";
    obj.strStrong = @"222";

    DDCopyAndMutableTest* obj1 = [[DDCopyAndMutableTest alloc]init];
    obj1.strCopy = @"333";
    obj1.strStrong = @"444";

    DDCopyAndMutableTest* obj2 = [[DDCopyAndMutableTest alloc]init];
    obj2.strCopy = @"555";
    obj2.strStrong = @"666";
    
    DDCopyAndMutableTest* obj3 = [[DDCopyAndMutableTest alloc]init];
    obj3.strCopy = @"777";
    obj3.strStrong = @"888";


    NSSet* set = [NSSet setWithObjects:obj,obj1,obj2, nil];
    NSSet* set1 = [set mutableCopy];
    NSMutableSet* set2 = [set mutableCopy];
    NSLog(@"%p,%p",set,&set);
    NSLog(@"%p,%p",set1,&set1);
    
    for (DDCopyAndMutableTest* test in set) {
        NSLog(@"%p,%p",test,&test);
        test.strCopy = @"999999999";
        test.strStrong = @"000000000";
    }
    for (DDCopyAndMutableTest* test in set1) {
        NSLog(@"%p,%p",test,&test);
        NSLog(@"%@",test.strCopy);
        NSLog(@"%@",test.strStrong);


    }

    
    [set2 addObject:obj3];
    
    

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

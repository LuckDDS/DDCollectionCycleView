//
//  DDCfeatureViewController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/15.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCfeatureViewController.h"
#import "DDWebView.h"
@interface DDCfeatureViewController ()

@end

@implementation DDCfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DDWebView * webView = [[DDWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [webView loadUrlWithName:@"cfeature"];
    [self.view addSubview:webView];
    webView.s = @"111";
    NSLog(@"%p,%p",webView,&webView);
    [self DataTest:webView];
    NSLog(@"%@",webView.s);
    int carr[] = {1,2,3,4,5};
    *(carr+1) = 123;
    carr[2] = 1234;
    
    
    NSString *str = [NSString stringWithFormat:@"%@",@"123456789"];
    NSLog(@"str数据的地址:%p,str的值%@,str指针的%p",str,str,&str);
    [self changeText:str];
    NSLog(@"str数据的地址:%p,str的值%@,str指针的%p",str,str,&str);

    // Do any additional setup after loading the view.
    
    //OC数组作为函数传值永远是值传递,数组传过去的是指针的拷贝,指针的地址不同,但是都是指向的同一块内存.
    NSArray *arr = @[@"1",@"2",@"3"];
    NSMutableArray * arr1 = [NSMutableArray arrayWithArray:@[@"00",@"111",@"222"]];
    NSLog(@"%p,%p,%p",arr1,arr1[0],&arr1);
    NSLog(@"%p,%p,%p",arr,arr[0],&arr);
    /**
     0x28142d530,0x10069d840,0x16f7a38f0
     0x28142d650,0x10069d7e0,0x16f7a38f8
     */

    [self testData:arr withMutableArr:arr1];
    NSLog(@"%p,%p,%p",arr1,arr1[0],&arr1);
    NSLog(@"%p,%p,%p",arr,arr[0],&arr);
    /**
     0x28142d530,0x10069d8e0,0x16f7a38f0
     0x28142d650,0x10069d7e0,0x16f7a38f8
     */

}

- (void)testData:(NSArray*)arr withMutableArr:(NSMutableArray*)mutableArr{
    NSLog(@"%p,%p,%p",mutableArr,mutableArr[0],&mutableArr);
    NSLog(@"%p,%p,%p",arr,arr[0],&arr);
    /**
     0x28142d530,0x10069d840,0x16f7a37c0
     0x28142d650,0x10069d7e0,0x16f7a37c8
     */
    //数组这里是直接重新指向了一块内存
    NSMutableArray * arra = [NSMutableArray arrayWithObjects:@"aaa",@"bbb",@"bbb", nil];
    arr = @[@"222",@"333",@"123123"];
//    mutableArr[0] = @"333";
//    [mutableArr setObject:@"00000" atIndexedSubscript:0];
    mutableArr = arra;
    NSLog(@"%p,%p,%p",mutableArr,mutableArr[0],&mutableArr);
    NSLog(@"%p,%p,%p",arr,arr[0],&arr);
    /**
     0x28142d530,0x10069d8e0,0x16f7a37c0
     0x28142a010,0x10069d860,0x16f7a37c8
     */
}

- (void)DataTest:(DDWebView*)web{
    web.s = @"222";
    NSLog(@"%p,%p",web,&web);
    
}

- (void)changeText:(NSString *)str{
    NSLog(@"str数据的地址:%p,str的值%@,str指针的%p",str,str,&str);
    str = @"oooooooooooooooooooooo";
    str = nil;
    
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

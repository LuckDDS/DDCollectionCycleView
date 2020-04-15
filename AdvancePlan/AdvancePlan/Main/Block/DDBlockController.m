//
//  DDBlockController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/19.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDBlockController.h"
#import "DDKVOViewController.h"
@interface DDBlockController ()
@property (nonatomic, assign) int a;
@property (nonatomic, copy) NSString *str;
@end

static int b = 11;
int c = 10;
NSString *str1 = @"aaaaaa";
static NSString *str2 = @"bbbbbb";


@implementation DDBlockController
{
    int d;
    NSString *str3;
    void (^testTwo)(void);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.a = 123;
    self.str = @"eeeeeeeee";
    d = 4444444;
    str3 = @"rrrrrrrrrrrrrrrrr";
    [self blockTest];
    // Do any additional setup after loading the view.
}

- (void)blockTest{
    __block int e = 10;
    static int f = 12;
    NSString * str4= [[NSString alloc]init];

    str4 = @"123123";
    static NSString * str5= @"1234asdads";
    NSLog(@"%p,%p",&str4,str4);
    NSLog(@"%p,%p",&str5,str5);
    DDKVOViewController * dd = [[DDKVOViewController alloc]init];
    dd.s = @"qwertyuiopasdfghjkl";
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    [arr addObject:@"1"];
    void (^testOne)(void) = ^(void){
//        [arr addObject:@"wqeq"];
        e = 11;
        str4;//str4只拥有读取的权限,没有修改的权限.
        dd.s = @"adsasd";
        NSLog(@"%p,%p",&str4,str4);
        NSLog(@"%p,%p",&str5,str5);

//        NSLog(@"%d",_a);
//        NSLog(@"%d",b);
//        NSLog(@"%d",c);
//        NSLog(@"%d",d);
//        NSLog(@"%d",e);
//        NSLog(@"%d",f);
//        NSLog(@"%@",self->_str);
//        NSLog(@"%@",str1);
//        NSLog(@"%@",str3);
//        NSLog(@"%@",str4);
//        NSLog(@"%@",str5);

    };

    testOne();
    NSLog(@"%@",dd.s);
}

- (void)allocMydata{

}

- (void)dealloc{
    NSLog(@"aaaaaaaaaaaaaa");
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

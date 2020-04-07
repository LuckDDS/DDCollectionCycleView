//
//  DDBlockViewController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/13.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDBlockViewController.h"
#import "DDBlockController.h"
#import "DDWebView.h"
#import "DDBlockStudy.h"
@interface DDBlockViewController ()

//@property (nonatomic, copy)void (^)(NSString * _Nullable) propertyBlock;错误的方式
@property (nonatomic ,copy) void (^copyPropertyBlock)(NSString * _Nullable);//block作为属性,文件中可以直接用propertyBlock
@property (nonatomic ,strong) void (^strongPropertyBlock)(NSString * _Nullable);//block作为属性,文件中可以直接用propertyBlock

@property (nonatomic, strong)    NSMutableString *testGlobalMutableStr;

@property (nonatomic, strong)    NSMutableArray *testGlobalMutableArr;

@property (nonatomic, strong)    NSString *testGlobalStr;

@property (nonatomic, strong)    NSArray *testGlobalArr;

@property (nonatomic, assign)    int globaln;


@end
static int w = 8;

@implementation DDBlockViewController
{
    NSMutableString *testMutableStr;
    NSMutableArray *testMutableArr;
    NSString *testStr;
    NSArray *testArr;
    int n;
    void (^propertyBlock)(NSString *);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%p,%p,%p,%p",testStr,&testStr,self.testGlobalStr,&(_testGlobalStr));
    DDWebView * webView = [[DDWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [webView loadUrlWithName:@"block"];
    [self.view addSubview:webView];
    
    //Block定义
    [self blockDefine];
    [self buildData];
    //Block详解
    [self blockProperty];
    [self blockPropertyNum];
    buildBlock();
    
//    [self loadSubController];
    // Do any additional setup after loading the view.
}

- (void)loadSubController{
    DDBlockController *blockVC = [[DDBlockController alloc]init];
    [self.navigationController pushViewController:blockVC animated:YES];
}

#pragma mark Block Define
- (void)blockDefine{
    //不带返回参数
    void (^blockName)(NSString *_Nullable) = ^void(NSString *param){
        NSLog(@"%@",param);
    };
    blockName(@"自定义不带返回值的block");
    
    //带返回参数
    NSString* (^paramBlock)(NSString *_Nullable) = ^NSString *(NSString*param){
        return param;
    };
    NSString *param = paramBlock(@"自定义带返回值的block");

    //block作为参数,不带返回值
    [self blockAsParam:^(NSString *name) {
        self.globaln = 10;
        NSLog(@"%@",name);
    }];
    
    //block作为参数,带返回值
    [self blockAsParamReturnValue:^NSString* (NSString *name){
        return [name stringByAppendingFormat:@"%@",@"11111"];
    }];
    
    //带返回值的block作为返回值
    NSString * (^sbolckN)(NSString*name) = [self blockAsBackParam:@"0000"];
    NSString *str = sbolckN(@"123123");
    
    //不带返回值的block作为返回值
    void (^noParamBlock)(NSString *name) = [self noParamBlockAsParam:@"11111" withTwo:@"2222"];
    noParamBlock(@"3333");
    
}
/**
 block作为参数
 */
- (void)blockAsParam:(void(^)(NSString *))block{
    
    NSString *str = @"小宝宝加油";
    NSLog(@"内容地址:%p,指针地址%p",str,&str);
    block(str);
    
}
/**
 block作为参数,带返回值
 */
- (void)blockAsParamReturnValue:(NSString *(^)(NSString *str))returnValue{

    NSString *s = returnValue(@"123123123");
    NSLog(@"%@",s);

}

/**
 带返回参数的block作为返回值
 */
- (NSString * (^)(NSString *))blockAsBackParam:(NSString*)firstName{

   return  [^NSString *(NSString *n){
       return [firstName stringByAppendingFormat:@"%@",n];
   } copy];
    
}

/**
 不带返回参数的block作为返回值
 */
- (void (^)(NSString *))noParamBlockAsParam:(NSString *)first withTwo:(NSString*)two{

    return [^(NSString*name){
        NSLog(@"%@%@%@",name,first,two);
    } copy];
    
}

#pragma mark blockProperty

- (void)buildData{
    
    self.testGlobalArr = @[@"1",@"2",@"3"];
    self.testGlobalMutableArr = [NSMutableArray arrayWithObjects:@"4",@"5",@"6", nil];
    self.testGlobalStr = @"不可变";
    self.testGlobalMutableStr = [NSMutableString stringWithFormat:@"%@",@"可变字符"];
    self.globaln = 10;
    
    testArr = @[@"7",@"8"];
    testStr = @"测试";
    testMutableArr = [NSMutableArray arrayWithObjects:@"11",@"22", nil];
    testMutableStr = [NSMutableString stringWithFormat:@"%@",@"gogogogo"];
    n = 11;
    
}

- (void)blockProperty{
    
    auto int m = 9;
    NSArray *arr = @[@"ssss",@"eeee"];
    NSString *str = @"000000000000000";
    NSMutableArray *mutableArr = [NSMutableArray arrayWithObjects:@"11111",@"222222", nil];
    NSMutableString *mutable = [NSMutableString stringWithFormat:@"%@",@"pppppppppp"];
    static int s = 0;
    void (^testBlock)(void) = ^(void){
        
        int d = m + 10;
        NSLog(@"%d",d);
        
    };
    void (^testOne)(void) = ^(){
        int d = s+1;
        NSLog(@"%d",d);
    };
    
    void (^testTwo)(void) = ^(){
//        int d = _globaln + 9;
    };
    
    void (^testThree)(void) = ^(){
        int d = w + 9;
        NSLog(@"%d",d);

    };

    
    
     
    _copyBlock = ^(NSString *c){
        
        int d = m + 10;
        NSLog(@"%d",d);

        return @"cccc";
    
    };
    
    _strongBlock = ^(NSString*c){
        
        int d = s+1;
        NSLog(@"%d",d);
        return @"ssss";
        
    };
    
    self.copyPropertyBlock = ^(NSString *c){
        int d = _globaln + 9;
        NSLog(@"%d",d);
    };
    
    _strongPropertyBlock = ^(NSString *s){
        int d = w + 9;
        NSLog(@"%d",d);
    };
    
    propertyBlock = ^(NSString *s){
    
    };

    
    
    testBlock();
    NSLog(@"\ntestBlock:%@\ncopyBlock:%@\nstrongBlock:%@\ncopyPropertyBlock:%@\nstrongPropertyBlock:%@\npropertyBlock:%@\ntestOne:%@\ntestTwo:%@\ntestThree:%@",testBlock,self.copyBlock,self.strongBlock,self.copyPropertyBlock,self.strongPropertyBlock,propertyBlock,testOne,testTwo,testThree);
    
    
    
//    NSLog(@"\ntestBlock:%@\ncopyBlock:%@\nstrongBlock:%@\ncopyPropertyBlock:%@\nstrongPropertyBlock:%@\npropertyBlock:%@\ntestOne:%@\ntestTwo:%@\ntestThree:%@",[testBlock copy],[self.copyBlock copy],[self.strongBlock copy],[self.copyPropertyBlock copy],[self.strongPropertyBlock copy],[propertyBlock copy],[testOne copy],[testTwo copy],[testThree copy]);
//
}

- (void)blockPropertyNum{
    auto int m = 9;
    static int s = 0;

    NSArray *arr = @[@"ssss",@"eeee"];
    NSString *str = @"000000000000000";
    NSMutableArray *mutableArr = [NSMutableArray arrayWithObjects:@"11111",@"222222", nil];
    NSMutableString *mutable = [NSMutableString stringWithFormat:@"%@",@"pppppppppp"];
    //捕获局部变量
    void (^testOne)(void) = ^(void){
       
        int d = m + 10;
        NSLog(@"%d",d);
        
    };
    
    void (^testTwo)(void) = ^(void){
    
    };
    
    void (^testThree)(void) = ^(void){
    
    };

}




- (void)dealloc{
    NSLog(@"dealloc");
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

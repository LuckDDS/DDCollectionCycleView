//
//  KVCViewController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/19.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDKVCViewController.h"
#import "DDKVCTestObject.h"
#import "DDKVCSubObject.h"
@interface DDKVCViewController ()
{
    
    
}
@property (nonatomic, copy)NSString* privateName;

@property (nonatomic, strong)NSMutableArray* allData;

@end
NSString* globalName;
@implementation DDKVCViewController
{
    DDKVCTestObject* testObject;
    NSString* implementationName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    DDWebView * webView = [[DDWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [webView loadUrlWithName:@"kvc"];

    [self.view addSubview:webView];
    testObject = [[DDKVCTestObject alloc]init];
    DDKVCSubObject* subObject = [[DDKVCSubObject alloc]init];
    NSDictionary* testData = @{@"objectType":@(100),@"objectName":@"董德帅",@"arrAllData":@[],@"subObject":subObject,@"id":@"110110"};
    [testObject setValuesForKeysWithDictionary:testData];
    
    [testObject setValue:@"name" forKeyPath:@"subObject.subName"];
    NSLog(@"%@",[testObject valueForKeyPath:@"subObject.subName"]);
    [self testOne];
    // Do any additional setup after loading the view.
}
- (void)changeName{
    globalName = @"globalName";
    implementationName = @"implementationName";
    self.privateName = @"privateName";
}
- (void)testOne{
    NSArray* arr = @[@{@"name":@"赵",@"age":@"1"},@{@"name":@"钱",@"age":@"2"},@{@"name":@"孙",@"age":@"3"},@{@"name":@"李",@"age":@"4"},@{@"name":@"周",@"age":@"5"},@{@"name":@"周",@"age":@"6"}];
    NSDictionary* dict = [arr dictionaryWithValuesForKeys:@[@"age",@"name"]];
    self.allData = [NSMutableArray arrayWithArray:arr];
    NSLog(@"%p\n%p\n%p\n%p\n",arr,&arr,self.allData,&_allData);
    [self addObserver:self forKeyPath:@"allData" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    //可以用来监听数组的变化
    NSMutableArray* mutableAllData = [self mutableArrayValueForKey:@"allData"];
    [mutableAllData addObject:@{@"name":@"郑",@"age":@"7"}];
    
    NSLog(@"%@",dict);
    //求平均数
    NSNumber* avgNum = [arr valueForKeyPath:@"@avg.age"];
    //求和
    NSNumber* ageNum = [arr valueForKeyPath:@"@sum.age"];
    //求数组元素的个数
    NSNumber* countNum = [arr valueForKeyPath:@"@count"];
    //求最大值
    NSNumber* maxNum = [arr valueForKeyPath:@"@max.age"];
    //求最小值
    NSNumber* minNum = [arr valueForKeyPath:@"@min.age"];
    //取某个key下的value放入数组返回
    NSArray* arrValue = [arr valueForKeyPath:@"@unionOfObjects.name"];
    //取某个key下的value放入数组返回并去重
    NSArray* arrValues = [arr valueForKeyPath:@"@distinctUnionOfObjects.name"];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    NSLog(@"%@%@",keyPath,change[@"new"]);

}

- (void)willChangeValueForKey:(NSString *)key{
    NSLog(@"willKey:%@",key);
}
- (void)didChangeValueForKey:(NSString *)key{
    NSLog(@"didKey:%@",key);
}

- (void)printName{
    
    NSLog(@"%@",globalName);
    NSLog(@"%@",implementationName);
    NSLog(@"%@",self.privateName);
    
}

//这个是获取值时防崩溃的
- (id)valueForUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"globalName"]) {
        return @"董";
    }
    return @"0";
}

//这个方法是设置值时防崩溃的
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"报错的KEY:%@",key);
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

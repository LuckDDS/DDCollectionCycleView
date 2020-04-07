//
//  HeapAndStackController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/13.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//  堆(heap)和栈(stack)



/**
总结

 内存分区由高到低为
 栈:(线性结构)
    存放临时变量,局部变量,函数的参数值等
    主要是存储的指针,当然偶尔也会存储一些数据,比如当字符串很少时,会以NSTaggedPointerString类型和指针存储到一起
 堆:(链表结构)
    由程序员管理的内存(MRC)使用alloc开辟堆内存,或者使用C语言中malloc等方法创建的
 全局静态区
    数据区
        存放已经初始话的全局变量,即静态分配(static)的变量和全局变量
        举例
            @interface DDHeapAndStackController ()
            @end
            NSString *str = @"测试数据";
            static NSString *str1 = @"";
            @implementation DDHeapAndStackController
            这个时候str和str1存储在数据区
 
    BSS区
        存放程序中已经定义但是未初始话的数据
        举例
        @interface DDHeapAndStackController ()
        @end
        NSString *str ;
        static NSString *str1;
        @implementation DDHeapAndStackController
        这个时候str和str1存储在BSS区
 常量区
    存放的是常量的值举例如下
    (1)
    -(void)test{
        NSString *str = @"测试数据";
        str:存储在栈中
        str的值测试数据存储在常量区
 
    }
    (2)
    @interface DDHeapAndStackController ()
    @end
    NSString *str = @"测试数据";
    @implementation DDHeapAndStackController
    这个时候"测试数据"也是存储在常量区
    总结来说就是没有在堆中存储的数据都会放到这里
 
 
    这块有个疑问是常量区在程序结束时才会释放,那是否意味着我们尽量不要使用常量这种东西呢?比如在函数里面定义的话是alloc一块堆内存更好还是定义一个指针指向一个常量更好?
 代码区
    存放的是二进制的代码,需要保证二进制文件在运行时不能被修改,只读
        
 
 1.使用alloc的oc对象和使用malloc或者其他方式的C语言需要进行内存管理
 2.堆里面的内存是动态分配的,
 3.栈的分配有两种
   (1).静态分配
       比如局部变量的分配
        NSString *str = @"1";
   (2).动态分配
       是通过alloc函数创建分配的,但是与堆不同的是他是由栈来管理的
       NSString *str1 = [[NSString alloc]initWithFormat:@"%@",@"123"];
 4.在MRC时代堆里面的内存需要手动释放,ARC时代自动管理不需要释放.但是仅限于OC,C语言的内容还是需要手动释放
 5.举例
   NSObject *obj = [[NSObject alloc]init];
   *obj 这是指针地址,存储在栈中
   *obj 指针指向的对象存储在堆中
 6.函数是存放在栈中的,-(void)functionName{}这是存放在栈中的当调用这个函数时,编译器会为其在栈中创建一个帧(frame),每次调用方法都会为其创建一个帧,调用方法的过程就是入栈,当方法执行完毕时就开始出栈行为.这也解释了为什么局部变量会存放在栈中了
 7.iOS有优化比如定义一个字符串如果字符串过短不会将其内容分配到堆上而是会将其以NSTaggedPointerString的方式存放到指针存放的位置.'
*/

#import "DDHeapAndStackController.h"
#import "DDWebView.h"
@interface DDHeapAndStackController ()

@end
//str3位于数据区,它的值位于常量区
NSString *str3 = @"123456789";
//str位于BSS区未初始话
NSString *str4;
//str5位于数据区,他的值位于常量区
NSString * const str5 = @"1234567890";
//s4位于BSS区
NSMutableString *s4;
//str6位于BSS区
const NSString *str6;
@implementation DDHeapAndStackController
{
    //str7位于BSS区
    NSString* str7;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    DDWebView * webView = [[DDWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [webView loadUrlWithName:@"HeapandStack"];
    [self.view addSubview:webView];
    NSLog(@"%p,%p",webView,&webView);
    //str的指针存在在栈中,他的值存储在常量区
    NSString *str = @"123";
    //str1在栈中,值位于堆中
    NSString *str1 = [[NSString alloc]initWithFormat:@"%@",@"1234"];
    //str2在栈中,值位于堆中
    NSString *str2 = [NSString stringWithFormat:@"%@",@"1235"];
    
    
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",str,&str);//4341667256,6089652576
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",str1,&str1);//堆,6089652568
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",str2,&str2);//堆,6089652560
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",str3,&str3);//4341666712,4341730944
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",str4,&str4);//,4341731536
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",str5,&str5);//4341667192,4341662376
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",str6,&str6);//,4341731544
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",str7,&str7);//,5869012368
    
    [self testStack];
    
    
    // Do any additional setup after loading the view.
}

//这个函数是在栈中,当调用这个函数的时候会在栈中产生一个帧(frame),调用的时候就是入栈
- (void)testStack{
    //s的数据存储在常量区,s的在栈帧中
    NSString *s = @"123";
    //s1的数据存储在堆中,s1在栈帧中
    NSString *s1 = [NSString stringWithFormat:@"%@",@"123456"];
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",s,&s);//4341667256,6089652424
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",s1,&s1);//,6089652416
    
    
    //即使s2和s3的值相同,他们也不指向同一块内存,因为是可变的所以他们的内存地址会指向一块新的
    //s2和s3都位于栈帧中,他们值位于堆中
    NSMutableString *s2 = [[NSMutableString alloc]initWithFormat:@"1234567"];
    NSMutableString *s3 = [[NSMutableString alloc]initWithFormat:@"1234567"];

    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",s2,&s2);//10782346384,6089652408
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",s3,&s3);//10782355072,6089652400
    NSLog(@"数据存储的首地址%p,指针存储的首地址%p",s4,&s4);//,4341731552
//13383510514074235000
//10795875472

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

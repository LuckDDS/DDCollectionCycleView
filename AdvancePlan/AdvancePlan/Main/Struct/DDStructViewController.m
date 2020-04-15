//
//  DDStructViewController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/17.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDStructViewController.h"
#import "DDWebView.h"
struct Student{
    NSString *name;
    float score;
    struct Student *next;
}s = {};
@interface DDStructViewController ()

@end

@implementation DDStructViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Teacher tes = {@"asd"};
    
    struct Studet{
        int m;
        int n;
    } stru,srr = {1,2};

    DDWebView * webView = [[DDWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [webView loadUrlWithName:@"struct"];
    [self.view addSubview:webView];

    //通过struct制作一个简单的链表
    [self makeLinkList];
    Teacher teacher = {@"123"};
    
    //使用指针传值更快
    [self structAsParam1:teacher];
    [self structAsParam:&teacher];
    NSLog(@"%@",teacher.name);

    
    // Do any additional setup after loading the view.
}

//传递的是变量
- (void)structAsParam1:(Teacher)teacher{
    NSLog(@"%@",teacher.name);
    teacher.name = @"原始参数不改变";
}

//传递的是指针
- (void)structAsParam:(Teacher *)teacher{
    NSLog(@"%@",teacher->name);
    (*teacher).name = @"原始参数改变";
}

- (void)makeLinkList{
    struct Student a,b,c, *head,*p;
    a.name = @"我"; a.score = 123;
    b.name = @"你"; b.score = 231;
    c.name = @"他"; c.score = 983;
    head = &a;
    a.next = &b;
    b.next = &c;
    c.next = NULL;
    p = head;
    
    do {
        NSLog(@"%@,%f",p->name,p->score);
        p = p->next;
//        p = (*p).next;
    } while (p != NULL);
    
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

//
//  DDWebView.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/15.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDWebView.h"
#import <WebKit/WebKit.h>
@implementation DDWebView
{
    WKWebView *webView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildWebView];
    }
    return self;
}

- (void)buildWebView{
    
    webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

    [self addSubview:webView];
    
}

- (void)loadUrlWithName:(NSString *)name{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"html"];
    [webView loadFileURL:[NSURL fileURLWithPath:filePath] allowingReadAccessToURL:[NSBundle mainBundle].resourceURL];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

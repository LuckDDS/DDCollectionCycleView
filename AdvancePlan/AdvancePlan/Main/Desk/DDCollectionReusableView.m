//
//  DDCollectionReusableView.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/21.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCollectionReusableView.h"

@implementation DDCollectionReusableView
{
    UILabel *headerLab;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    
    headerLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    headerLab.backgroundColor = [UIColor lightGrayColor];
    headerLab.font = [UIFont systemFontOfSize:18];
    headerLab.textAlignment = NSTextAlignmentLeft;
    headerLab.textColor = [UIColor redColor];
    [self addSubview:headerLab];

}

- (void)reloadData:(NSString *)data{
    headerLab.text = data;
}
@end


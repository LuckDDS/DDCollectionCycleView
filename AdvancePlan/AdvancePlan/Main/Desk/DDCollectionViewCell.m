//
//  DDCollectionViewCell.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/21.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCollectionViewCell.h"

@implementation DDCollectionViewCell
{
    UIView *backView;
    UILabel *titleLab;
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
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    backView.backgroundColor = [UIColor colorNamed:@"blackColor"];
    backView.layer.masksToBounds = YES;
    backView.layer.borderColor = [UIColor grayColor].CGColor;
    backView.layer.borderWidth = 1;
    [self.contentView addSubview:backView];
    
    titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height)];
    titleLab.center = CGPointMake(backView.frame.size.width/2, backView.frame.size.height/2);
    titleLab.backgroundColor = [UIColor whiteColor];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor redColor];
    [backView addSubview:titleLab];
    
}

- (void)reloadData:(NSString *)data{
    
    titleLab.text = data;
    
}

@end

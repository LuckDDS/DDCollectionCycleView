//
//  DDCollectionViewLayoutCell.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/25.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCollectionViewLayoutCell.h"

@implementation DDCollectionViewLayoutCell
{
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
    
    titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    titleLab.backgroundColor = [UIColor whiteColor];
    titleLab.layer.masksToBounds = YES;
    titleLab.layer.borderColor = [UIColor magentaColor].CGColor;
    titleLab.layer.borderWidth = 1;
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor redColor];
    [self.contentView addSubview:titleLab];
}

- (void)reloadLabelContent:(NSString *)content{
    
    titleLab.text = content;
    
}
@end

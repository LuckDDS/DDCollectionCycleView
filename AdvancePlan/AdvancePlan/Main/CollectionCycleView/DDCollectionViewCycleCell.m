//
//  DDCollectionViewCycleCell.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/26.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCollectionViewCycleCell.h"
#import <UIImageView+WebCache.h>
@implementation DDCollectionViewCycleCell
{
    UILabel *titleLab;
    UIImageView * img;
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
    img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.frame.size.height)];
    [self.contentView addSubview:img];

    titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 30)];
    titleLab.backgroundColor = [UIColor whiteColor];
    titleLab.layer.masksToBounds = YES;
    titleLab.layer.borderColor = [UIColor magentaColor].CGColor;
    titleLab.layer.borderWidth = 1;
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor redColor];
    [img addSubview:titleLab];
    
}

- (void)reloadLabelContent:(NSDictionary *)content andIndexPathRow:(NSInteger)indexPathRow{
    
    [img sd_setImageWithURL:[NSURL URLWithString:content[@"img"]]];

//    img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",content]];
    titleLab.text = content[@"other"];
    
}

@end

//
//  NSString+Extention.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/25.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extention)
/**
 返回字符串的长度
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


@end

NS_ASSUME_NONNULL_END

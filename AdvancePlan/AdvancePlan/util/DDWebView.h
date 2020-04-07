//
//  DDWebView.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/15.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDWebView : UIView
@property(nonatomic, copy) NSString *s;
- (void)loadUrlWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END

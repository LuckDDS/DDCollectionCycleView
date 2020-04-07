//
//  DDCopyAndMutableTest.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/23.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCopyAndMutableTest.h"
#import "DDCopyAndMutableCopyTest.h"
@implementation DDCopyAndMutableTest
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)printData{
    NSLog(@"%@",self.strCopy);
}

- (void)printMutableData{
    NSLog(@"%@",self.mutableStrCopy);
}

- (void)changeData{
    self.strCopy = @"13123";
}

- (void)changeStrongData{
    self.strStrong = @"nilll";
}

- (void)printStrongData{
    NSLog(@"%@",self.strStrong);
}

- (void)changeMutableData{
    [self.mutableStrCopy appendString:@"123123"];
}

- (void)printTest{
    NSLog(@"%@",self.testCopy.strCopy);
}


-(id)copyWithZone:(NSZone *)zone{
    
    
    return self;
    
}
@end

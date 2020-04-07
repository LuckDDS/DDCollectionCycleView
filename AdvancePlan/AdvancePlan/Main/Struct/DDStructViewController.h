//
//  DDStructViewController.h
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/17.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDRootViewController.h"


NS_ASSUME_NONNULL_BEGIN
//这种方式定义struct不能直接声明struct变量
struct student{
    int n;
};

//使用typedef修饰的struct可以直接定义struct变量
typedef struct teacher {
    
    NSString * name;
    int age;

} teacher1,teacher2;
//如果值需要一个变量可以省去结构体名称
typedef struct{
    
    NSString *name;
    
} Teacher;
@interface DDStructViewController : DDRootViewController

@end

NS_ASSUME_NONNULL_END

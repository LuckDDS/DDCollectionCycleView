//
//  DDBlockStudy.c
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/17.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#include "DDBlockStudy.h"
//全局的
int w = 23;
static int e = 10;
int f[] = {11,22,33,44};

void buildBlock(){
    
    int m = 1;
    static int n = 3;
    int arr[] = {1,2,3,4,5,6};
    
    void (^testBlock)(int)= ^(int d){
        w = 2;
        e = 32;
//        m = 3;
        n = 35;
        printf("\n%d,%d,%d,%d,%d\n", w,e,*f,m,n);
    };
    w = 12;
    e = 14;
    *f = 32;
    m = 4;
    n = 10;
    testBlock(3);
    
}

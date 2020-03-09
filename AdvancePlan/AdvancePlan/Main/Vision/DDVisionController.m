//
//  DDVisionController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/9.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDVisionController.h"
#import <Vision/Vision.h>

@interface DDVisionController ()

@end

@implementation DDVisionController

- (void)viewDidLoad {
    [super viewDidLoad];
    VNFaceLandmarks *faceLandMark = [VNFaceLandmarks2D alloc];
    VNDetectFaceLandmarksRequest *s;
//    VNDetectFaceLandmarksRequestRevision1 d;
//    VNDetectHorizonRequest f;
    VNCoreMLModel *mdel;
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

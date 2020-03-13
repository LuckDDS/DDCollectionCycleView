//
//  DDVisionController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/9.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDVisionController.h"
#import <Vision/Vision.h>
#import <AVKit/AVKit.h>
#import "MobileNetV2.h"

@interface DDVisionController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong)NSMutableArray *allPoints;
@end


@implementation DDVisionController
{
    AVCaptureSession *captureSession;
    
    AVCaptureVideoPreviewLayer *captureLayer;
    
    size_t imgWidth;
    size_t imgHeight;
    float playerWidth;
    float playerHeight;
    
    BOOL isEnd;
    NSMutableSet *allPoints;
    NSMutableArray *allFeatures;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    allPoints = [[NSMutableSet alloc]init];
    self.navigationController.navigationBar.hidden = YES;
    allFeatures = [NSMutableArray array];
    self.allPoints;
    isEnd = YES;
    [self buildCamera];
    [self buildBtn];
    for (int m = 0; m < 65; m ++) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
        lab.backgroundColor = [UIColor redColor];
        lab.layer.masksToBounds = YES;
        lab.layer.cornerRadius = 4;
        [self.view addSubview:lab];
        [allFeatures addObject:lab];
    }
    

    // Do any additional setup after loading the view.
}

- (void)buildBtn{
    
    UIButton * beginLoad = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3*2, self.view.frame.size.height-30, self.view.frame.size.width/3, 30)];
    [beginLoad setBackgroundColor:[UIColor redColor]];
    [beginLoad setTitle:@"开始" forState:(UIControlStateNormal)];
    [beginLoad setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [beginLoad addTarget:self action:@selector(beginLoad) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:beginLoad];
    
    UIButton * stopLoad = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width/3, 30)];
    [stopLoad setBackgroundColor:[UIColor redColor]];
    [stopLoad setTitle:@"停止" forState:(UIControlStateNormal)];
    [stopLoad setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [stopLoad addTarget:self action:@selector(stopLoad) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:stopLoad];

}

- (void)beginLoad{
    if (![captureSession isRunning]) {
        [captureSession startRunning];
    }
}

- (void)stopLoad{
    
    if ([captureSession isRunning]) {
        [captureSession stopRunning];
    }
}

- (void)buildCamera{

    //初始话设备
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
    
    AVCapturePhotoSettings *phoneSetting = [AVCapturePhotoSettings photoSettings];
    phoneSetting.flashMode = AVCaptureFlashModeAuto;
        
    //初始话输入
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    //初始话管理
    captureSession = [[AVCaptureSession alloc]init];
    if (![captureSession canAddInput:deviceInput]) {
        NSLog(@"添加输出设备失败");
    }
    [captureSession addInput:deviceInput];
    [captureSession beginConfiguration];
    if ([captureDevice supportsAVCaptureSessionPreset:AVCaptureSessionPreset352x288]) {
        if ([captureSession canSetSessionPreset:AVCaptureSessionPreset352x288]) {
            [captureSession setSessionPreset:AVCaptureSessionPreset352x288];
        }
    }
    //初始话输出设备
    AVCaptureVideoDataOutput *dataOut = [AVCaptureVideoDataOutput new];
    NSDictionary * outSet = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                    forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    [dataOut setVideoSettings:outSet];

    [dataOut setAlwaysDiscardsLateVideoFrames:YES];
    [dataOut setAutomaticallyConfiguresOutputBufferDimensions:YES];
    dispatch_queue_t queue = dispatch_queue_create("sss", DISPATCH_QUEUE_SERIAL);
    [dataOut setSampleBufferDelegate:self queue:queue];
    
    if(![captureSession canAddOutput:dataOut]){
        NSLog(@"添加输出失败");
    }
    [captureSession addOutput:dataOut];

    [captureSession commitConfiguration];
    //设置展示图像的图层
    captureLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:captureSession];
    //设置图层的大小
    float outPutVideoScale = 352.0 / 288.0;
    if (outPutVideoScale > self.view.frame.size.height/self.view.frame.size.width) {
        playerWidth = self.view.frame.size.width;
        playerHeight = self.view.frame.size.height;

    }else{
        playerWidth = self.view.frame.size.width;
        playerHeight = self.view.frame.size.width*outPutVideoScale;
    }
    captureLayer.frame = CGRectMake(0, 0, playerWidth, playerHeight);
    
    //设置填充模式
    captureLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //添加显示
    [self.view.layer addSublayer:captureLayer];
    
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    if (isEnd) {
        isEnd = NO;
        //获取CVImageBufferRef图片缓冲区
        CVImageBufferRef buffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        //创建完成回调
        VNRequestCompletionHandler completionHandler = ^(VNRequest *request,NSError *error){
            if (error) {
                NSLog(@"失败");
            }else{
                //识别的结果
                [self->_allPoints removeAllObjects];
                NSArray * allObservation = request.results;
                CGRect boundingbox = CGRectMake(0, 0, 0, 0);
                //获取结果中的每一个observation
                for (VNFaceObservation *observation in allObservation) {
                    //boundingBox是脸部整体的位置大小
                    boundingbox = observation.boundingBox;
                    //获取面部landMark
                    VNFaceLandmarks2D *faceLandMark = observation.landmarks;
                    //获取全部的点
                    VNFaceLandmarkRegion2D *region = faceLandMark.allPoints;
                    //一共有多少点
                    NSInteger markNum = region.pointCount;

                    for (int m = 0; m < markNum; m ++) {
                        //normalizedPoints是一个数组指针,默认指向第一个累加即可获得其中的坐标
                        //注意,featureLocation的范围是0-1,需要乘以图片的实际宽高
                        CGPoint featureLocation = region.normalizedPoints[m];
//                        [self->allPoints addObject:featureLocation];
                        [self->_allPoints addObject:[NSValue valueWithCGPoint:featureLocation]];
                    }

                }

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self buildFeatureOnPlayerWithBoundingbox:boundingbox];
                    
                });
                
            }
        };
        //创建一个面部识别的请求
        VNDetectFaceLandmarksRequest *landmarkRequest = [[VNDetectFaceLandmarksRequest alloc]initWithCompletionHandler:completionHandler];
        //设置返回的面部信息的点数
        landmarkRequest.constellation = VNRequestFaceLandmarksConstellation65Points;
        //创建一个图片资源
        VNImageRequestHandler *imageRequestHandler = [[VNImageRequestHandler alloc]initWithCVPixelBuffer:buffer orientation:kCGImagePropertyOrientationRight options:@{}];
        //开始识别,返回识别是否成功
        NSError *err;
        BOOL success = [imageRequestHandler performRequests:@[landmarkRequest] error:&err];
        isEnd = YES;
    
    }

}
- (void)buildFeatureOnPlayerWithBoundingbox:(CGRect)boundingBox{
    
    NSInteger pointNum = _allPoints.count;
    float tempX1 = playerWidth - playerWidth * boundingBox.origin.x;
    float tempX2 =  playerWidth * boundingBox.size.width;
    
    float tempY1 = playerHeight - playerHeight * boundingBox.origin.y;
    float tempY2 =  playerHeight * boundingBox.size.height;

    for (int m = 0; m < pointNum; m ++) {
        CGPoint point = [_allPoints[m] CGPointValue];
        UILabel * lab = allFeatures[m];
        //因为使用的是前置摄像头所以导致坐标方位全部颠倒,所以要计算x和y的位置
        float x = tempX1 - tempX2 * point.x;
        float y = tempY1 -tempY2 * point.y;

        lab.center = CGPointMake(x, y);
    }

}

- (NSMutableArray *)allPoints{
    if (!_allPoints) {
        _allPoints = [NSMutableArray array];
    }
    return _allPoints;
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

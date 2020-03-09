//
//  DDCIFeatureViewController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/3/2.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCIFeatureViewController.h"
#import <AVFoundation/AVFoundation.h>
//#import <ImageIO/ImageIO.h>
//#import <Vision/Vision.h>

#import "DDFaceFeature.h"

@interface DDCIFeatureViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@end

@implementation DDCIFeatureViewController
{
    //相机管理
    AVCaptureSession *captureSession;
    
    AVCaptureVideoPreviewLayer *captureLayer;
    
    size_t imgWidth;
    size_t imgHeight;
    float playerWidth;
    float playerHeight;

    UIView *tipView;
    
    //屏幕分辨率比
    float screenScale;
    
    CALayer *mouthLayer;

    float mouthWidth;
    float mouthHeight;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mouthWidth = 100;
    mouthHeight = 40;
    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.title = @"CIFeature";
    [self configAVCaptureDevice];
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
    screenScale = [UIScreen mainScreen].scale;
    // Do any additional setup after loading the view.
}

- (void)beginLoad{
    if (![captureSession isRunning]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNotifitoin:) name:AVCaptureSessionRuntimeErrorNotification object:nil];
        [captureSession startRunning];
    }
}

- (void)stopLoad{
    
    if ([captureSession isRunning]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureSessionRuntimeErrorNotification object:nil];
        [captureSession stopRunning];
    }
}

- (void)addNotifitoin:(NSNotification *)notifition{

    NSLog(@"报错了");
}

//配置摄像头
- (void)configAVCaptureDevice{

    //初始话设备
    AVCaptureDevice *captureDevice;

    if (self.featureType == DDCIFeatureFace) {
        
        captureDevice= [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
        
    }else if(self.featureType == DDCIFeatureText){
        
        captureDevice= [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera  mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    }
    
    //如果是前置摄像头使用自动聚焦
    if (captureDevice.position == AVCaptureDevicePositionFront) {
        //使用自动聚焦模式
        if ([captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
    }
    
    //初始话输入设备
    NSError *error;
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"初始话相机失败");
        return;
    }
    
    //设置管理设备
    captureSession = [[AVCaptureSession alloc]init];
    if (![captureSession canAddInput:captureInput]) {
        NSLog(@"添加输出装备失败");
        return;
    }
    [captureSession addInput:captureInput];
    
    if ([self captureSession:captureSession withCaptureDevice:captureDevice withSessionPreset:AVCaptureSessionPreset640x480]) {
        [captureSession setSessionPreset:AVCaptureSessionPreset640x480];
    }else if ([self captureSession:captureSession withCaptureDevice:captureDevice withSessionPreset:AVCaptureSessionPresetiFrame960x540]){
        [captureSession setSessionPreset:AVCaptureSessionPresetiFrame960x540];
    }else if([self captureSession:captureSession withCaptureDevice:captureDevice withSessionPreset:AVCaptureSessionPreset1280x720]){
        [captureSession setSessionPreset:AVCaptureSessionPreset1280x720];
    }else{
        [captureSession setSessionPreset:AVCaptureSessionPresetMedium];
    }
    //设置输出设备
    AVCaptureVideoDataOutput *captureOutout = [[AVCaptureVideoDataOutput alloc]init];
    if (![captureSession canAddOutput:captureOutout]) {
        NSLog(@"添加输出设备失败");
        return;
    }
    [captureSession addOutput:captureOutout];
    //丢弃延时的帧
    [captureOutout setAlwaysDiscardsLateVideoFrames:YES];
    
    NSDictionary * outSet = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                                        forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    //配置视频输出设置
    [captureOutout setVideoSettings:outSet];
    //创建队列
    dispatch_queue_t queue = dispatch_queue_create("mainqueue", DISPATCH_QUEUE_SERIAL);
    //添加代理,设置队列
    [captureOutout setSampleBufferDelegate:self queue:queue];
    
    //设置展示图像的图层
    captureLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:captureSession];
    //设置图层的大小
    playerWidth = self.view.frame.size.width;
    playerHeight = self.view.frame.size.height;
    captureLayer.frame = CGRectMake(0, 0, playerWidth, playerHeight);
    //设置填充模式
    captureLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //添加显示
    [self.view.layer addSublayer:captureLayer];
    tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    tipView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:tipView];
    
    mouthLayer = [CALayer layer];
    mouthLayer.backgroundColor = [UIColor redColor].CGColor;
    [captureLayer addSublayer:mouthLayer];
    
}

//判断当前设备是否支持相应的AVCaptureSessionPreset
- (BOOL)captureSession:(AVCaptureSession *)captureSession
     withCaptureDevice:(AVCaptureDevice *)captureDevice
     withSessionPreset:(AVCaptureSessionPreset)sessionPreset
{
         
     if ([captureSession canSetSessionPreset:sessionPreset]) {
         
         if ([captureDevice supportsAVCaptureSessionPreset:sessionPreset]) {
             [captureSession setSessionPreset:sessionPreset];
             return YES;
         }else{
             return NO;
         }

     }else{
         return NO;
     }

}

#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate
//被调用每次输出设备输出帧的时候
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{

    //解析CMSampleBufferRef
    CVImageBufferRef bufferRef = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(bufferRef, 0);
    
    //构建面部特征
    [self buildFaceFeatureLocationWithBuffer:bufferRef];
    CVPixelBufferUnlockBaseAddress(bufferRef, 0);

    
}

- (void)buildFaceFeatureLocationWithBuffer:(CVImageBufferRef)bufferRef{
    CGPoint point = [DDFACEFEATURE caculateFaceFeatureWithBufferRef:bufferRef  withPlayerSize:CGSizeMake(playerWidth, playerHeight) withFaceFeatureType:FaceFeatureMouth];

    if (point.x == 0 && point.y == 0) {

    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self buildFaceLocationWithFeatureLocation:point];
        });
    }

}

- (void)buildFaceLocationWithFeatureLocation:(CGPoint)featureLocation{
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    mouthLayer.frame = CGRectMake(featureLocation.x - mouthWidth / 2,featureLocation.y - mouthHeight / 2,mouthWidth, mouthHeight);
    [CATransaction commit];
    
}

//丢弃的帧会从这里调用
- (void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection API_AVAILABLE(ios(6.0)){
    NSLog(@"丢帧了");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopLoad];
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

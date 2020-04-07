//
//  DDObjectRecognitionViewController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/4/3.
//  Copyright © 2020 www.dong.com 九天. All rights reserved.
//

#import "DDObjectRecognitionViewController.h"
#import <AVKit/AVKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface DDObjectRecognitionViewController ()

@end

@implementation DDObjectRecognitionViewController
{
    AVCaptureSession *captureSession;
    
    AVCaptureVideoPreviewLayer *captureLayer;
    
    size_t imgWidth;
    size_t imgHeight;
    float playerWidth;
    float playerHeight;
    
    UILabel *testLab;
    
    CIImage *image;
    CIContext *context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    context = [CIContext context];
    self.navigationController.navigationBar.hidden = YES;
    
    [self buildCamera];
    [self buildBtn];

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
        return;
    }
    [captureSession addInput:deviceInput];
    [captureSession beginConfiguration];
    if ([captureDevice supportsAVCaptureSessionPreset:AVCaptureSessionPreset640x480]) {
        if ([captureSession canSetSessionPreset:AVCaptureSessionPreset640x480]) {
            [captureSession setSessionPreset:AVCaptureSessionPreset640x480];
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
        return;
    }
    [captureSession addOutput:dataOut];

    [captureSession commitConfiguration];
    //设置展示图像的图层
    captureLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:captureSession];
    //设置图层的大小
    float outPutVideoScale = 640.0 / 480.0;
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

    
    testLab = [[UILabel alloc]initWithFrame:CGRectMake(0, playerHeight-(playerHeight-224)/2+(playerHeight - 224)/2, self.view.frame.size.width, 150)];
    testLab.numberOfLines = 0;
    testLab.lineBreakMode = NSLineBreakByWordWrapping;
    testLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:testLab];
    
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    //获取CVImageBufferRef图片缓冲区
    CVImageBufferRef buffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    //直接转为CIImage且旋转
    image = [[CIImage imageWithCVImageBuffer:buffer] imageByApplyingCGOrientation:kCGImagePropertyOrientationRight];
    //创建图层
    [context clearCaches];
    //获取CGImageRef数据
    CGImageRef cgImgRef = [context createCGImage:image fromRect:CGRectMake(0, 0/2, 480, 640)];
    
    CVImageBufferRef bufferRef = [self pixelBufferFromCGImage:cgImgRef];
    CGImageRelease(cgImgRef);
//    NSError *error;
//    outPut = [model predictionFromImage:bufferRef error:&error];
    CVPixelBufferRelease(bufferRef);
//    if (error) {
//        NSLog(@"报错了");
//    }else{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self->testLab.text = self->outPut.classLabel;
//        });
//    }

}

- (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image
{
    NSDictionary *options = @{
                              (NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]
                              };
    CVPixelBufferRef pxbuffer = NULL;
    
    CGFloat frameWidth = CGImageGetWidth(image);
    CGFloat frameHeight = CGImageGetHeight(image);
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          frameWidth,
                                          frameHeight,
                                          kCVPixelFormatType_32BGRA,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate(pxdata,
                                                 frameWidth,
                                                 frameHeight,
                                                 8,
                                                 CVPixelBufferGetBytesPerRow(pxbuffer),
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0,
                                           0,
                                           frameWidth,
                                           frameHeight),
                       image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
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

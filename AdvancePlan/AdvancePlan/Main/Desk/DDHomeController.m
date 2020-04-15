//
//  DDHomeController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/21.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDHomeController.h"
#import "DDCollectionViewCell.h"
#import "DDCollectionViewFlowLayoutOverRide.h"
#import "DDCollectionReusableView.h"
#import "DDCollectionLayoutController.h"
#import "DDCollectionCycleController.h"
#import "DDCIFeatureViewController.h"
#import "DDVisionController.h"
#import "DDMobileNetController.h"
#import "DDBlockViewController.h"
#import "DDHeapAndStackController.h"
#import "DDCfeatureViewController.h"
#import "DDStructViewController.h"
#import "DDKVOViewController.h"
#import "DDKVCViewController.h"
#import "DDCopyAndMutableCopyController.h"
#import "DDObjectRecognitionViewController.h"
#import "DDUIBezierPathViewController.h"
#import "DDCoreGraphicsViewController.h"
@interface DDHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *homeCollectionView;
@property (nonatomic, strong) DDCollectionViewFlowLayoutOverRide *homeCollectionViewLayout;
@property (nonatomic, copy) NSMutableArray * allDataArr;


@end

@implementation DDHomeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    
    [self requestData];
    [self buildHomeView];
    // Do any additional setup after loading the view.
}

- (void)requestData{
    NSArray *headers = @[@"UICollectionViewLayout",@"drawView",@"CIFeature",@"Vision",@"Basics",@"ObjectRecognition"];
    
    for (int i = 0; i < headers.count; i ++) {
        NSMutableDictionary * unitDict = [NSMutableDictionary new];
        [unitDict setValue:[NSString stringWithFormat:@"%@",headers[i]] forKey:@"headerName"];
        if (i == 0) {
            [unitDict setValue:@[@"自定义瀑布流",@"轮播图"] forKey:@"content"];
        }else if (i == 1){
            [unitDict setValue:@[@"coreGraphics",@"UIBezierPath"] forKey:@"content"];
        }else if (i == 2){
            [unitDict setValue:@[@"Vision",@"MobileNet"] forKey:@"content"];
        }else if (i == 3){
            [unitDict setValue:@[@"堆栈",@"C语言特性",@"Struct(结构体)",@"Block",@"KVC",@"KVO",@"copy和mutableCopy",@"GCD",@"NSThread",@"NSOperation",@"锁",@"socket",@"链表",@"MVC",@"MVVM",@"MVP"] forKey:@"content"];
        }else if (i == 4){
            [unitDict setValue:@[@"CIFeatureTypeFace(人脸识别)"] forKey:@"content"];
        }else if (i == 5){
            [unitDict setValue:@[@"ObjectRecognition"] forKey:@"content"];
        }
        [self.allDataArr addObject:unitDict];
    }
    
}

- (void)buildHomeView{
    
    [self.view addSubview:self.homeCollectionView];
    [_homeCollectionView registerClass:[DDCollectionViewCell class] forCellWithReuseIdentifier:@"subCell"];
    [_homeCollectionView registerClass:[DDCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader"];
    
}

#pragma delegate
- (nonnull __kindof DDCollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DDCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"subCell" forIndexPath:indexPath];
    [cell reloadData:_allDataArr[indexPath.section][@"content"][indexPath.row]];
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray * arr = (NSMutableArray *)(_allDataArr[section][@"content"]);
    return arr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _allDataArr.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DDRootViewController *rootVC;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            rootVC = [[DDCollectionLayoutController alloc]init];
        }else{
            rootVC = [[DDCollectionCycleController alloc]init];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            rootVC = [[DDCoreGraphicsViewController alloc]init];
        }else if (indexPath.row == 1){
            rootVC = [[DDUIBezierPathViewController alloc]init];
        }

    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            rootVC = [[DDVisionController alloc]init];
        }else{
            rootVC = [[DDMobileNetController alloc]init];
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            rootVC = [[DDHeapAndStackController alloc]init];
        }else if(indexPath.row == 1){
            rootVC = [[DDCfeatureViewController alloc]init];
        }else if (indexPath.row == 2){
            rootVC = [[DDStructViewController alloc]init];
        }else if(indexPath.row == 3){
            rootVC = [[DDBlockViewController alloc]init];
        }else if (indexPath.row == 4){
            rootVC = [[DDKVCViewController alloc]init];
            [(DDKVCViewController*)rootVC changeName];
            [(DDKVCViewController*)rootVC setValue:@"董" forKey:@"globalName"];
            [(DDKVCViewController*)rootVC setValue:@"德" forKey:@"implementationName"];
            [(DDKVCViewController*)rootVC setValue:@"帅" forKey:@"privateName"];
            [(DDKVCViewController*)rootVC setValue:@"666" forKey:@"999"];
            [(DDKVCViewController*)rootVC setValue:@"董" forKeyPath:@"globalName"];
            
            [(DDKVCViewController*)rootVC printName];
        }else if(indexPath.row == 5){
            rootVC = [[DDKVOViewController alloc]init];
        }else if (indexPath.row == 6){
            rootVC = [[DDCopyAndMutableCopyController alloc]init];
        }
    }else if (indexPath.section == 4){
        rootVC = [[DDCIFeatureViewController alloc]init];
        ((DDCIFeatureViewController*)rootVC).featureType = indexPath.row;

    }else if (indexPath.section == 5){
        rootVC = [[DDObjectRecognitionViewController alloc]init];
    }
    [self.navigationController pushViewController:rootVC animated:YES];
}

- (DDCollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionFooter) {
        
        return nil;
        
    }else{
        
        DDCollectionReusableView * reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader" forIndexPath:indexPath];
        [reusableView reloadData:self.allDataArr[indexPath.section][@"headerName"]];
        return reusableView;
        
    }
    
}

- (DDCollectionViewFlowLayoutOverRide *)homeCollectionViewLayout{
    
    if (!_homeCollectionViewLayout) {
        _homeCollectionViewLayout = [[DDCollectionViewFlowLayoutOverRide alloc]init];
        _homeCollectionViewLayout.itemSize = CGSizeMake(self.view.frame.size.width, 50);
        _homeCollectionViewLayout.minimumLineSpacing = 0;
        _homeCollectionViewLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 60);
    }
    return _homeCollectionViewLayout;
}

- (UICollectionView *)homeCollectionView{
    
    if (!_homeCollectionView) {
        _homeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50) collectionViewLayout:self.homeCollectionViewLayout];
        _homeCollectionView.backgroundColor = [UIColor whiteColor];
        _homeCollectionView.delegate = self;
        _homeCollectionView.dataSource = self;
    }
    return _homeCollectionView;
}

- (NSMutableArray *)allDataArr{
    if (!_allDataArr) {
        _allDataArr = [NSMutableArray new];
    }
    return _allDataArr;

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

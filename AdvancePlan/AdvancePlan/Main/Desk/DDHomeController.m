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
    NSArray *headers = @[@"UICollectionViewLayout",@"CIFeature",@"Vision"];
    
    for (int i = 0; i < headers.count; i ++) {
        NSMutableDictionary * unitDict = [NSMutableDictionary new];
        [unitDict setValue:[NSString stringWithFormat:@"%@",headers[i]] forKey:@"headerName"];
        if (i == 0) {
            [unitDict setValue:@[@"自定义瀑布流",@"轮播图"] forKey:@"content"];
        }else if (i == 1){
            [unitDict setValue:@[@"CIFeatureTypeFace(人脸识别)"] forKey:@"content"];
        }else if (i == 2){
            [unitDict setValue:@[@"Vision"] forKey:@"content"];
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DDCollectionLayoutController *layoutController = [[DDCollectionLayoutController alloc]init];
            [self.navigationController pushViewController:layoutController animated:YES];
        }else{
            DDCollectionCycleController *cycleController = [[DDCollectionCycleController alloc]init];
            [self.navigationController pushViewController:cycleController animated:YES];
        }
    }else if (indexPath.section == 1){
        DDCIFeatureViewController *featureController = [[DDCIFeatureViewController alloc]init];
        featureController.featureType = indexPath.row;
        [self.navigationController pushViewController:featureController animated:YES];
    }else if (indexPath.section == 2){
        DDVisionController *visionController = [[DDVisionController alloc]init];
        [self.navigationController pushViewController:visionController animated:YES];
    }
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

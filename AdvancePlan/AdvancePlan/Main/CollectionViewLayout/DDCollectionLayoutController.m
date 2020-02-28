//
//  DDCollectionLayoutController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/25.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCollectionLayoutController.h"
#import "DDCollectionViewLayoutCell.h"
#import "DDCollectionViewLayout.h"
#import "NSString+Extention.h"
@interface DDCollectionLayoutController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *layoutCollectionView;
@property (nonatomic, strong) DDCollectionViewLayout *collectionViewLayout;
@property (nonatomic, copy) NSMutableArray *allDataArr;
@property (nonatomic, strong) NSMutableIndexSet *allCellIdentife;


@end

@implementation DDCollectionLayoutController
{
    NSString *tempContent;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"自定义瀑布流";
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
    [self buildHomeView];
    // Do any additional setup after loading the view.
}

//构造数据
- (void)requestData{
    
    NSMutableArray *arr = [NSMutableArray array];
    int n = 0;
    NSArray *contents = @[@"爱是什么？",@"一个精灵坐在碧绿的枝叶间沉思",@"风儿若有若无。",@" “爱。”",@"为什么？",@"过来呵呵",@"上，望",@"将要",@"的稻田。",@"问道：“你爱",@"我的",@"我",@"你爱这稻谷",@"黄澄澄的稻谷",@"你爱",@"一只鸟",@"着远处将要",@"和",@"稻田",@"大家好"];
    for (int i = 0; i < 10; i ++) {
        NSMutableArray * add = [NSMutableArray array];
        for (int m = 0; m < contents.count; m ++) {
            n++;
            [add addObject:[NSString stringWithFormat:@"%@%d",contents[m],n]];
        }
        [arr addObjectsFromArray:add];

    }
    NSMutableDictionary * unitDict = [NSMutableDictionary new];
    [unitDict setValue:@"瀑布流" forKey:@"unitName"];
    [unitDict setValue:arr forKey:@"content"];
    [self.allDataArr addObject:unitDict];
    [self.allDataArr addObject:unitDict];
    [self.allDataArr addObject:unitDict];
    [self.allDataArr addObject:unitDict];




}

- (void)buildHomeView{
    
    [self.view addSubview:self.layoutCollectionView];
    
}

#pragma delegate
- (nonnull __kindof DDCollectionViewLayoutCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger indexIdentife = indexPath.section*10000 + indexPath.row;
    if (![self.allCellIdentife containsIndex:indexIdentife]) {
        [collectionView registerClass:[DDCollectionViewLayoutCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row]];
        [self.allCellIdentife addIndex:indexIdentife];
    }
    
    DDCollectionViewLayoutCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row] forIndexPath:indexPath];
    [cell reloadLabelContent:_allDataArr[indexPath.section][@"content"][indexPath.row]];
    
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray * arr = (NSMutableArray *)(_allDataArr[section][@"content"]);
    return arr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    tempContent = _allDataArr[indexPath.section][@"content"][indexPath.row];
    return [tempContent sizeWithFont:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(self.view.frame.size.width-30, 100)];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _allDataArr.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (DDCollectionViewLayout *)collectionViewLayout{
    
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[DDCollectionViewLayout alloc]init];
        _collectionViewLayout.interitemSpacing = 10;
        _collectionViewLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 60);
        _collectionViewLayout.layoutAlignment = UILayoutAlignmentRight;
    }
    return _collectionViewLayout;
}

- (UICollectionView *)layoutCollectionView{
    
    if (!_layoutCollectionView) {
        _layoutCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50) collectionViewLayout:self.collectionViewLayout];
        _layoutCollectionView.backgroundColor = [UIColor whiteColor];
        _layoutCollectionView.delegate = self;
        _layoutCollectionView.dataSource = self;
    }
    return _layoutCollectionView;
}

- (NSMutableIndexSet *)allCellIdentife{
    
    if (!_allCellIdentife) {
        _allCellIdentife = [NSMutableIndexSet indexSet];
    }
    return _allCellIdentife;
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


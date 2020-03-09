//
//  DDCollectionCycleController.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/26.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCollectionCycleController.h"
#import "DDCollectionCycleBackView.h"
#import "DDCollectionViewCycleCell.h"

@interface DDCollectionCycleController ()<DDCollectionCycleDelegate>

@property (nonatomic, strong) DDCollectionCycleBackView *cycleCollectionView;

@property (nonatomic, strong) NSMutableArray *allDataArr;

@end

@implementation DDCollectionCycleController
{
    NSString *tempContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    
    self.navigationItem.title = @"轮播图";
    // Do any additional setup after loading the view.
}

//构造数据
- (void)requestData{
    
    NSDictionary *dict = @{@"img":@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1033149918,3501644543&fm=26&gp=0.jpg",@"other":@"第一项"};
    NSDictionary *dict1 = @{@"img":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582880058590&di=53594705a5504fde6b98acebe0467ccf&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fsoftbbs%2F1001%2F14%2Fc0%2F2738692_1263465880033_1024x1024.jpg",@"other":@"第二项"};
    NSDictionary *dict2 = @{@"img":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582880058592&di=d64472950092117a75b2cf206940fd1d&imgtype=0&src=http%3A%2F%2Fimg8.zol.com.cn%2Fbbs%2Fupload%2F21909%2F21908582.jpg",@"other":@"第三项"};
    NSDictionary *dict3 = @{@"img":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582880058592&di=a384a4b24431d9400eb86f2e27917204&imgtype=0&src=http%3A%2F%2Fdik.img.kttpdq.com%2Fpic%2F45%2F31188%2Fe0c62a154c0bed1e.jpg",@"other":@"第四项"};
    NSDictionary *dict4 = @{@"img":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582880058591&di=3b83628242e9e765a0b6c7b06ba12dec&imgtype=0&src=http%3A%2F%2Fimg8.zol.com.cn%2Fbbs%2Fupload%2F18894%2F18893697.jpg",@"other":@"第五项"};
    
    NSArray *allData = @[dict,
                         dict1,
                         dict2,
                         dict3,
                         dict4
                         ];

    for (int m = 0; m < allData.count; m ++) {
        [self.allDataArr addObject:allData[m]];
    }
    
    [self buildCycleView];
}

- (void)buildCycleView{
    
    [self.view addSubview:self.cycleCollectionView];
    //赋值轮播图
    _cycleCollectionView.allDataArr = self.allDataArr;
    
}

#pragma DDCollectionCycleBackView delegate
- (UICollectionViewCell *)cycleCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    DDCollectionViewCycleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cycleItem" forIndexPath:indexPath];
    [cell reloadLabelContent:_allDataArr[indexPath.row] andIndexPathRow:indexPath.row];
    return cell;
    
}

- (void)cycleCollectionView:(UICollectionView *)collectionView didSelectItem:(id)selectItem{
    
    //当前点击的cell的数据
    NSLog(@"%@",selectItem);
    
}

/**
 初始话DDCollectionCycleBackView
 */
- (DDCollectionCycleBackView *)cycleCollectionView{
    
    if (!_cycleCollectionView) {
        //初始话并设置需要使用的cell
        //_cycleCollectionView的宽高就是cell的宽高
        _cycleCollectionView = [[DDCollectionCycleBackView alloc]initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, self.view.frame.size.width*9/16)];
        
        //cycleViewType:设置轮播图的样式
//        _cycleCollectionView.cycleViewType = DDCollectionCycleViewScale;
        
//        //scaleMultiple:cell缩小/放大的基本倍数
//        _cycleCollectionView.scaleMultiple = 0.6;
//
//        //scaleMultipleSub:左右两个cell的缩小的累计倍数
//        _cycleCollectionView.scaleMultipleSub = 0.6;
//
//        //contentOffsetMutiple:cell之间的横坐标的偏移指数
//        _cycleCollectionView.contentOffsetMutiple = 0.4;
//
//        //contentOffsetY:cell上下的偏移量
//        _cycleCollectionView.contentOffsetY = 0;

        //设置代理方法
        _cycleCollectionView.cycleDelegate =  self;
        
        //设置完样式及配置后开始加载
        [_cycleCollectionView buildCycleCollectionViewWithShowCellClass:[DDCollectionViewCycleCell class]];
        
    }
    return _cycleCollectionView;
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

# DDCollectionCycleView
CollectionView实现的一款轮播图,喜欢点赞
# 2020-02-28第一次编辑
# 使用说明
### 1.在需要使用的控制器中引入DDCollectionCycleBackView.h
### 2.遵循代理方法DDCollectionCycleDelegate
    - (UICollectionViewCell *)cycleCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
      
        DDCollectionViewCycleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cycleItem" forIndexPath:indexPath];           [cell reloadLabelContent:_allDataArr[indexPath.row] andIndexPathRow:indexPath.row];
        return cell;
        
    }

    - (void)cycleCollectionView:(UICollectionView *)collectionView didSelectItem:(id)selectItem{

        //当前点击的cell的数据
        NSLog(@"%@",selectItem);
        
    }

### 3.初始话界面
    - (void)buildCycleView{

        [self.view addSubview:self.cycleCollectionView];
        //赋值轮播图
        _cycleCollectionView.allDataArr = self.allDataArr;
    }
    
    /**
      初始话DDCollectionCycleBackView
    */
    //懒加载
    - (DDCollectionCycleBackView *)cycleCollectionView{
    
      if (!_cycleCollectionView) {
          //初始话并设置需要使用的cell
          //_cycleCollectionView的宽高就是cell的宽高
          _cycleCollectionView = [[DDCollectionCycleBackView alloc]initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, self.view.frame.size.width*9/16)];      

          //cycleViewType:设置轮播图的样式
            _cycleCollectionView.cycleViewType = DDCollectionCycleViewScale;

          //scaleMultiple:cell缩小/放大的基本倍数
          //_cycleCollectionView.scaleMultiple = 0.6;

          //scaleMultipleSub:控制界面的大小是scaleMultiple*scaleMultipleSub得出的即为缩小的最小倍数最大缩小的倍数为scaleMultiple
          //_cycleCollectionView.scaleMultipleSub = 0.6;

          //contentOffsetMutiple:cell之间的横坐标的偏移指数,即控制两个cell间距的指数,指数越小间距越大
          //_cycleCollectionView.contentOffsetMutiple = 0.4;

          //contentOffsetY:cell上下的偏移量,默认为0,意味着滑动的过程中都是居中展示的
          //_cycleCollectionView.contentOffsetY = 0;

          //设置代理方法
          _cycleCollectionView.cycleDelegate =  self;

          //设置完样式及配置后开始加载,将需要使用的cell传入
          [_cycleCollectionView buildCycleCollectionViewWithShowCellClass:[DDCollectionViewCycleCell class]];

      }
      
      return _cycleCollectionView;
      
    }


 #### 效果图,点击查看
![image](https://github.com/LuckDDS/DDCollectionCycleView/tree/master/AdvancePlan/AdvancePlan/1.jpg)
![jpg](https://github.com/LuckDDS/DDCollectionCycleView/tree/master/AdvancePlan/AdvancePlan/2.jpg)
![png](https://github.com/LuckDDS/DDCollectionCycleView/tree/master/AdvancePlan/AdvancePlan/3.png)

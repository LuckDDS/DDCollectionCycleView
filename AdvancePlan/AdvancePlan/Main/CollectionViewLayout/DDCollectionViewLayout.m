//
//  DDCollectionViewLayout.m
//  AdvancePlan
//
//  Created by 董德帅 on 2020/2/25.
//  Copyright © 2020 www.dong.com 董德帅. All rights reserved.
//

#import "DDCollectionViewLayout.h"

@implementation DDCollectionViewLayout
{
    //一行中cell的样式集合
    NSMutableArray *lineAttributes;
    
    //一行中cell的总宽度
    float cellsWidth;
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        lineAttributes = [NSMutableArray array];
        self.interitemSpacing = 10;
    }
    return self;
}

- (void)setInteritemSpacing:(float)interitemSpacing{
    _interitemSpacing = interitemSpacing;
    self.minimumInteritemSpacing = interitemSpacing;
}


//UICollectionViewLayoutAttributes控制的是所有的layout布局
//layoutAttributesForElementsInRect这个方法是通过rect的范围来获取UICollectionViewLayoutAttributes的,
//所以有一点是确定的它获取的数组一个界面的,不会出现下一行的某一个.获取的都是整行的数据
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    NSArray *array =  [[NSArray alloc]initWithArray:original copyItems:YES];
    NSMutableArray *allAttributes = [NSMutableArray arrayWithArray:array];
    if (self.layoutAlignment == UILayoutAlignmentDefault) {
        return allAttributes;
    }

    //当前cell的样式
    UICollectionViewLayoutAttributes *currentAttributes;
    //下一个cell的样式
    UICollectionViewLayoutAttributes *nextAttributes;

    //当前cell的Y坐标
    float currentY;
    //下一个cell的Y坐标
    float nextY;
    
    //正常情况下cell的Attributes是按顺序排的,如果出现问题请对allAttributes进行排序(sortAllAttributes:)
    //至少在我写的时候不排序是没问题的需要
    for (int m = 0; m < allAttributes.count; m ++)
    {
        //获取当前需要计算的Attributes
        currentAttributes = allAttributes[m];
        currentY = currentAttributes.frame.origin.y;
        //去除header和footer
        if (![currentAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]
            && ![currentAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionFooter])
        {
            //获取下一个Attributes
            nextAttributes = (m == (allAttributes.count -1)) ? nil : allAttributes[m + 1];
            
            nextY = nextAttributes == nil ? -1 : nextAttributes.frame.origin.y;
            
            //添加行数据
            [lineAttributes addObject:currentAttributes];
            
            //计算某行cell的总宽度
            cellsWidth += currentAttributes.size.width;
            
            //对比是否需要调整某行的布局
            if (currentY != nextY) {
                [self layoutAlignmentLineAttributes];
            }

        }
        
    }
    
    return allAttributes;
    
}

//调整行布局
- (void)layoutAlignmentLineAttributes{
    UICollectionViewLayoutAttributes *lastSubAttr;
    UICollectionViewLayoutAttributes *subAttr;
    float viewWidth = self.collectionView.frame.size.width;
    switch (self.layoutAlignment)
    {
        case UILayoutAlignmentLeft: case UILayoutAlignmentCenter:
            for (NSInteger m = 0; m < lineAttributes.count; m ++)
            {
                subAttr = lineAttributes[m];
                if (lastSubAttr)
                {
                    subAttr.frame = CGRectMake(CGRectGetMaxX(lastSubAttr.frame)+self.interitemSpacing, subAttr.frame.origin.y, subAttr.size.width, subAttr.size.height);
                    lastSubAttr = subAttr;
                }else{
                    if (self.layoutAlignment == UILayoutAlignmentLeft) {
                        subAttr.frame = CGRectMake(0, subAttr.frame.origin.y, subAttr.size.width, subAttr.size.height);
                        lastSubAttr = subAttr;
                    }else{
                        subAttr.frame = CGRectMake((viewWidth - cellsWidth - (lineAttributes.count-1)*_interitemSpacing)/2, subAttr.frame.origin.y, subAttr.size.width, subAttr.size.height);
                        lastSubAttr = subAttr;
                    }
                }
                
            }
            cellsWidth = 0;
            break;
        case UILayoutAlignmentRight:
            for (NSInteger m = lineAttributes.count - 1; m >= 0 ; m --)
            {
                subAttr = lineAttributes[m];
                if (lastSubAttr)
                {
                    subAttr.frame = CGRectMake(lastSubAttr.frame.origin.x - self.interitemSpacing - subAttr.size.width, subAttr.frame.origin.y, subAttr.size.width, subAttr.size.height);
                    lastSubAttr = subAttr;
                }else{
                    subAttr.frame = CGRectMake(viewWidth-subAttr.size.width, subAttr.frame.origin.y, subAttr.size.width, subAttr.size.height);
                    lastSubAttr = subAttr;
                }
            }

            break;
        case UILayoutAlignmentDefault:
            
            break;
        default:
            break;
    }
    [lineAttributes removeAllObjects];
}

- (void)sortAllAttributes:(NSMutableArray*)allAttributes{
    NSInteger cellNum = allAttributes.count;
    UICollectionViewLayoutAttributes *lastAttributes;
    UICollectionViewLayoutAttributes *currentAttributes;
    
    for (int m = 1; m < cellNum; m ++) {
        int n = m -1;
        currentAttributes = allAttributes[m];
        lastAttributes = allAttributes[n];
        UICollectionViewLayoutAttributes *temp;
        NSInteger currentRow = currentAttributes.indexPath.row;
        NSInteger lastRow = lastAttributes.indexPath.row;
        while (currentRow < lastRow) {
            temp = allAttributes[n+1];
            allAttributes[n+1] = allAttributes[n];
            allAttributes[n] = temp;
            n = n-1;
            lastAttributes = allAttributes[n];
            lastRow = lastAttributes.indexPath.row;
        }
        
    }

}

//使其滑动时调用重新布局layoutAttributesForElementsInRect:
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}
@end

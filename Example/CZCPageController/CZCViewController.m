//
//  CZCViewController.m
//  CZCPageController
//
//  Created by 2360219637@qq.com on 10/17/2019.
//  Copyright (c) 2019 2360219637@qq.com. All rights reserved.
//

#import "CZCViewController.h"
#import "GGJShopCouponCell.h"
#import "UIView+CZCSize.h"
#import "FirstController.h"
#import "SecondController.h"
#import "GGJShopNameCell.h"

static NSUInteger couponCellCount = 2;

@interface CZCViewController ()
@end

@implementation CZCViewController
{
    NSArray *segmentBarTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    segmentBarTitle = @[@"推荐", @"国际", @"经济", @"微信", @"QQ", @"朋友圈", @"长文字测试哈哈哈哈哈"];
    [self.collectionView registerClass:[GGJShopCouponCell class] forCellWithReuseIdentifier:NSStringFromClass([GGJShopCouponCell class])];
    [self.collectionView registerClass:[GGJShopNameCell class] forCellWithReuseIdentifier:NSStringFromClass([GGJShopNameCell class])];
    [self updateData];
    //支持下拉刷新
//    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
}

//- (void)loadData{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.collectionView.mj_header endRefreshing];
//        segmentBarTitle = @[@"推荐", @"国际"];
//        [self updateData];
//    });
//}

#pragma mark CZCPageControllerDelegate
/*
 * 子控制器
 */
- (NSArray<UIViewController<CZCScrollControllerDelegate> *> *)pageControllerWithSubControllers{
    NSMutableArray *subControllers = [NSMutableArray arrayWithObject:[FirstController new]];
    for (NSUInteger i = 0; i < segmentBarTitle.count-1; i++) {
        SecondController *secondtVC = [SecondController new];
        [subControllers addObject:secondtVC];
    }
    return subControllers;
}

/*
 * segmentBar所在的区
 */
- (NSUInteger)pageControllerWithSegmentBarFloatSection{
    return 2;
}

/*
 * segmentBar高度
 */
- (CGFloat)pageControllerWithSegmentBarHeight{
    return 40;
}

/*
 * segmentBar样式设置
 */
- (void)pageControllerWithConfigSegmenrBarAppearance{
    //item样式
    CZCSegmentBarItemTheme *itemTheme = [CZCSegmentBarItemTheme new];
    itemTheme.normalFont = [UIFont systemFontOfSize:14];
    itemTheme.selectedFont = [UIFont boldSystemFontOfSize:16];
    itemTheme.normalColor = [UIColor blackColor];
    itemTheme.selectedColor = [UIColor redColor];
    //bottomLine样式
    CZCSegmentBarBottomLineTheme *bottomLineTheme = [CZCSegmentBarBottomLineTheme new];
    bottomLineTheme.height = 3;
    bottomLineTheme.color = [UIColor redColor];
    
    self.segmentBar.itemTheme = itemTheme;
    self.segmentBar.bottomLineTheme = bottomLineTheme;
    self.segmentBar.itemAdjust =  CZCSegmentBarItemAdjustAverage;
    self.segmentBar.bottmLineAdjust = GGJSegmentBarBottomLineFollowTitle;
    self.segmentBar.itemSpacing = 30;
    self.segmentBar.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    self.segmentBar.titles = segmentBarTitle;
    self.segmentBar.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return couponCellCount;
    }
    else if (section == 1){
        return 1;
    }
    //需要调用父类(控制器容器的cell)
    return [super collectionView:collectionView numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GGJShopCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GGJShopCouponCell class]) forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 1){
        GGJShopNameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GGJShopNameCell class]) forIndexPath:indexPath];
        return cell;
    }
    //需要调用父类(控制器容器的cell)
    return [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(collectionView.width, 100);
    }
    else if (indexPath.section == 1){
       return CGSizeMake(collectionView.width, 50);
    }
    //需要调用父类(控制器容器的cell)
    return [super collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
}

@end

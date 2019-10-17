//
//  CZCPageController.m
//  CZCPageController
//
//  Created by chenzhichao on 2019/8/1.
//  Copyright © 2019 xiaojian. All rights reserved.
//

#import "CZCPageController.h"
#import "CZCSubControllerCell.h"
#import "UIView+CZCSize.h"
#import "CZCCommonCollectionView.h"


@interface CZCPageController ()
@property (nonatomic, strong) CZCCollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) CZCSubControllerCell *subControllerContainer;
@property (nonatomic, strong) UIScrollView *currentSubScrollView;
@property (nonatomic, strong) CZCSegmentBar *segmentBar;
@property (nonatomic, assign) NSUInteger floatSection;
@property (nonatomic, assign) NSUInteger floatSectionViewHeight;
@property (nonatomic, strong) NSArray<UIViewController<CZCScrollControllerDelegate> *> *subControllers;
@property (nonatomic, assign) CGFloat subCanScroll;
@end

@implementation CZCPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllSubViews];
}

- (void)addAllSubViews{
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
    self.segmentBar.frame = CGRectMake(0, 0, self.collectionView.width, self.floatSectionViewHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.floatSection) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                  withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])
                                                                                         forIndexPath:indexPath];
        [headerView addSubview:self.segmentBar];
        return headerView;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == self.floatSection) {
        return 1;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.floatSection) {
        CZCSubControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZCSubControllerCell class]) forIndexPath:indexPath];
        cell.controllers = self.subControllers;
        cell.delegate = self;
        self.subControllerContainer = cell;
        return cell;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.floatSection) {
        return CGSizeMake(collectionView.width, collectionView.height-self.floatSectionViewHeight);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == self.floatSection) {
        return CGSizeMake(collectionView.width, self.floatSectionViewHeight);
    }
    return CGSizeZero;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat mainScrollOffsetY = self.collectionView.contentOffset.y;
    UIView *floatSectionView = [self.collectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader
                                                                        atIndexPath:[NSIndexPath indexPathForItem:0 inSection:self.floatSection]];
    //滑动控制
    if (self.currentSubScrollView.contentOffset.y) {
        self.subCanScroll = YES;
        self.collectionView.contentOffset = CGPointMake(0, floatSectionView.top);
    }else{
        self.subCanScroll = (floatSectionView && floorf(mainScrollOffsetY) >= floorf(floatSectionView.top));
        if(self.subCanScroll) self.collectionView.contentOffset = CGPointMake(0, floatSectionView.top);
    }
    __weak typeof(self)weakSelf = self;
    self.subControllerContainer.currentViewController.contentOffsetY = ^(CGFloat offsetY) {
        if(!weakSelf.subCanScroll) weakSelf.currentSubScrollView.contentOffset = CGPointZero;
        if(offsetY <= 0) weakSelf.subCanScroll = NO;
    };
}

- (UIScrollView *)currentSubScrollView{
    return self.subControllerContainer.currentViewController.controllerMainScrollView;
}

#pragma mark CZCSegmentBarDelegate
- (void)didSelectItem:(CZCSegmentBar *)segmentBar index:(NSUInteger)index{
    [self.subControllerContainer scrollToIndex:index animated:YES];
}

#pragma mark CZCSubControllerCellDelegate
- (void)subControllerCell:(CZCSubControllerCell *)cell scrollDidEnd:(NSUInteger)index{
    [self.segmentBar selectIndex:index animate:YES];
}

- (void)subControllerCellDidScroll:(CZCSubControllerCell *)cell{
    UIView *floatSectionView = [self.collectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader
                                                                        atIndexPath:[NSIndexPath indexPathForItem:0 inSection:self.floatSection]];
    BOOL mainScrollView_locationMiddle = self.collectionView.contentOffset.y>=0 && self.collectionView.contentOffset.y < floatSectionView.top;
    if (mainScrollView_locationMiddle) {
        [self.subControllerContainer allSubControllersContentToTop];
    }
}


/*
 * 子控制器
 */
- (NSArray<UIViewController<CZCScrollControllerDelegate> *> *)pageControllerWithSubControllers{
    return nil;
}

/*
 * segmentBar所在的区
 */
- (NSUInteger)pageControllerWithSegmentBarFloatSection{
    return 0;
}

/*
 * segmentBar高度
 */
- (CGFloat)pageControllerWithSegmentBarHeight{
    return 0;
}

/*
 * segmentBar样式设置
 */
- (void)pageControllerWithConfigSegmenrBarAppearance{
    //子类实现
}

- (void)updateData{
    self.floatSection = [self pageControllerWithSegmentBarFloatSection];
    self.floatSectionViewHeight = [self pageControllerWithSegmentBarHeight];
    self.subControllers = [self pageControllerWithSubControllers];
    [self pageControllerWithConfigSegmenrBarAppearance];
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.segmentBar selectIndex:0 animate:NO];
        [self.subControllerContainer scrollToIndex:0 animated:NO];
    });
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[CZCCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[CZCSubControllerCell class] forCellWithReuseIdentifier:NSStringFromClass([CZCSubControllerCell class])];
    }
    return _collectionView;
}

- (CZCSegmentBar *)segmentBar{
    if (!_segmentBar) {
        _segmentBar = [CZCSegmentBar new];
        _segmentBar.delegate = self;
    }
    return _segmentBar;
}

@end

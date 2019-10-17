//
//  CZCSubControllerCell.m
//  CZCPageController
//
//  Created by chenzhichao on 2019/8/1.
//  Copyright © 2019 xiaojian. All rights reserved.
//

#import "CZCSubControllerCell.h"
#import "UIView+CZCSize.h"
#import "CZCCommonCollectionView.h"

@interface CZCControllerContainercCell : UICollectionViewCell
@property (nonatomic, strong) UIView *controllerView;
@end
@implementation CZCControllerContainercCell

- (void)setControllerView:(UIView *)controllerView{
    _controllerView = controllerView;
    [self.contentView addSubview:_controllerView];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_controllerView) {
        return;
    }
    _controllerView.frame = self.contentView.bounds;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    [_controllerView removeFromSuperview];
}

@end



@interface CZCSubControllerCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) CZCCustomCollectionView *collectionView;
@property (nonatomic, assign) NSUInteger selectIndex;
@end

@implementation CZCSubControllerCell

- (void)setControllers:(NSArray<UIViewController<CZCScrollControllerDelegate> *> *)controllers{
    _controllers = controllers;
    if (controllers.count == 0) {
        return;
    }
    self.currentViewController = [controllers firstObject];
    self.selectIndex = 0;
    [self.collectionView reloadData];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled{
    _scrollEnabled = scrollEnabled;
    self.collectionView.scrollEnabled = scrollEnabled;
}

- (void)scrollToIndex:(NSUInteger)index animated:(BOOL)animated{
    if(index > self.controllers.count-1) return;
    self.selectIndex = index;
    self.currentViewController = self.controllers[index];
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.width*index, self.collectionView.contentOffset.y)
                                 animated:animated];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.controllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZCControllerContainercCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZCControllerContainercCell class]) forIndexPath:indexPath];
    UIViewController *vc = self.controllers[indexPath.item];
    cell.controllerView = vc.view;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(subControllerCellDidScroll:)]) {
        [self.delegate subControllerCellDidScroll:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = self.collectionView.contentOffset.x;
    NSUInteger index = offsetX/self.collectionView.width;
    self.selectIndex = index;
    self.currentViewController = self.controllers[index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(subControllerCell:scrollDidEnd:)]) {
        [self.delegate subControllerCell:self scrollDidEnd:index];
    }
}

- (void)allSubControllersContentToTop{
    for (UIViewController<CZCScrollControllerDelegate> *vc in self.controllers) {
        if ([vc respondsToSelector:@selector(controllerMainScrollView)]) {
            [[vc controllerMainScrollView] setContentOffset:CGPointZero animated:NO];
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[CZCCustomCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[CZCControllerContainercCell class] forCellWithReuseIdentifier:NSStringFromClass([CZCControllerContainercCell class])];
        _collectionView.pagingEnabled = YES;
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

@end

//
//  CZCSegmentBar.m
//  CZCPageController
//
//  Created by chenzhichao on 2018/12/29.
//  Copyright © 2018年 chenzhichao. All rights reserved.
//

#import "CZCSegmentBar.h"
#import "CZCSegmentBarCell.h"
#import "UIView+CZCSize.h"
#import "CZCCommonCollectionView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface CZCSegmentBar()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) CZCCustomCollectionView *collectionView;
@property (nonatomic, strong) UIImageView *bottomLineImageView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) NSUInteger selectIndex;
@end

@implementation CZCSegmentBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        self.itemSpacing = 10;
        self.bottmLineAdjust = GGJSegmentBarBottomLineFollowTitle;
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.bottomLineImageView.height = self.bottomLineTheme.height;
    self.bottomLineImageView.top = self.collectionView.height-self.bottomLineTheme.height;
}

- (void)setTitles:(NSArray<NSString *> *)titles{
    if(!titles || titles.count==0) return;
    _titles = titles;
    [self layoutSegmentBarAndRefresh];
}

- (void)setItemTheme:(CZCSegmentBarItemTheme *)itemTheme{
    _itemTheme = itemTheme;
    [self.collectionView reloadData];
}

- (void)setBottomLineTheme:(CZCSegmentBarBottomLineTheme *)bottomLineTheme{
    _bottomLineTheme = bottomLineTheme;
    if (self.bottomLineTheme.color) {
        self.bottomLineImageView.backgroundColor = self.bottomLineTheme.color;
    }
    if (self.bottomLineTheme.image) {
        self.bottomLineImageView.image = self.bottomLineTheme.image;
        self.bottomLineImageView.contentMode = UIViewContentModeScaleToFill;
    }
    if (self.bottomLineTheme.cornerRadius) {
        self.bottomLineImageView.layer.cornerRadius = self.bottomLineTheme.cornerRadius;
        self.bottomLineImageView.layer.masksToBounds = YES;
    }
    if (self.bottomLineTheme.height) {
        self.bottomLineImageView.height = self.bottomLineTheme.height;
    }
}

- (void)layoutSegmentBar{
    if (![self allItemWidthIsLargeScreenWidth] && self.itemAdjust==CZCSegmentBarItemAdjustAverage) {
        _layout.minimumInteritemSpacing = 0;
        _layout.minimumLineSpacing = 0;
        _layout.sectionInset = UIEdgeInsetsZero;
    }else{
        _layout.minimumInteritemSpacing = self.itemSpacing;
        _layout.minimumLineSpacing = self.itemSpacing;
        _layout.sectionInset = self.contentEdgeInsets;
    }
}

- (void)layoutSegmentBarAndRefresh{
    [self layoutSegmentBar];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self selectIndex:0 animate:NO];
    });
}

- (void)selectIndex:(NSUInteger)index animate:(BOOL)animate{
    if(index >= self.titles.count) return;
    self.selectIndex = index;
    [self layoutSegmentBar];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:animate];
    [self.collectionView reloadData];
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf bottomLineScrollWithAnimation:animate];
        });
    });
}

- (void)bottomLineScrollWithAnimation:(BOOL)animation{
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectIndex inSection:0]];
    CGFloat titleW = [self.titles[self.selectIndex] sizeWithAttributes:@{NSFontAttributeName : self.itemTheme.selectedFont}].width;
    if (cell) {
        CGFloat animaDuation = animation ? 0.3 : 0.0;
        [UIView animateWithDuration:animaDuation animations:^{
            self.bottomLineImageView.width = self.bottmLineAdjust==GGJSegmentBarBottomLineFollowTitle ? titleW : cell.width;
            self.bottomLineImageView.centerX = cell.centerX;
        }];
    }else{ //cell为空（快速滑动）
        CGFloat lineX = self.contentEdgeInsets.left;
        for (NSUInteger i = 0 ; i < self.selectIndex; i++) {
            CGFloat titleW = [self.titles[i] sizeWithAttributes:@{NSFontAttributeName : self.itemTheme.normalFont}].width;
            lineX += (titleW + self.itemSpacing);
        }
        CGFloat lineW = [self.titles[self.selectIndex] sizeWithAttributes:@{NSFontAttributeName : self.itemTheme.selectedFont}].width;
        self.bottomLineImageView.left = lineX;
        self.bottomLineImageView.width = lineW;
    }
}

//所有item宽度是否大于屏幕宽度
- (BOOL)allItemWidthIsLargeScreenWidth{
    CGFloat totalW = self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    totalW += ([self allItemWidth] + (self.titles.count-1)*self.itemSpacing);
    return (totalW >= [UIScreen mainScreen].bounds.size.width);
}

- (CGFloat)allItemWidth{
    CGFloat totalW = 0;
    for (NSUInteger i = 0; i < self.titles.count; i++) {
        NSString *itemTitle = self.titles[i];
        UIFont *currentTitleFont = (i == self.selectIndex ? self.itemTheme.selectedFont : self.itemTheme.normalFont);
        CGFloat titleW = [itemTitle sizeWithAttributes:@{NSFontAttributeName : currentTitleFont}].width;
        totalW += titleW;
    }
    return totalW;
}

#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZCSegmentBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CZCSegmentBarCell class]) forIndexPath:indexPath];
    cell.title = self.titles[indexPath.item];
    cell.itemTheme = self.itemTheme;
    cell.isSelected = indexPath.item == self.selectIndex;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIFont *currentTitleFont = (indexPath.item == self.selectIndex ? self.itemTheme.selectedFont : self.itemTheme.normalFont);
    if (self.itemAdjust==CZCSegmentBarItemAdjustNone || [self allItemWidthIsLargeScreenWidth]) {
        NSString *title = self.titles[indexPath.item];
        CGFloat titleW = [title sizeWithAttributes:@{NSFontAttributeName : currentTitleFont}].width;
        return CGSizeMake(titleW, collectionView.frame.size.height);
    }
    CGFloat itemTitleW = [self.titles[indexPath.item] sizeWithAttributes:@{NSFontAttributeName : currentTitleFont}].width;
    itemTitleW += (kScreenW - [self allItemWidth])/self.titles.count;
    return CGSizeMake(itemTitleW, collectionView.size.height);
    //    return CGSizeMake([UIScreen mainScreen].bounds.size.width/self.titles.count, collectionView.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self selectIndex:indexPath.item animate:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItem:index:)]) {
        [self.delegate didSelectItem:self index:indexPath.item];
    }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[CZCCustomCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[CZCSegmentBarCell class] forCellWithReuseIdentifier:NSStringFromClass([CZCSegmentBarCell class])];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = self.itemSpacing;
        _layout.minimumLineSpacing = self.itemSpacing;
        _layout.sectionInset = self.contentEdgeInsets;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

- (UIImageView *)bottomLineImageView{
    if (!_bottomLineImageView) {
        _bottomLineImageView = [[UIImageView alloc] init];
        [self.collectionView addSubview:_bottomLineImageView];
    }
    return _bottomLineImageView;
}
@end


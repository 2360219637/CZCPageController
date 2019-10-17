//
//  CZCSegmentBar.h
//  CZCPageController
//
//  Created by chenzhichao on 2018/12/29.
//  Copyright © 2018年 chenzhichao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZCSegmentBarTheme.h"

typedef NS_ENUM(NSUInteger, CZCSegmentBarItemAdjust) {
    CZCSegmentBarItemAdjustNone = 0, //不做任何调整
    CZCSegmentBarItemAdjustAverage = 1, //不满一屏，多余间距平分
};

typedef NS_ENUM(NSUInteger, GGJSegmentBarBottomLineAdjust) {
    GGJSegmentBarBottomLineFollowTitle, //宽度跟随文字宽度
    GGJSegmentBarBottomLineFollowItem, //宽度跟随item宽度
};

@class CZCSegmentBar;

@protocol CZCSegmentBarDelegate <NSObject>
@optional
/*
 *点击了item
 */
- (void)didSelectItem:(CZCSegmentBar *)segmentBar index:(NSUInteger)index;
@end




@interface CZCSegmentBar : UICollectionReusableView
/*
 *数据源
 */
@property (nonatomic, strong) NSArray<NSString *> *titles;
/*
 *item设置
 */
@property (nonatomic, strong) CZCSegmentBarItemTheme *itemTheme;
/*
 *bottomLine设置
 */
@property (nonatomic, strong) CZCSegmentBarBottomLineTheme *bottomLineTheme;
/*
 *内容偏移量,默认(0, 10, 0, 10)
 */
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
/*
 *item间距 默认10
 */
@property (nonatomic, assign) CGFloat itemSpacing;

/*
 *item调整模式， 默认CZCSegmentBarItemAdjustNone
 */
@property (nonatomic, assign) CZCSegmentBarItemAdjust itemAdjust;
/*
 *bottomLine宽度适配 默认：GGJSegmentBarBottomLineFollowTitle
 */
@property (nonatomic, assign) GGJSegmentBarBottomLineAdjust bottmLineAdjust;
/*
 *代理
 */
@property (nonatomic, weak) id<CZCSegmentBarDelegate> delegate;
/*
 *选中index，是否有动画
 */
- (void)selectIndex:(NSUInteger)index animate:(BOOL)animate;
@end


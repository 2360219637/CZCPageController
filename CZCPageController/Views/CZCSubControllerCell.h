//
//  CZCSubControllerCell.h
//  CZCPageController
//
//  Created by chenzhichao on 2019/8/1.
//  Copyright © 2019 xiaojian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZCProtocol.h"

@class CZCSubControllerCell;
@protocol CZCSubControllerCellDelegate<NSObject>
@optional
/**
 *正在滑动
 */
- (void)subControllerCellDidScroll:(CZCSubControllerCell *)cell;
/*
 *滑动结束
 */
- (void)subControllerCell:(CZCSubControllerCell *)cell scrollDidEnd:(NSUInteger)index;
@end

@interface CZCSubControllerCell : UICollectionViewCell
/*
 *控制器数据源
 */
@property (nonatomic, strong) NSArray<UIViewController<CZCScrollControllerDelegate> *> *controllers;
/*
 *代理
 */
@property (nonatomic, weak) id<CZCSubControllerCellDelegate> delegate;
/*
 *是否允许滑动
 */
@property (nonatomic, assign) BOOL scrollEnabled;
/*
 *当前屏幕显示的控制器
 */
@property (nonatomic, strong) UIViewController<CZCScrollControllerDelegate> *currentViewController;
/*
 *选中的控制器索引
 */
@property (nonatomic, assign, readonly) NSUInteger selectIndex;
/*
 *滚动到index位置
 */
- (void)scrollToIndex:(NSUInteger)index animated:(BOOL)animated;

/**
 *内筒置顶
 */
- (void)allSubControllersContentToTop;
@end

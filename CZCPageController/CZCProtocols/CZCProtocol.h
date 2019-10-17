
//
//  CZCProtocol.h
//  CZCPageController
//
//  Created by chenzhichao on 2019/8/1.
//  Copyright © 2019 xiaojian. All rights reserved.
//

@protocol CZCScrollControllerDelegate <NSObject>
/*
 *当前控制器的TableView\CollectionView
 */
- (UIScrollView *)controllerMainScrollView;
/*
 *TableView\CollectionView偏移量
 */
@property (nonatomic, copy) void(^contentOffsetY) (CGFloat offsetY);
@end


@protocol CZCPageControllerDelegate <NSObject>

/*
 * 子控制器
 */
- (NSArray<UIViewController<CZCScrollControllerDelegate> *> *)pageControllerWithSubControllers;

/*
 * segmentBar所在的区 从0开始
 */
- (NSUInteger)pageControllerWithSegmentBarFloatSection;

/*
 * segmentBar高度
 */
- (CGFloat)pageControllerWithSegmentBarHeight;

/*
 * segmentBar样式设置
 */
- (void)pageControllerWithConfigSegmenrBarAppearance;

@end
